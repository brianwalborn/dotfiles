-- Neovim entry point. Load order matters: options sets the leader key, which
-- must exist before lazy.nvim reads any plugin keymaps.
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
