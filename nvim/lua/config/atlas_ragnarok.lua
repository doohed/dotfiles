-- Atlas Ragnarok — the palette behind ghostty's `theme = "Atlas Ragnarok"`,
-- one of the themes ghostty ships (Ghostty.app/Contents/Resources/ghostty/
-- themes/Atlas Ragnarok), not a custom file under ~/.config/ghostty/themes.
--
-- bg #000000 / fg #ffffff, and a deliberately narrow accent set: blue
-- #3b82f6 / #60a5fa / #93c5fd, mint #99ffe4 / #b3ffe4, coral #ff8080 /
-- #ff9999, and two greys #a0a0a0 / #b0b0b0. That's the whole theme — no
-- yellow, no green, no purple, three slots holding the same mint.
--
-- Same trick as lua/config/cobalt2.lua and lua/config/hacktober.lua: there is
-- no Atlas Ragnarok plugin for neovim, so the palette is registered as an
-- extra tokyonight "style". Every highlight group tokyonight already knows
-- about — treesitter, LSP semantic tokens, snacks, noice, bufferline,
-- lualine, blink, trouble, gitsigns — gets Atlas Ragnarok colors for free.
--
-- Nothing loads this on its own: config/ghostty.lua calls `M.load()` when
-- ghostty's config says `theme = "Atlas Ragnarok"`.

local M = {}

-- The accent slots below are ghostty's Atlas Ragnarok palette verbatim. The
-- greys (bg_highlight, fg_gutter, comment) are not in that palette — a
-- terminal theme only has to define 16 colors plus bg/fg, while an editor
-- needs a structural ramp — so they're derived from bg and fg here. Contrast
-- against bg #000000 is noted where it matters.
--
-- The narrow palette is the whole design problem: with one warm hue and one
-- cool one, syntax has to be separated by *lightness* rather than by hue.
-- Hence the three blues doing three different jobs (keyword / function /
-- number) and the two mints (string / property).
local atlas = {
  bg = "#000000", -- editor background (transparent below, so rarely seen)
  bg_dark = "#000000", -- sidebars, statusline, popups
  bg_dark1 = "#000000",
  -- CursorLine / CursorColumn. Pure black leaves nowhere darker to go, so the
  -- current line is marked by a blue-tinted lift instead — the same hue
  -- family as the selection below, a quarter of the way there.
  bg_highlight = "#111a2b",

  fg = "#ffffff", -- normal text, @variable
  fg_dark = "#b0b0b0", -- statusline / message text (palette slot 12)
  fg_gutter = "#434b57", -- line numbers, indent guides, whitespace

  -- The palette's dim grey #505050 sits at 2.6:1 on black, which is too faint
  -- to read a sentence in. This is 4.6:1 and tinted toward the blue so
  -- comments still read as part of the theme rather than as plain grey.
  comment = "#6b7787", -- comments

  blue = "#60a5fa", -- functions, titles, directories (8.3:1)
  blue0 = "#1e3a5f", -- search background — ghostty's own selection-background
  blue1 = "#99ffe4", -- types, Special
  blue2 = "#60a5fa", -- diagnostics: info
  blue5 = "#b0b0b0", -- operators, punctuation
  blue6 = "#93c5fd", -- regexes
  blue7 = "#16243a", -- diff change

  -- Keywords take the theme's signature blue — the one ghostty also uses for
  -- the cursor. Darker than the function blue (5.7:1 vs 8.3:1), so keywords
  -- recede and the names you're scanning for stand out.
  cyan = "#3b82f6", -- keywords
  purple = "#3b82f6", -- @keyword
  magenta = "#3b82f6", -- statements, @keyword.function, string escapes
  magenta2 = "#ff9999",

  -- Atlas Ragnarok has no green; slots 2, 6 and 14 are all the same mint.
  -- Strings get it at full strength and properties get the lighter one, which
  -- is the only way to tell the two apart in this palette.
  green = "#99ffe4", -- strings
  green1 = "#b3ffe4", -- properties, struct members
  green2 = "#99ffe4", -- diff add
  teal = "#99ffe4", -- diagnostics: hint

  orange = "#93c5fd", -- constants, numbers, booleans (the palest blue)

  -- The one color here that isn't in ghostty's palette, and the one
  -- compromise in the file. Atlas Ragnarok's only warm hue is the coral that
  -- errors already use, so a palette-pure warning would be #ff9999 —
  -- indistinguishable from an error at a glance, which is the one thing a
  -- diagnostic color has to do. This is that coral walked toward amber: still
  -- warm, still clearly not blue or mint, but obviously not the error red.
  -- Swap it to "#ff9999" if you'd rather the theme use nothing off-palette.
  yellow = "#e5a06b", -- diagnostics: warning

  red = "#ff9999", -- `this` / `self` and friends
  red1 = "#ff8080", -- diagnostics: error

  dark3 = "#505050", -- NonText, SpecialKey (palette slot 8)
  dark5 = "#5a6472", -- Conceal
  terminal_black = "#505050",

  git = { add = "#99ffe4", change = "#60a5fa", delete = "#ff8080" },
}

-- The exact 16 ANSI colors from ghostty's "Atlas Ragnarok" theme, so
-- `:terminal` stays identical to the outer ghostty window. tokyonight derives
-- its own (brightened) set from the palette, so `terminal_colors` is off
-- below and these are pinned by hand instead.
--
-- Worth knowing when reading them: this theme does not use the ANSI slots the
-- way their names suggest. Slot 3 ("yellow") is blue, slot 4 ("blue") is
-- grey, slot 5 ("magenta") is blue, and 2/6/14 are all the same mint.
local ansi = {
  [0] = "#000000",
  [1] = "#ff8080",
  [2] = "#99ffe4",
  [3] = "#2563eb",
  [4] = "#a0a0a0",
  [5] = "#3b82f6",
  [6] = "#99ffe4",
  [7] = "#ffffff",
  [8] = "#505050",
  [9] = "#ff9999",
  [10] = "#b3ffe4",
  [11] = "#60a5fa",
  [12] = "#b0b0b0",
  [13] = "#93c5fd",
  [14] = "#99ffe4",
  [15] = "#ffffff",
}

---@param transparent boolean let ghostty's background-opacity show through
function M.load(transparent)
  -- Register the palette as a style before anything loads it. Extending the
  -- `night` palette means any slot tokyonight adds later still has a sane
  -- value instead of erroring out.
  require("tokyonight.colors").styles.atlas_ragnarok = function()
    return vim.tbl_deep_extend("force", require("tokyonight.colors").styles.night, atlas)
  end

  require("tokyonight").setup({
    style = "atlas_ragnarok",
    transparent = transparent,
    terminal_colors = false,
    styles = {
      comments = { italic = true },
      keywords = { italic = false },
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(hl, c)
      -- "Where you are" runs on the blues, matching ghostty: the cursor is
      -- ghostty's own cursor-color / cursor-text pair, and the line number,
      -- bracket match and current search hit use the lighter blue so they
      -- stay legible against black.
      hl.Cursor = { fg = "#ffffff", bg = "#3b82f6" }
      hl.lCursor = { fg = "#ffffff", bg = "#3b82f6" }
      hl.CursorIM = { fg = "#ffffff", bg = "#3b82f6" }
      hl.CursorLineNr = { fg = "#60a5fa", bold = true }
      hl.MatchParen = { fg = "#60a5fa", bold = true }
      hl.IncSearch = { fg = "#000000", bg = "#60a5fa" }
      -- ghostty's own selection-background, so a visual selection in neovim
      -- and one in the shell next to it are the same color. White text on it
      -- is 11.5:1.
      hl.Visual = { bg = "#1e3a5f" }
      hl.VisualNOS = { bg = "#1e3a5f" }
      -- Parameters are plain text, not a fourth shade of blue.
      hl["@variable.parameter"] = { fg = c.fg_dark }
      -- Folders, on the theme's function blue. Folder *icons* follow along:
      -- lua/plugins/mini-icons.lua links MiniIconsFolder to this group.
      -- Snacks' picker and explorer link SnacksPickerDirectory here too.
      hl.Directory = { fg = "#60a5fa" }
      -- Dashboard art (lua/plugins/dashboard.lua). Snacks links
      -- SnacksDashboardHeader to Title, which is the same blue as the folders
      -- directly below it. Mint instead — the theme's other signature color —
      -- so the art and the explorer don't blur into one block of blue.
      hl.SnacksDashboardHeader = { fg = "#99ffe4" }

      -- Cmdline, in the palest blue. Two sets of groups, because what you
      -- actually see depends on whether noice is running:
      --   MsgArea      is vim's own ":" line and message area at the bottom
      --   NoiceCmdline is noice's replacement for that same bottom line
      --   NoiceCmdlinePopup* is the centred palette LazyVim turns ":" into
      --                (`presets.command_palette = true`)
      -- Setting all of them means the colour holds whether noice is enabled,
      -- disabled, or falling back mid-startup.
      --
      -- noice registers its own groups with `default = true`, so these
      -- explicit values win regardless of load order.
      local sky = "#93c5fd"
      hl.MsgArea = { fg = sky }
      hl.NoiceCmdline = { fg = sky }
      hl.NoiceCmdlinePopup = { fg = sky }
      hl.NoiceCmdlineIcon = { fg = sky }
      hl.NoiceCmdlinePopupBorder = { fg = sky }
      hl.NoiceCmdlinePopupTitle = { fg = sky }
      -- `/` and `?` search too. These default to DiagnosticSignWarn (the
      -- amber above); sky keeps the whole cmdline one colour. Note
      -- `presets.bottom_search` is on, so search renders on the bottom line
      -- rather than in the palette — NoiceCmdline above already covers the
      -- text, and this is the leading `/` icon.
      hl.NoiceCmdlineIconSearch = { fg = sky }
      hl.NoiceCmdlinePopupBorderSearch = { fg = sky }
      -- Not touched: Search / IncSearch / CurSearch, which highlight the
      -- matches in the buffer rather than the cmdline. Those stay on the
      -- theme's blue so a hit is still easy to spot.
    end,
  })

  vim.cmd.colorscheme("tokyonight")
  for slot, color in pairs(ansi) do
    vim.g["terminal_color_" .. slot] = color
  end
end

return M
