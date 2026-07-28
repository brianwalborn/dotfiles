return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        component_separators = { left = "|", right = "|" },
        globalstatus = true,
        icons_enabled = vim.g.have_nerd_font,
        section_separators = "",
        theme = "tokyonight",
      },
      sections = {
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "diagnostics", "filetype" },
      },
    },
  },
}
