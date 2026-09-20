-- Cobalt2 — the palette behind ghostty's `theme = Cobalt2`.
-- bg #193549 / fg #ffffff, accents: yellow #ffc600, orange #ff9d00,
-- green #3ad900, pink #ff628c, mint #80ffbb, comment blue #0088ff.
--
-- There is no well-maintained Cobalt2 plugin for neovim, so the palette is
-- registered as an extra tokyonight "style" instead. That way every highlight
-- group tokyonight already knows about — treesitter, LSP semantic tokens,
-- snacks, noice, bufferline, lualine, blink, trouble, gitsigns — gets Cobalt2
-- colors for free.
--
-- Nothing loads this on its own: config/ghostty.lua calls `M.load()` when
-- ghostty's config says `theme = Cobalt2`.

local M = {}

-- Wes Bos' Cobalt2 colors, mapped onto tokyonight's palette slots.
-- The comment on each line is what tokyonight drives with that slot.
local cobalt2 = {
  bg = "#193549", -- editor background (transparent below, so rarely seen)
  bg_dark = "#15232d", -- sidebars, statusline, popups
  bg_dark1 = "#102331",
  bg_highlight = "#1f4662", -- CursorLine / CursorColumn

  fg = "#ffffff", -- normal text, @variable
  fg_dark = "#e1efff", -- statusline / message text
  fg_gutter = "#2f5872", -- line numbers, indent guides, whitespace

  comment = "#0088ff", -- comments

  blue = "#ffc600", -- functions, titles, directories
  blue0 = "#0050a4", -- search background
  blue1 = "#80ffbb", -- types, Special
  blue2 = "#9effff", -- diagnostics: info
  blue5 = "#e1efff", -- operators, punctuation
  blue6 = "#9effff", -- regexes
  blue7 = "#1f4662", -- diff change

  cyan = "#ff9d00", -- keywords
  purple = "#ff9d00", -- @keyword
  magenta = "#ff9d00", -- statements, @keyword.function, string escapes
  magenta2 = "#ff628c",

  green = "#3ad900", -- strings
  green1 = "#80ffbb", -- properties, struct members
  green2 = "#3ad900", -- diff add
  teal = "#80ffbb", -- diagnostics: hint

  orange = "#ff628c", -- constants, numbers, booleans
  yellow = "#ffc600", -- diagnostics: warning
  red = "#ff628c", -- `this` / `self` and friends
  red1 = "#f40e17", -- diagnostics: error

  dark3 = "#4b6479", -- NonText, SpecialKey
  dark5 = "#66869c", -- Conceal
  terminal_black = "#2f5872",

  git = { add = "#3ad900", change = "#ffc600", delete = "#ff628c" },
}

-- The exact 16 ANSI colors from ghostty's "Cobalt2" theme, so `:terminal`
-- stays identical to the outer ghostty window. tokyonight derives its own
-- (brightened) set from the palette, so `terminal_colors` is off below and
-- these are pinned by hand instead.
local ansi = {
  [0] = "#000000",
  [1] = "#ff0000",
  [2] = "#38de21",
  [3] = "#ffe50a",
  [4] = "#1460d2",
  [5] = "#ff005d",
  [6] = "#00bbbb",
  [7] = "#bbbbbb",
  [8] = "#555555",
  [9] = "#f40e17",
  [10] = "#3bd01d",
  [11] = "#edc809",
  [12] = "#5555ff",
  [13] = "#ff55ff",
  [14] = "#6ae3fa",
  [15] = "#ffffff",
}

---@param transparent boolean let ghostty's background-opacity show through
function M.load(transparent)
  -- Register the palette as a style before anything loads it. Extending the
  -- `night` palette means any slot tokyonight adds later still has a sane
  -- value instead of erroring out.
  require("tokyonight.colors").styles.cobalt2 = function()
    return vim.tbl_deep_extend("force", require("tokyonight.colors").styles.night, cobalt2)
  end

  require("tokyonight").setup({
    style = "cobalt2",
    transparent = transparent,
    terminal_colors = false,
    styles = {
      comments = { italic = true },
      keywords = { italic = false },
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(hl, c)
      -- Cobalt2 leans on its yellow for "where you are": cursor, current line
      -- number, matching bracket, current search hit.
      hl.Cursor = { fg = c.bg, bg = "#ffc600" }
      hl.lCursor = { fg = c.bg, bg = "#ffc600" }
      hl.CursorIM = { fg = c.bg, bg = "#ffc600" }
      hl.CursorLineNr = { fg = "#ffc600", bold = true }
      hl.MatchParen = { fg = "#ffc600", bold = true }
      hl.IncSearch = { fg = c.bg, bg = "#ffc600" }
      -- Cobalt2's selection color, used flat rather than blended into the bg.
      hl.Visual = { bg = "#0050a4" }
      hl.VisualNOS = { bg = "#0050a4" }
      -- Parameters are plain text in Cobalt2, not a third shade of yellow.
      hl["@variable.parameter"] = { fg = c.fg_dark }
    end,
  })

  vim.cmd.colorscheme("tokyonight")
  for slot, color in pairs(ansi) do
    vim.g["terminal_color_" .. slot] = color
  end
end

return M
