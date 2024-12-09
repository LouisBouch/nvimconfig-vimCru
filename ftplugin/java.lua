-- Helper function
local is_available = function(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end
-- List of keymaps
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local keymps = function(_, bufnr)
  opts.buffer = bufnr

  -- set keybinds
  opts.desc = "Show LSP references"
  keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

  opts.desc = "Go to declaration"
  keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

  opts.desc = "Show LSP definitions"
  keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show LSP definitions

  opts.desc = "Show LSP implementations"
  keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show LSP definitions

  opts.desc = "Show LSP type definitions"
  keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show LSP type definitions

  opts.desc = "See available code actions"
  keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see abailable code actions

  opts.desc = "Smart rename"
  keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

  opts.desc = "See function definition in popup window"
  keymap.set("n", "<leader>gs", vim.lsp.buf.hover, opts)

  opts.desc = "Diagnostics reset"
  keymap.set("n", "<leader>rd", vim.diagnostic.reset, opts) -- show LSP type definitions

  opts.desc = "Show buffer diagnostics"
  keymap.set("n", "<leader>DD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show diagnostics for file

  opts.desc = "Show line diagnostics"
  keymap.set("n", "<leader>dd", vim.diagnostic.open_float, opts) -- show diagnostics for line

  opts.desc = "Go to previous diagnostic"
  keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

  opts.desc = "Go to next diagnostic"
  keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

  opts.desc = "Show documentation for what is under cursor"
  keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

  opts.desc = "Restart LSP"
  keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts) -- restarts lsp

  vim.keymap.set(
    "n",
    "<leader>ji",
    "<cmd>lua require('jdtls').organize_imports()<CR>",
    { noremap = true, silent = true, desc = "Organize imports" }
  )
end
if is_available("nvim-dap") then
  if vim.bo.filetype == "java" then
    local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
    local config = {
      cmd = { vim.fn.stdpath("data") .. "/mason/packages/jdtls/jdtls" },
      root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
      init_options = {
        extendedClientCapabilities = extendedClientCapabilities,
        bundles = {
          vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar", true),
          vim.fn.glob(
            vim.fn.stdpath("data")
              .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
            true
          ),
        },
      },
      capabilities = {
        workspace = {
          configuration = true,
          build = true,
        },
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true, -- snippetSupport for methods
            },
          },
        },
      },
      on_attach = function(client, bufnr)
        keymps(nil, bufnr)
        require("jdtls").setup_dap({ hotcodereplace = "auto" })
      end,
    }

    config.root_dir = config.root_dir .. "/app" -- ADDITION TO MAKE SURE DEBUGGER CAN READ RESOURCES
    -- local fun = dofile("/home/moyenmedium/luaScripts/print_table_tree.lua")
    -- print(fun.print_table_tree(config))
    require("jdtls").start_or_attach(config)

    -- Give enough time for jdt to fully load the project, or it will fail with
    -- "No LSP client found"
    local timer = 2500
    for _ = 0, 12, 1 do
      vim.defer_fn(function()
        -- require("jdtls.dap").setup_dap_main_class_configs()
      end, timer)
      timer = timer + 2500
    end
  end
end
