return {
  "svermeulen/vim-cutlass",
  config = function()
    -- Remap "m" as cut, and "gm" as "m"
    vim.keymap.set({"n", "x"}, "m", "d", { desc = "cut" })
    vim.keymap.set("n", "mm", "dd", { desc = "cut" })
    vim.keymap.set("n", "M", "D", { desc = "cut" })
    vim.keymap.set("n", "gm", "m", { desc = "mark" })
  end,
}
