return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    -- Loaded eagerly rather than on InsertEnter: the LSP spec needs its capability
    -- table at startup to hand to vim.lsp.config.
    lazy = false,
    version = "1.*",
    opts = {
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
      },
      -- <C-y> accepts, <C-n>/<C-p> cycle, <C-e> dismisses. Tab stays a tab.
      keymap = { preset = "default" },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
}
