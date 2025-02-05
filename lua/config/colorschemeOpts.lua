-- -- Randomly apply a colorscheme
math.randomseed(os.time())
local r = math.random(8)
local theme = ""
if r == 1 then
  theme = "gruvbox"
elseif r == 2 then
  theme = "tokyonight"
elseif r == 3 then
  theme = "kanagawa"
elseif r == 4 then
  theme = "nightfox"
elseif r == 5 then
  theme = "duskfox"
elseif r == 6 then
  theme = "nordfox"
elseif r == 7 then
  theme = "terafox"
elseif r == 8 then
  theme = "carbonfox"
end
vim.api.nvim_command("colorscheme " .. theme)
