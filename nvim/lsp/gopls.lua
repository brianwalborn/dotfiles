-- Uses the gopls already installed in ~/go/bin rather than a mason copy.
return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gosum", "gotmpl", "gowork" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      codelenses = { test = true, tidy = true },
      hints = {
        assignVariableTypes = true,
        constantValues = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      staticcheck = true,
      usePlaceholders = true,
    },
  },
}
