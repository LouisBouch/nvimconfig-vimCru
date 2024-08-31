local config = {
  cmd = {
    os.getenv("HOME") .. "/.local/share/" .. (os.getenv("NVIM_APPNAME") or "nvim") .. "/mason/packages/jdtls/bin/jdtls",
  },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}
vim.keymap.set("n", "<leader>ji", "<cmd>lua require('jdtls').organize_imports()<CR>", { noremap = true, silent = true, desc = "Organize imports" }) -- show diagnostics for line

-- require('jdtls').start_or_attach(config)
