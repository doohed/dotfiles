-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>ai", function()
  require("ollama").prompt()
end, { desc = "Ollama prompt" })

vim.keymap.set("v", "<leader>ai", function()
  require("ollama").prompt()
end, { desc = "Ollama prompt (selection)" })
