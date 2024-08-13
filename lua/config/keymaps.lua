-- LEADERS ARE SET IN THE lazy.lua FILE


-- General mapping, non recursive
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = false })
end

-- General mapping, recursive
function rmap(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = false, silent = false })
end

-- Mapping for normal mode
function nmap(shortcut, command)
  map('n', shortcut, command)
end

-- Mapping for insert mode
function imap(shortcut, command)
  map('i', shortcut, command)
end

-- Mapping for visual and select mode
function vmap(shortcut, command)
  map('v', shortcut, command)
end

-- Mapping for visual mode
function xmap(shortcut, command)
  map('x', shortcut, command)
end

-- Mapping for select mode
function smap(shortcut, command)
  map('s', shortcut, command)
end

-- Mapping for command-line mode
function cmap(shortcut, command)
  map('c', shortcut, command)
end

-- Mapping for operator pending mode
function omap(shortcut, command)
  map('o', shortcut, command)
end

-- Mapping for Normal, Visual and operator pending modes
function amap(shortcut, command)
  map('', shortcut, command)
end

-- Normal, Visual and operator pending modes
amap("<Space>", "<Nop>")

-- Insert mode
imap("<esc>", "<C-c>")
--imap("<C-c>", "<esc>")
imap("<C-l>", "<Del>")
imap("<C-f>", "<C-o>O")
rmap("i", "<C-j>", "<CR>")
rmap("i", "<C-h>", "<BS>")

-- Normal mode
--nmap("<C-c>","<esc>")
--nmap("<esc>", "<c-c>")

-- Commands
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})

