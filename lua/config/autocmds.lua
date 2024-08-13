-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

--[[ .tex files autocmd ]]--
vim.api.nvim_create_augroup("tex", { clear = true })

-- Loads default template
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
  group = "tex",
  pattern = "*.tex",
  command = "0r /home/moyenmedium/.config/vimCru/lua/templates/tex.md"
})

--[[ View adjacent autocmd (such as mkview/loadview) ]]--
vim.api.nvim_create_augroup("view", { clear = true })

-- Creates view upon saving buffer
vim.api.nvim_create_autocmd({ "BufWritePost"}, {
  group = "view",
  pattern = "*",
  command = "silent! mkview",
})

-- Loads view upon opening buffer
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  group = "view",
  pattern = "*",
  command = "silent! loadview",
})

--[[ Creates hightlight for every character after 2 tabs in the telescope window ]]--
vim.api.nvim_create_augroup("Telescope", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "Telescope",
  pattern = {"TelescopeResults", "TelescopeOldfiles"},
  callback = function(ctx)
    vim.api.nvim_buf_call(ctx.buf, function()
      vim.fn.matchadd("TelescopeParent", "\t\t.*$")
      vim.api.nvim_set_hl(0, "TelescopeParent", {link = "Comment" })
    end)
  end,
})

--[[ Creates hightlight for line with special character in text files ]]--
vim.api.nvim_create_augroup("texthl", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "texthl",
  pattern = {"text"},
  callback = function(ctx)
    vim.api.nvim_buf_call(ctx.buf, function()
      vim.fn.matchadd("codehl", "\\~\\$.*\\( $\\)\\@<!")
      vim.api.nvim_set_hl(0, "codehl", {link = "Keyword" })
    end)
  end,
})
