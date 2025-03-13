return {
  -- "easymotion/vim-easymotion",
  "timsu92/vim-easymotion",
  branch = "timsu92-fix-error-with-folds",
  dependencies = {
    "tpope/vim-repeat",
  },
  config = function()
    -- Commands
    -- vim.keymap.set("n", "<leader><leader>o", "<Plug>(easymotion-bd-f)", { desc = "test" })
  end,
}
