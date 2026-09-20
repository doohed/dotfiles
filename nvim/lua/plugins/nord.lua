-- Disabled: superseded by Cobalt2 in colorscheme.lua.
-- Flip `enabled` back to true (and disable tokyonight) to return to nord.
return {
  {
    "shaunsingh/nord.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.nord_disable_background = true
      vim.g.nord_borders = true
      vim.cmd("colorscheme nord")
    end,
  },
}
