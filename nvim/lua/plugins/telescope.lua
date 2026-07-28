return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      { "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Find diagnostics" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep files" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find help" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find keymaps" },
      { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume last picker" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep word under cursor" },
    },
    opts = {
      defaults = {
        -- These repos vendor dependencies; searching them is never useful.
        file_ignore_patterns = { "%.git/", "node_modules/", "vendor/" },
        layout_strategy = "flex",
        path_display = { "truncate" },
      },
      pickers = {
        find_files = { hidden = true },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")

      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
