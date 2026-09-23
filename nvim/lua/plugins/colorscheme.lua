-- The colorscheme isn't picked here — it's read out of ghostty's own config
-- by lua/config/ghostty.lua, so `theme = ...` in ~/.config/ghostty/config is
-- the single source of truth for both. These specs just install the plugins
-- that module knows how to drive; saving ghostty's config repaints running
-- neovim instances too, and `:GhosttyTheme` re-syncs by hand.

return {
  -- Currently active: ghostty is on `theme = Black Metal (Bathory)`, and this
  -- plugin ships the same palette (bg #000000, fg #c1c1c1, accents #fbcb97 /
  -- #e78a53) as `bathory`. Every other Black Metal variant ghostty offers has
  -- a matching palette here, so switching between them needs no change.
  {
    "metalelf0/black-metal-theme-neovim",
    lazy = false,
    priority = 1000,
  },

  -- Host for the palettes that have no neovim plugin of their own, each
  -- registered as an extra tokyonight style and each built in lua/config/:
  -- cobalt2.lua, hacktober.lua, atlas_ragnarok.lua, noctis_obscuro.lua. Set
  -- ghostty to `theme = Cobalt2`, `theme = Hacktober`, `theme = "Atlas
  -- Ragnarok"` or `theme = "Noctis Obscuro"` and the matching one loads.
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },

  -- tell LazyVim which colorscheme to use
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("config.ghostty").setup()
      end,
    },
  },
}
