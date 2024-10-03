-- -- Configuration for neovim
local opt = vim.opt

-- -- Context
opt.colorcolumn = "80"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.textwidth = 0
opt.wrap = false


-- -- File types
opt.encoding = 'utf8'
opt.fileencoding = 'utf8'


-- -- Theme
opt.syntax = "ON"
opt.termguicolors = true


-- -- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.showcmd = true
--opt.showmatch = true


-- -- Whitespace
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2


-- -- Splits
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"


-- -- Autoformat
vim.b.autoformat = false


-- -- Other
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
-- Clipboard synchronysation (causes issue if V following by d is used to copy.
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
-- Ask for confirmation before quitting a file without saving
opt.confirm = true
-- Highlights line udner cursor
opt.cursorline = true
-- Fold characters
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
-- Default fold level
opt.foldlevel = 99
opt.foldmethod = "indent"
-- Format options
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.inccommand = "nosplit"
opt.jumpoptions = "view"
-- Always shows status line
opt.laststatus = 3
--opt.statusline = '%F %y %m %r %= %l,%c %p%%'
-- Shows invisible characters
opt.list = true
-- Transparency of popup menu
opt.pumblend = 10
opt.pumheight = 10
-- Saved options open buffer closing
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
-- Shifting "<<, >>" goes to nearest shiftwidth
opt.shiftround = true
-- Suppress some messages
--opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.linebreak = true
-- Taken care of by statusline
opt.showmode = false
opt.timeoutlen = vim.g.vscode and 1000 or 300
-- Remember undo after closing file
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.wildmode = "longest:full,full"
-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
-- Stores cursor info, command history, serach history and last help window
opt.shada = "'1000,<50,s10,h"
opt.hidden = true
