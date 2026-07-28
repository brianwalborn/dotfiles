return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufNewFile", "BufReadPre" },
    opts = {
      on_attach = function(buffer)
        local gitsigns = require("gitsigns")

        local function map(mode, keys, action, description)
          vim.keymap.set(mode, keys, action, { buffer = buffer, desc = "Git: " .. description })
        end

        map("n", "<leader>gb", gitsigns.blame_line, "Blame line")
        map("n", "<leader>gd", gitsigns.diffthis, "Diff this")
        map("n", "<leader>gp", gitsigns.preview_hunk, "Preview hunk")
        map("n", "<leader>gr", gitsigns.reset_hunk, "Reset hunk")
        map("n", "<leader>gs", gitsigns.stage_hunk, "Stage hunk")
        map("n", "[h", function()
          gitsigns.nav_hunk("prev")
        end, "Previous hunk")
        map("n", "]h", function()
          gitsigns.nav_hunk("next")
        end, "Next hunk")
      end,
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        changedelete = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        untracked = { text = "┆" },
      },
    },
  },
}
