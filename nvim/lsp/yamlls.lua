return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose" },
  root_markers = { ".git" },
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      -- Alphabetical key ordering is not a real diagnostic; it just adds noise to
      -- the argocd and helm value files.
      keyOrdering = false,
      schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
      validate = true,
    },
  },
}
