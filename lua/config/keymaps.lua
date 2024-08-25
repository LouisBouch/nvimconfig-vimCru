-- LEADERS ARE SET IN THE lazy.lua FILE


-- General mapping, non recursive
local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = false })
end

-- General mapping, recursive
local function rmap(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = false, silent = false })
end

-- Mapping for normal mode
local function nmap(shortcut, command)
  map('n', shortcut, command)
end

-- Mapping for insert mode
local function imap(shortcut, command)
  map('i', shortcut, command)
end

-- Mapping for visual and select mode
local function vmap(shortcut, command)
  map('v', shortcut, command)
end

-- Mapping for visual mode
local function xmap(shortcut, command)
  map('x', shortcut, command)
end

-- Mapping for select mode
local function smap(shortcut, command)
  map('s', shortcut, command)
end

-- Mapping for command-line mode
local function cmap(shortcut, command)
  map('c', shortcut, command)
end

-- Mapping for operator pending mode
local function omap(shortcut, command)
  map('o', shortcut, command)
end

-- Mapping for Normal, Visual and operator pending modes
local function amap(shortcut, command)
  map('', shortcut, command)
end

-- Normal, Visual and operator pending modes
amap("<Space>", "<Nop>")

-- Insert mode
imap("<C-l>", "<Del>")
imap("<C-f>", "<C-o>O")
rmap("i", "<C-j>", "<CR>")
rmap("i", "<C-h>", "<BS>")

-- Normal mode

-- Commands
local mk_command = vim.api.nvim_create_user_command
mk_command("Q", "q", {})
mk_command("Wq", "wq", {})
mk_command("WQ", "wq", {})
mk_command("W", "w", {})

