-- Server definitions live in nvim/lsp/*.lua, which Neovim 0.11+ discovers on the
-- runtimepath automatically (:help lsp-config), so nvim-lspconfig is not needed.
local servers = {
  "dockerls",
  "eslint",
  "gopls",
  "helm_ls",
  "lua_ls",
  "pyright",
  "terraformls",
  "vtsls",
  "yamlls",
}

-- gopls is intentionally absent: it already lives in ~/go/bin and mason would
-- shadow it with a second copy.
local tools = {
  "dockerfile-language-server",
  "eslint-lsp",
  "goimports",
  "helm-ls",
  "lua-language-server",
  "prettierd",
  "pyright",
  "ruff",
  "shfmt",
  "stylua",
  "terraform-ls",
  -- Required by nvim-treesitter's main branch to compile parsers.
  "tree-sitter-cli",
  "vtsls",
  "yaml-language-server",
}

local function configure_diagnostics()
  vim.diagnostic.config({
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "E",
        [vim.diagnostic.severity.HINT] = "H",
        [vim.diagnostic.severity.INFO] = "I",
        [vim.diagnostic.severity.WARN] = "W",
      },
    },
    virtual_text = { source = "if_many" },
  })
end

local function configure_keymaps()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    desc = "Bind LSP keys only in buffers that have a server attached",
    callback = function(event)
      local function map(keys, action, description)
        vim.keymap.set("n", keys, action, { buffer = event.buf, desc = "LSP: " .. description })
      end

      map("<leader>ca", vim.lsp.buf.code_action, "Code action")
      map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
      map("K", vim.lsp.buf.hover, "Hover documentation")
      map("gD", vim.lsp.buf.declaration, "Go to declaration")
      map("gd", "<cmd>Telescope lsp_definitions<cr>", "Go to definition")
      map("gi", "<cmd>Telescope lsp_implementations<cr>", "Go to implementation")
      map("gr", "<cmd>Telescope lsp_references<cr>", "List references")
      map("gt", "<cmd>Telescope lsp_type_definitions<cr>", "Go to type definition")
    end,
  })
end

return {
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
    },
    lazy = false,
    config = function()
      -- mason.setup() prepends its bin directory to PATH, so it has to run before
      -- any server is enabled.
      require("mason").setup()
      require("mason-tool-installer").setup({ ensure_installed = tools, run_on_start = true })

      configure_diagnostics()
      configure_keymaps()

      -- Advertise blink.cmp's extra completion capabilities to every server, merged
      -- on top of Neovim's own defaults.
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(nil, true),
      })

      vim.lsp.enable(servers)
    end,
  },
}
