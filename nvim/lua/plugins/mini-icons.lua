-- Route every folder icon through one highlight group, `MiniIconsFolder`,
-- which links to `Directory`.
--
-- mini.icons paints the generic folder with `MiniIconsAzure` — but that group
-- is shared by ~130 other entries, nearly all file types (mp4, zip, docx,
-- lua, ...). Recolouring it to match a theme's folders would drag all of those
-- along with it. Pointing directories at a group of their own keeps the two
-- apart, so a colorscheme only has to set `Directory` and both the folder
-- names and their icons follow.
--
-- lua/config/hacktober.lua sets that `Directory` colour (amber #d08949).

return {
  {
    "nvim-mini/mini.icons",
    opts = {
      -- The generic folder, i.e. anything not named below.
      default = {
        directory = { hl = "MiniIconsFolder" },
      },
      -- mini.icons ships ~68 recognised folder names. Most already land on a
      -- warm group under Hacktober (Green/Orange/Yellow/Cyan/Purple all map
      -- into the palette), so they're left alone and keep their distinct
      -- colour. These four are the only cold ones — Azure and Blue, both
      -- #5389c5 — so they join the rest of the folders instead.
      --
      -- Passing `hl` alone keeps each one's built-in glyph: mini.icons
      -- resolves the two independently (see H.resolve_icon_data).
      directory = {
        [".github"] = { hl = "MiniIconsFolder" },
        lua = { hl = "MiniIconsFolder" },
        test = { hl = "MiniIconsFolder" },
        tests = { hl = "MiniIconsFolder" },
      },
    },
    init = function()
      -- A link rather than a colour, so this file never has to know the
      -- palette — and so it keeps working for Black Metal and anything else
      -- ghostty is set to, not just the two hand-built themes.
      --
      -- `:colorscheme` clears links, and lua/config/ghostty.lua re-applies the
      -- colorscheme whenever ghostty's config is saved, so re-link on the
      -- event rather than once at startup.
      local function link()
        vim.api.nvim_set_hl(0, "MiniIconsFolder", { link = "Directory" })
      end
      vim.api.nvim_create_autocmd("ColorScheme", { callback = link })
      link()
    end,
  },
}
