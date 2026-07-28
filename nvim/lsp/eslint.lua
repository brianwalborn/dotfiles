-- The eslint server expects a workspaceFolder in its per-document settings; the
-- before_init hook below supplies it, which is otherwise the one thing
-- nvim-lspconfig did for us.
return {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
  },
  root_markers = {
    ".eslintrc",
    ".eslintrc.cjs",
    ".eslintrc.js",
    ".eslintrc.json",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    "eslint.config.cjs",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.ts",
    "package.json",
  },
  settings = {
    codeAction = {
      disableRuleComment = { enable = true, location = "separateLine" },
      showDocumentation = { enable = true },
    },
    codeActionOnSave = { enable = false, mode = "all" },
    -- Formatting is conform's job, via prettier.
    format = false,
    nodePath = "",
    onIgnoredFiles = "off",
    problems = { shortenToSingleLine = false },
    quiet = false,
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectories = { mode = "auto" },
  },
  before_init = function(_, config)
    local root = config.root_dir or vim.fn.getcwd()

    config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
      workspaceFolder = { name = vim.fn.fnamemodify(root, ":t"), uri = vim.uri_from_fname(root) },
    })
  end,
}
