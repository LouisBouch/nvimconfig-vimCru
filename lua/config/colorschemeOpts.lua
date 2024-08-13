-- -- Randomly apply a colorscheme
math.randomseed(os.time())
local r = math.random(2)
local theme = "";
if (r == 1) then
  theme = "gruvbox"
else
  theme = "tokyonight"
end
vim.api.nvim_command("colorscheme " .. theme)
