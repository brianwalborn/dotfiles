-- prettierd is preferred over prettier for speed; the list falls back when only
-- one is present and stop_after_first keeps them from both running.
local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        desc = "Format buffer",
        mode = { "n", "v" },
      },
    },
    opts = {
      default_format_opts = { lsp_format = "fallback" },
      format_on_save = function(buffer)
        -- Autoformatting whole files fights with linter config in these repos, so
        -- it stays opt-in per filetype.
        local skipped = { helm = true, yaml = true }

        if skipped[vim.bo[buffer].filetype] then
          return nil
        end

        return { lsp_format = "fallback", timeout_ms = 1000 }
      end,
      formatters_by_ft = {
        css = prettier,
        go = { "goimports", "gofmt" },
        html = prettier,
        javascript = prettier,
        javascriptreact = prettier,
        json = prettier,
        jsonc = prettier,
        lua = { "stylua" },
        markdown = prettier,
        python = { "ruff_organize_imports", "ruff_format" },
        sh = { "shfmt" },
        terraform = { "terraform_fmt" },
        typescript = prettier,
        typescriptreact = prettier,
        yaml = prettier,
        zsh = { "shfmt" },
      },
    },
  },
}
