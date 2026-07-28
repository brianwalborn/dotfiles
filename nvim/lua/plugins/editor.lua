return {
  {
    "echasnovski/mini.nvim",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      -- Auto-close brackets and quotes. Commenting is not included here because
      -- Neovim ships gc/gcc natively since 0.10.
      require("mini.pairs").setup()

      -- sa/sd/sr to add, delete, replace surrounding pairs.
      require("mini.surround").setup()
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
      },
    },
  },
}
