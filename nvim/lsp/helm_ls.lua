return {
  cmd = { "helm_ls", "serve" },
  filetypes = { "helm" },
  root_markers = { "Chart.yaml" },
  settings = {
    ["helm-ls"] = {
      -- helm_ls can spawn its own nested yamlls; ours already covers plain YAML
      -- and the nested one double-reports on templated files.
      yamlls = { enabled = false },
    },
  },
}
