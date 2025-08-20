-- Define keymaps
local keymap = vim.keymap
local map_opts = { noremap = true, silent = true }
local on_attach = function(_, bufnr)
  map_opts.buffer = bufnr

  -- set keybinds
  map_opts.desc = "Show LSP references"
  keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", map_opts) -- show definition, references

  map_opts.desc = "Go to declaration"
  keymap.set("n", "gD", vim.lsp.buf.declaration, map_opts) -- go to declaration

  map_opts.desc = "Show LSP definitions"
  keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", map_opts) -- show LSP definitions

  map_opts.desc = "Show LSP implementations"
  keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", map_opts) -- show LSP definitions

  map_opts.desc = "Show LSP type definitions"
  keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", map_opts) -- show LSP type definitions

  map_opts.desc = "See available code actions"
  keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, map_opts) -- see abailable code actions

  map_opts.desc = "Smart rename"
  keymap.set("n", "<leader>rn", vim.lsp.buf.rename, map_opts) -- smart rename

  map_opts.desc = "See function definition in popup window"
  keymap.set("n", "<leader>gs", vim.lsp.buf.hover, map_opts)

  map_opts.desc = "Diagnostics reset"
  keymap.set("n", "<leader>rd", vim.diagnostic.reset, map_opts) -- show LSP type definitions

  map_opts.desc = "Show buffer diagnostics"
  keymap.set("n", "<leader>DD", "<cmd>Telescope diagnostics bufnr=0<CR>", map_opts) -- show diagnostics for file

  map_opts.desc = "Show line diagnostics"
  keymap.set("n", "<leader>dd", vim.diagnostic.open_float, map_opts) -- show diagnostics for line

  map_opts.desc = "Go to previous diagnostic"
  keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, map_opts) -- jump to previous diagnostic in buffer

  map_opts.desc = "Go to next diagnostic"
  keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, map_opts) -- jump to next diagnostic in buffer

  map_opts.desc = "Show documentation for what is under cursor"
  keymap.set("n", "K", vim.lsp.buf.hover, map_opts) -- show documentation for what is under cursor

  map_opts.desc = "Restart LSP"
  keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", map_opts) -- restarts lsp
end

-- Command for restarting
local function restart()
  vim.api.nvim_create_user_command("TSLSRestart", function()
    for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
      if c.name == "typescript-tools" then
        vim.lsp.stop_client(c.id, true)
      end
    end
    vim.defer_fn(function()
      require("typescript-tools").setup({on_attach=on_attach()})
    end, 50)
  end, {})
end
-- Setup the plugin
return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    on_attach = function()
      on_attach()
      restart()
    end,
  },
}
