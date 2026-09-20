-- Hacktober — the palette behind ghostty's `theme = Hacktober`.
-- bg #141414 / fg #c9c9c9, and an autumn accent set: rust #c75a22,
-- amber #d08949, moss #42824a, tan #ac9166, slate blue #5389c5,
-- brick #b34538, rose #e795a5.
--
-- Same trick as lua/config/cobalt2.lua: there is no Hacktober plugin for
-- neovim, so the palette is registered as an extra tokyonight "style". Every
-- highlight group tokyonight already knows about — treesitter, LSP semantic
-- tokens, snacks, noice, bufferline, lualine, blink, trouble, gitsigns —
-- gets Hacktober colors for free.
--
-- Nothing loads this on its own: config/ghostty.lua calls `M.load()` when
-- ghostty's config says `theme = Hacktober`.

local M = {}

-- The accent slots below are ghostty's Hacktober palette verbatim. The greys
-- (bg_dark, bg_highlight, fg_gutter, comment) are not in that palette — a
-- terminal theme only has to define 16 colors plus bg/fg, while an editor
-- needs a structural ramp — so they're derived from bg and fg here. Contrast
-- against bg #141414 is noted where it matters.
local hacktober = {
  bg = "#141414", -- editor background (transparent below, so rarely seen)
  bg_dark = "#0f0f0f", -- sidebars, statusline, popups
  bg_dark1 = "#0b0b0b",
  bg_highlight = "#242424", -- CursorLine / CursorColumn

  fg = "#c9c9c9", -- normal text, @variable
  fg_dark = "#b3b0ab", -- statusline / message text
  fg_gutter = "#4a4542", -- line numbers, indent guides, whitespace

  -- Warm grey rather than the theme's #464444: that one sits at 1.9:1 on
  -- this background, which is unreadable for anything you actually want to
  -- read. This is 4.0:1 and tinted toward the tan so it still reads autumn.
  comment = "#867252", -- comments

  blue = "#5389c5", -- functions, titles, directories
  blue0 = "#1d3a5c", -- search background
  blue1 = "#ebc587", -- types, Special
  blue2 = "#5389c5", -- diagnostics: info
  blue5 = "#b3b0ab", -- operators, punctuation
  blue6 = "#ac9166", -- regexes
  blue7 = "#22262e", -- diff change

  cyan = "#c75a22", -- keywords
  purple = "#c75a22", -- @keyword
  magenta = "#c75a22", -- statements, @keyword.function, string escapes
  magenta2 = "#e795a5",

  -- The palette's two greens are the mossy #587744 and this brighter one.
  -- Strings are everywhere, so they get the brighter of the two (4.0:1 vs
  -- 3.6:1). Swap to #587744 for a more muted, closer-to-terminal look.
  green = "#42824a", -- strings
  green1 = "#ac9166", -- properties, struct members
  green2 = "#42824a", -- diff add
  teal = "#ac9166", -- diagnostics: hint

  orange = "#d08949", -- constants, numbers, booleans
  yellow = "#d08949", -- diagnostics: warning
  red = "#b34538", -- `this` / `self` and friends
  red1 = "#b33323", -- diagnostics: error

  dark3 = "#464444", -- NonText, SpecialKey
  dark5 = "#685941", -- Conceal
  terminal_black = "#464444",

  git = { add = "#42824a", change = "#d08949", delete = "#b33323" },
}

-- The exact 16 ANSI colors from ghostty's "Hacktober" theme, so `:terminal`
-- stays identical to the outer ghostty window. tokyonight derives its own
-- (brightened) set from the palette, so `terminal_colors` is off below and
-- these are pinned by hand instead.
local ansi = {
  [0] = "#191918",
  [1] = "#b34538",
  [2] = "#587744",
  [3] = "#d08949",
  [4] = "#206ec5",
  [5] = "#864651",
  [6] = "#ac9166",
  [7] = "#f1eee7",
  [8] = "#464444",
  [9] = "#b33323",
  [10] = "#42824a",
  [11] = "#c75a22",
  [12] = "#5389c5",
  [13] = "#e795a5",
  [14] = "#ebc587",
  [15] = "#ffffff",
}

---@param transparent boolean let ghostty's background-opacity show through
function M.load(transparent)
  -- Register the palette as a style before anything loads it. Extending the
  -- `night` palette means any slot tokyonight adds later still has a sane
  -- value instead of erroring out.
  require("tokyonight.colors").styles.hacktober = function()
    return vim.tbl_deep_extend("force", require("tokyonight.colors").styles.night, hacktober)
  end

  require("tokyonight").setup({
    style = "hacktober",
    transparent = transparent,
    terminal_colors = false,
    styles = {
      comments = { italic = true },
      keywords = { italic = false },
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(hl, c)
      -- Hacktober leans on its amber for "where you are": cursor, current
      -- line number, matching bracket, current search hit.
      hl.Cursor = { fg = c.bg, bg = "#d08949" }
      hl.lCursor = { fg = c.bg, bg = "#d08949" }
      hl.CursorIM = { fg = c.bg, bg = "#d08949" }
      hl.CursorLineNr = { fg = "#d08949", bold = true }
      hl.MatchParen = { fg = "#d08949", bold = true }
      hl.IncSearch = { fg = "#141414", bg = "#d08949" }
      -- A warm selection, so it reads as part of the autumn palette rather
      -- than the blue every other theme uses.
      hl.Visual = { bg = "#42341f" }
      hl.VisualNOS = { bg = "#42341f" }
      -- Parameters are plain text, not a third shade of amber.
      hl["@variable.parameter"] = { fg = c.fg_dark }
    end,
  })

  vim.cmd.colorscheme("tokyonight")
  for slot, color in pairs(ansi) do
    vim.g["terminal_color_" .. slot] = color
  end
end

return M
