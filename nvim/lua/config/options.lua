-- Leader must be set before any plugin declares a mapping against it.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- kitty/kitty.conf sets JetBrainsMono Nerd Font, so glyphs are available.
-- Plugins read this flag to decide between icons and plain text.
vim.g.have_nerd_font = true

local options = {
  breakindent = true,
  clipboard = "unnamedplus",
  completeopt = "menu,menuone,noselect",
  confirm = true,
  cursorline = true,
  expandtab = true,
  ignorecase = true,
  inccommand = "split",
  laststatus = 3,
  list = true,
  mouse = "a",
  number = true,
  relativenumber = true,
  scrolloff = 8,
  shiftwidth = 2,
  showmode = false,
  sidescrolloff = 8,
  signcolumn = "yes",
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  tabstop = 2,
  termguicolors = true,
  undofile = true,
  updatetime = 250,
  wrap = false,
}

for option, value in pairs(options) do
  vim.opt[option] = value
end

vim.opt.listchars = { nbsp = "␣", tab = "» ", trail = "·" }

-- Silence "match N of M" completion chatter, which blink.cmp renders itself.
vim.opt.shortmess:append("c")
