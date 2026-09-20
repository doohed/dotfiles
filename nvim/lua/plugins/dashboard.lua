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
-- Colour is not set here: lua/config/hacktober.lua paints
-- SnacksDashboardHeader (rust #c75a22). Snacks links that group to Title by
-- default, which is why it arrived blue.

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
