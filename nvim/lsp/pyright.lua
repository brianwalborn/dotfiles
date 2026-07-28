return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "requirements.txt", "setup.py", "setup.cfg", ".git" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticSeverityOverrides = {
          -- ruff owns import hygiene, so pyright reporting it too is duplicate noise.
          reportUnusedImport = "none",
        },
        typeCheckingMode = "basic",
        useLibraryCodeForTypes = true,
      },
    },
  },
}
