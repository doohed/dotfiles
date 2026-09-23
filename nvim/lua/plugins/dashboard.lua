-- Dashboard header.
--
-- Replaces LazyVim's own "LAZYVIM" block (lua/lazyvim/plugins/ui.lua:305).
-- The spec below deep-merges into that one, so only the header changes and
-- the keys/actions LazyVim defines are left alone.
--
-- Every line is padded to the same width with U+2800 (braille blank), the
-- same character the art already uses for its own empty cells. Snacks centres
-- each text item independently (see D:align in snacks/dashboard.lua), so
-- ragged lines would each get centred on their own and the art would shear.
--
-- Colour is not set here; each hand-built palette in lua/config/ paints
-- SnacksDashboardHeader itself — hacktober.lua rust #c75a22,
-- atlas_ragnarok.lua mint #99ffe4, noctis_obscuro.lua blue #49ace9.
-- tokyonight drives that group from its `blue` slot by default.

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⠤⣶⡶⠦⢤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⢖⣯⠿⠂⠈⡀⠐⠢⡀⠒⠈⠑⢦⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠞⣵⠟⠁⠀⠀⠀⢱⠀⠀⠑⣄⠀⠘⢗⠝⣦⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣏⢀⡇⢰⠀⠀⠀⠀⢨⢀⡀⠀⠘⣗⢤⣼⣧⡞⣦⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⡿⣟⠙⣇⠀⢸⠀⠀⢸⡆⢣⠀⠀⠙⣿⡷⣿⠛⣾⡆⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⡶⣦⡀⠀⠀⠀⢰⣿⣿⢡⡏⠑⡷⠃⠰⠀⠀⢸⡏⣸⣀⢔⣖⣿⡇⢯⢢⠸⣿⣆⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣟⡼⢃⡟⠀⠀⢠⣿⣿⢸⢸⣿⠔⡃⠀⡇⢠⠉⢺⢺⣼⡷⠓⠚⣻⣿⡼⡈⢢⠹⣼⡆⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠙⠛⣋⡛⠀⠀⣸⢣⡿⢸⢸⣿⣤⣇⢠⣇⣎⣤⣟⣦⣽⣇⡀⠀⡇⣟⣇⢳⡈⢣⡹⡟⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠐⠿⠇⠀⠀⡟⣼⢧⢸⡞⣿⡽⣿⣟⠛⠋⠉⣿⣿⡆⡿⠃⠀⢰⣷⢽⢸⢠⣦⣹⡺⣶⣖⡾⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢰⣦⣠⣿⣻⣼⣿⣹⣹⣇⡻⡟⠀⠀⠀⣘⢙⣃⣷⠃⢠⣾⣷⣿⢸⣿⣿⡼⡿⡄⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⣡⣾⢿⣿⣿⣿⣿⣿⣟⠃⠀⣀⠀⠺⠻⣻⡇⠀⡽⣿⣿⣿⣾⣿⣿⣿⣿⡇⠀⠀⠀
⣶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠿⠿⠾⠿⠿⠾⢟⣟⣿⣿⣷⣶⣶⣶⡟⢡⢃⣴⣷⣿⣿⣿⣿⣿⣾⡿⡻⠁⠀⠀⠀
⢸⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣟⣿⠟⠛⣹⣻⣽⡶⠷⣿⡿⢏⣟⠝⠫⣹⡟⣯⠀⠀⠀⠀⠀⠀
⠀⢻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣷⣼⡽⣄⡨⠔⠋⣀⣔⣷⠥⠴⠶⠿⠶⢿⣄⠀⠀⠀⠀⠀
⠀⠈⣧⠀⠀⠀⠀⠀⠀⢐⣤⡀⠀⠀⠀⠀⠀⠀⢳⣿⣿⠺⡓⠫⣩⢿⣷⣶⣆⣀⣀⣤⣶⣾⣿⣿⡇⠀⠀⠀⠀
⠀⠀⠸⣆⠀⠀⠀⠀⠀⢺⣿⠹⣄⠀⠀⠀⠀⠀⠀⣿⣯⢀⣳⣜⠁⠘⡿⡇⡟⠉⡜⢠⣾⣷⣾⣿⡁⠀⠀⠀⠀
⠀⠀⠀⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡽⣛⣳⣦⣠⣇⣿⣧⣴⣷⣿⣏⣉⣩⣻⣿⡄⠀⠀⠀
⠀⠀⠀⠀⢻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⢿⣻⣴⣟⣿⣟⣻⣿⣿⣿⡿⣍⣻⣿⣿⣿⡇⠀⠀⠀
⠸⣿⣿⣿⣛⣓⣒⣒⣒⣒⣖⣖⣶⠶⠶⠦⠤⢤⣤⣤⣬⣾⣷⣾⣿⣶⠿⢿⠾⢿⣿⣿⣮⣿⣿⣿⣿⣷⣶⣶⣶
⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠙⠛⠛⠛⠛⠛⠛⠛⠛⠒⠷⠾⠾⠾⠟⠛⠛⠛⠛⠛⠋⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀]],
        },
      },
    },
  },
}
