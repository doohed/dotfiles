-- Mirror ghostty's colorscheme in neovim.
--
-- ghostty can't push its theme into the programs running inside it, so this
-- runs the other way round: neovim reads the `theme = ...` line out of
-- ghostty's own config, maps it to the matching neovim colorscheme, and
-- watches the file so that saving a new theme there repaints every running
-- neovim within a heartbeat. Change the theme in one place, both follow.
--
-- Entry point is `setup()`, called from lua/plugins/colorscheme.lua as
-- LazyVim's `colorscheme` function. `:GhosttyTheme` re-syncs by hand and
-- reports what it found.

local M = {}

-- Follows the symlink into ~/Code/dotfiles, which is the file that actually
-- gets written when the theme changes — an fs watch on the symlink itself
-- would never fire.
M.config_file = vim.uv.fs_realpath(vim.fn.expand("~/.config/ghostty/config"))
  or vim.fn.expand("~/.config/ghostty/config")

-- ghostty runs at `background-opacity = 0.89`, so the editor background stays
-- unset and the window (and whatever is behind it) shows through. Set to
-- false if you ever take ghostty back to a solid background.
local TRANSPARENT = true

-- ghostty theme names that don't map onto a neovim colorscheme by name.
-- "Black Metal (X)" is derived automatically, so only the odd ones need an
-- entry. Keys are lowercased.
local aliases = {
  ["cobalt2"] = "cobalt2",
  ["hacktober"] = "hacktober",
  -- Same palette, lighter accent row (themes/Hacktober Lumen). The editor
  -- colorscheme is built off the base colors, which are unchanged, so it
  -- reuses the hacktober loader rather than needing its own.
  ["hacktober lumen"] = "hacktober",
  -- Both of these are themes ghostty ships rather than files under
  -- ~/.config/ghostty/themes — `ghostty +list-themes` lists them. Atlas
  -- Ragnarok is blue/mint/coral on pure black; Noctis Obscuro is the darkest
  -- of ghostty's eleven Noctis variants, a near-black teal.
  ["atlas ragnarok"] = "atlas-ragnarok",
  ["noctis obscuro"] = "noctis-obscuro",
  -- The plain "Black Metal" ghostty theme is its own palette upstream (dusty
  -- rose accents); darkthrone is the closest thing the plugin ships.
  ["black metal"] = "black-metal:darkthrone",
}

--- Loaders keyed by the name `resolve()` hands back. Each one owns the full
--- setup + load of its colorscheme, so the plugin specs only have to install.
local loaders = {}

loaders["black-metal"] = function(variant)
  local bm = require("black-metal")
  -- `:colorscheme <variant>` would work too, but every colors/*.lua in that
  -- plugin calls `setup({})` with no arguments, which resets the options
  -- below back to defaults. Driving setup + load directly keeps them.
  bm.setup({
    theme = variant,
    transparent = TRANSPARENT,
    plain_float = true, -- floats get borders, not a filled background
    term_colors = true, -- `:terminal` matches the outer ghostty window
  })
  bm.load(variant, "dark")
  -- black-metal applies its highlights directly and only assigns
  -- `vim.g.colors_name`, so it never goes through `:colorscheme` and the
  -- ColorScheme event never fires. The other loaders here do fire it. Emit it
  -- by hand so integrations that re-apply their own highlights on that event
  -- still run — lua/plugins/mini-icons.lua relinks MiniIconsFolder there.
  vim.api.nvim_exec_autocmds("ColorScheme", { pattern = vim.g.colors_name })
end

loaders["cobalt2"] = function()
  require("config.cobalt2").load(TRANSPARENT)
end

loaders["hacktober"] = function()
  require("config.hacktober").load(TRANSPARENT)
end

loaders["atlas-ragnarok"] = function()
  require("config.atlas_ragnarok").load(TRANSPARENT)
end

loaders["noctis-obscuro"] = function()
  require("config.noctis_obscuro").load(TRANSPARENT)
end

--- Read the active theme out of ghostty's config.
--- Later `theme =` lines win, matching ghostty's own last-one-wins parsing.
---@return string? theme name as ghostty spells it
function M.ghostty_theme()
  local fd = io.open(M.config_file, "r")
  if not fd then
    return nil
  end
  local theme
  for line in fd:lines() do
    -- Skip comments; ghostty only honours `#` at the start of a line.
    if not line:match("^%s*#") then
      local value = line:match("^%s*theme%s*=%s*(.-)%s*$")
      if value and value ~= "" then
        theme = value
      end
    end
  end
  fd:close()
  if not theme then
    return nil
  end
  theme = theme:gsub('^"(.*)"$', "%1")
  -- `theme = light:Foo,dark:Bar` picks a theme per system appearance.
  local split = theme:match("dark:%s*([^,]+)")
  if split then
    theme = vim.trim(split)
  end
  return theme
end

--- Map a ghostty theme name onto a loader.
---@param theme string?
---@return string? loader, string? argument
function M.resolve(theme)
  if not theme then
    return nil
  end
  local key = theme:lower()

  -- "Black Metal (Bathory)" -> the plugin's `bathory` palette.
  local variant = key:match("^black metal%s*%((.+)%)$")
  if variant then
    return "black-metal", (vim.trim(variant):gsub("%s+", "-"))
  end

  local alias = aliases[key]
  if alias then
    local name, arg = alias:match("^([^:]+):(.+)$")
    return name or alias, arg
  end

  -- Anything else: try a same-named colorscheme (`theme = tokyonight` etc).
  return "colorscheme", (key:gsub("%s+", "-"))
end

loaders["colorscheme"] = function(name)
  vim.cmd.colorscheme(name)
end

--- Apply the theme ghostty is currently set to.
---@param opts? { notify?: boolean } notify: announce the result
---@return boolean applied
function M.apply(opts)
  opts = opts or {}
  local theme = M.ghostty_theme()
  local name, arg = M.resolve(theme)
  local loader = name and loaders[name]

  if loader then
    local ok, err = pcall(loader, arg)
    if ok then
      if opts.notify then
        vim.notify(("ghostty theme: %s → %s"):format(theme, arg or name), vim.log.levels.INFO)
      end
      return true
    end
    vim.notify(
      ("ghostty theme %q has no neovim equivalent (%s)"):format(theme, err),
      vim.log.levels.WARN
    )
  elseif opts.notify then
    vim.notify(
      theme and ("ghostty theme %q is not mapped"):format(theme)
        or ("no `theme =` found in " .. M.config_file),
      vim.log.levels.WARN
    )
  end

  -- Fall back to the one theme that is definitely installed rather than
  -- leaving neovim on `default`.
  pcall(loaders["black-metal"], "bathory")
  return false
end

--- Re-apply whenever ghostty's config file is written.
function M.watch()
  local handle, timer
  local function arm()
    if handle then
      handle:stop()
    end
    handle = vim.uv.new_fs_event()
    if not handle then
      return
    end
    handle:start(M.config_file, {}, function(err)
      if err then
        return
      end
      -- Writes that go through a temp file + rename (which is what neovim
      -- itself does) invalidate the watch, so re-arm on every event. The
      -- timer also debounces the burst of events a single save produces.
      if timer then
        timer:stop()
        timer:close()
      end
      timer = vim.uv.new_timer()
      timer:start(120, 0, function()
        vim.schedule(function()
          arm()
          M.apply()
        end)
      end)
    end)
  end
  arm()
end

function M.setup()
  M.apply()
  M.watch()
  vim.api.nvim_create_user_command("GhosttyTheme", function()
    M.apply({ notify = true })
  end, { desc = "Re-sync the colorscheme with ghostty's config" })
end

return M
