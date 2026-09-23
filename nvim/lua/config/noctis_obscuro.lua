-- Noctis Obscuro — the palette behind ghostty's `theme = "Noctis Obscuro"`,
-- one of the themes ghostty ships (Ghostty.app/Contents/Resources/ghostty/
-- themes/Noctis Obscuro), not a custom file under ~/.config/ghostty/themes.
--
-- bg #031417 / fg #b2cacd: a near-black teal rather than a neutral dark, with
-- a full accent set on top — orange #e66533, mint #49e9a6, sand #e4b781, blue
-- #49ace9, pink #df769b, cyan #49d6e9. Ghostty ships eleven Noctis variants;
-- Obscuro is the darkest of the dark ones (Lux and Hibernus are the light
-- pair). They share this accent set and differ mostly in background, so this
-- file is a decent starting point for any of the others.
--
-- Same trick as lua/config/cobalt2.lua, lua/config/hacktober.lua and
-- lua/config/atlas_ragnarok.lua: there is no Noctis plugin for neovim, so the
-- palette is registered as an extra tokyonight "style". Every highlight group
-- tokyonight already knows about — treesitter, LSP semantic tokens, snacks,
-- noice, bufferline, lualine, blink, trouble, gitsigns — gets Noctis colors
-- for free.
--
-- Nothing loads this on its own: config/ghostty.lua calls `M.load()` when
-- ghostty's config says `theme = "Noctis Obscuro"`.

local M = {}

-- The accent slots below are ghostty's Noctis Obscuro palette verbatim. The
-- structural colours (the bg ramp, fg_gutter, comment) are not in that
-- palette — a terminal theme only has to define 16 colors plus bg/fg, while
-- an editor needs a full ramp — so they're derived here. Contrast against bg
-- #031417 is noted where it matters.
--
-- Unlike Atlas Ragnarok, this palette is wide enough that syntax can be
-- separated by hue, so each role gets its own colour rather than a shade of
-- the same one. The one rule worth keeping: every derived grey is tinted
-- teal, never neutral, or it reads as a smudge against this background.
local noctis = {
  bg = "#031417", -- editor background (transparent below, so rarely seen)
  bg_dark = "#020e10", -- sidebars, statusline, popups
  bg_dark1 = "#010a0c",
  bg_highlight = "#0a2125", -- CursorLine / CursorColumn

  fg = "#b2cacd", -- normal text, @variable
  fg_dark = "#9fb8bb", -- statusline / message text
  fg_gutter = "#3a5a5e", -- line numbers, indent guides, whitespace

  -- The palette's dim teal #47686c sits at 3.1:1 on this background, which is
  -- borderline for prose. This is 4.8:1 and still teal, so comments recede
  -- without disappearing.
  comment = "#66878b", -- comments

  blue = "#49ace9", -- functions, titles, directories (7.5:1)
  blue0 = "#1b4a5e", -- search background
  blue1 = "#49d6e9", -- types, Special
  blue2 = "#49ace9", -- diagnostics: info
  blue5 = "#9fb8bb", -- operators, punctuation
  blue6 = "#60dbeb", -- regexes
  blue7 = "#0d2a35", -- diff change

  -- Noctis' signature: keywords are the warm orange, which is the only warm
  -- thing on screen in a file that's otherwise teal, blue and mint. All three
  -- of tokyonight's keyword-ish slots get it so `Keyword`, `@keyword` and
  -- `Statement` can't drift apart.
  cyan = "#e66533", -- keywords
  purple = "#e66533", -- @keyword
  magenta = "#e66533", -- statements, @keyword.function, string escapes
  magenta2 = "#e798b3",

  green = "#49e9a6", -- strings
  green1 = "#60ebb1", -- properties, struct members
  green2 = "#49e9a6", -- diff add
  teal = "#49d6e9", -- diagnostics: hint

  orange = "#e4b781", -- constants, numbers, booleans (sand)
  yellow = "#e69533", -- diagnostics: warning

  -- Pink for `this` / `self`, keeping them off the keyword orange that
  -- surrounds them; the orange-red below is saved for errors.
  red = "#df769b",
  red1 = "#e66533", -- diagnostics: error

  dark3 = "#47686c", -- NonText, SpecialKey (palette slot 8)
  dark5 = "#5b797d", -- Conceal
  terminal_black = "#47686c",

  git = { add = "#49e9a6", change = "#e4b781", delete = "#e66533" },
}

-- The exact 16 ANSI colors from ghostty's "Noctis Obscuro" theme, so
-- `:terminal` stays identical to the outer ghostty window. tokyonight derives
-- its own (brightened) set from the palette, so `terminal_colors` is off
-- below and these are pinned by hand instead.
local ansi = {
  [0] = "#324a4d",
  [1] = "#e66533",
  [2] = "#49e9a6",
  [3] = "#e4b781",
  [4] = "#49ace9",
  [5] = "#df769b",
  [6] = "#49d6e9",
  [7] = "#b2cacd",
  [8] = "#47686c",
  [9] = "#e97749",
  [10] = "#60ebb1",
  [11] = "#e69533",
  [12] = "#60b6eb",
  [13] = "#e798b3",
  [14] = "#60dbeb",
  [15] = "#c1d4d7",
}

---@param transparent boolean let ghostty's background-opacity show through
function M.load(transparent)
  -- Register the palette as a style before anything loads it. Extending the
  -- `night` palette means any slot tokyonight adds later still has a sane
  -- value instead of erroring out.
  require("tokyonight.colors").styles.noctis_obscuro = function()
    return vim.tbl_deep_extend("force", require("tokyonight.colors").styles.night, noctis)
  end

  require("tokyonight").setup({
    style = "noctis_obscuro",
    transparent = transparent,
    terminal_colors = false,
    styles = {
      comments = { italic = true },
      keywords = { italic = false },
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(hl, c)
      -- The cursor is ghostty's own cursor-color / cursor-text pair, so the
      -- block sitting in neovim matches the one in the shell beside it.
      hl.Cursor = { fg = "#031417", bg = "#b2cacd" }
      hl.lCursor = { fg = "#031417", bg = "#b2cacd" }
      hl.CursorIM = { fg = "#031417", bg = "#b2cacd" }
      -- "Where you are" runs on the sand: warm against a cold background, and
      -- distinct from the orange that keywords are already using all over the
      -- buffer. 10.2:1 on bg.
      hl.CursorLineNr = { fg = "#e4b781", bold = true }
      hl.MatchParen = { fg = "#e4b781", bold = true }
      hl.IncSearch = { fg = "#031417", bg = "#e4b781" }
      -- ghostty's own selection-background, so a visual selection in neovim
      -- and one in the shell next to it are the same colour. The foreground
      -- over it is 8.8:1.
      hl.Visual = { bg = "#0d2a2f" }
      hl.VisualNOS = { bg = "#0d2a2f" }
      -- Parameters are plain text, not another accent.
      hl["@variable.parameter"] = { fg = c.fg_dark }
      -- Folders, on the theme's function blue. Folder *icons* follow along:
      -- lua/plugins/mini-icons.lua links MiniIconsFolder to this group.
      -- Snacks' picker and explorer link SnacksPickerDirectory here too.
      hl.Directory = { fg = "#49ace9" }
      -- Dashboard (lua/plugins/dashboard.lua), kept on the blues.
      --
      -- Only the art is a free choice here; the other two are a correction.
      -- tokyonight drives SnacksDashboardDesc from `cyan` and
      -- SnacksDashboardSpecial from `purple` (groups/snacks.lua), and this
      -- palette points all three keyword slots at Noctis' orange — so the
      -- menu labels came out the same orange as the art without anyone
      -- choosing that, and the whole dashboard read as one orange block.
      -- Pinning them here keeps the keyword mapping intact while leaving the
      -- dashboard cool; the sand `SnacksDashboardKey` and cyan
      -- `SnacksDashboardIcon` are the warm/bright accents against it.
      hl.SnacksDashboardHeader = { fg = "#49ace9" }
      hl.SnacksDashboardDesc = { fg = "#49ace9" }
      hl.SnacksDashboardSpecial = { fg = "#60b6eb" }

      -- Cmdline, in cyan. Two sets of groups, because what you actually see
      -- depends on whether noice is running:
      --   MsgArea      is vim's own ":" line and message area at the bottom
      --   NoiceCmdline is noice's replacement for that same bottom line
      --   NoiceCmdlinePopup* is the centred palette LazyVim turns ":" into
      --                (`presets.command_palette = true`)
      -- Setting all of them means the colour holds whether noice is enabled,
      -- disabled, or falling back mid-startup.
      --
      -- noice registers its own groups with `default = true`, so these
      -- explicit values win regardless of load order.
      local cyan = "#49d6e9"
      hl.MsgArea = { fg = cyan }
      hl.NoiceCmdline = { fg = cyan }
      hl.NoiceCmdlinePopup = { fg = cyan }
      hl.NoiceCmdlineIcon = { fg = cyan }
      hl.NoiceCmdlinePopupBorder = { fg = cyan }
      hl.NoiceCmdlinePopupTitle = { fg = cyan }
      -- `/` and `?` search too. These default to DiagnosticSignWarn (amber);
      -- cyan keeps the whole cmdline one colour. Note `presets.bottom_search`
      -- is on, so search renders on the bottom line rather than in the
      -- palette — NoiceCmdline above already covers the text, and this is the
      -- leading `/` icon.
      hl.NoiceCmdlineIconSearch = { fg = cyan }
      hl.NoiceCmdlinePopupBorderSearch = { fg = cyan }
      -- Not touched: Search / IncSearch / CurSearch, which highlight the
      -- matches in the buffer rather than the cmdline. Those stay on the
      -- theme's sand so a hit is still easy to spot.
    end,
  })

  vim.cmd.colorscheme("tokyonight")
  for slot, color in pairs(ansi) do
    vim.g["terminal_color_" .. slot] = color
  end
end

return M
