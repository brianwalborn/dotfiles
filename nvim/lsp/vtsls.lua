-- vtsls over ts_ls: the ud1 and greyhound repos are pnpm workspaces, and vtsls
-- handles project references and cross-package go-to-definition far better.
local inlay_hints = {
  enumMemberValues = { enabled = true },
  functionLikeReturnTypes = { enabled = true },
  parameterNames = { enabled = "literals" },
  parameterTypes = { enabled = true },
  propertyDeclarationTypes = { enabled = true },
  variableTypes = { enabled = false },
}

local preferences = {
  importModuleSpecifier = "non-relative",
  includePackageJsonAutoImports = "auto",
}

return {
  cmd = { "vtsls", "--stdio" },
  filetypes = {
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
  },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  settings = {
    javascript = { inlayHints = inlay_hints, preferences = preferences },
    typescript = { inlayHints = inlay_hints, preferences = preferences },
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = { enableServerSideFuzzyMatch = true },
      },
      -- These monorepos are large; a bigger memory ceiling avoids server restarts.
      tsserver = { maxTsServerMemory = 8192 },
    },
  },
}
