-- local config = {
--   cmd = {
--     os.getenv("HOME") .. "/.local/share/" .. (os.getenv("NVIM_APPNAME") or "nvim") .. "/mason/packages/jdtls/bin/jdtls",
--   },
--   root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
-- }
-- require('jdtls').start_or_attach(config)

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

  opts.desc = "Diagnostics reset"
  keymap.set("n", "<leader>rd", vim.diagnostic.reset, opts) -- show LSP type definitions

  opts.desc = "Show buffer diagnostics"
  keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show diagnostics for file

  opts.desc = "Show line diagnostics"
  keymap.set("n", "<leader>g", vim.diagnostic.open_float, opts) -- show diagnostics for line

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
    local config = {
      cmd = { vim.fn.stdpath("data") .. "/mason/packages/jdtls/jdtls" },
      root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
      init_options = {
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
        local orig_rpc_request = client.rpc.request
        --[[ -- Failed attempt to turn method autocompletion into snippets 
        function client.rpc.request(method, params, handler, ...)
          local orig_handler = handler
          if method == "textDocument/completion" then
            -- Idiotic take on <https://github.com/fannheyward/coc-pyright/blob/6a091180a076ec80b23d5fc46e4bc27d4e6b59fb/src/index.ts#L90-L107>.
            handler = function(...)
              local err, result = ...
              local CIK = vim.lsp.protocol.CompletionItemKind
              if not err and result then
                local items = result.items or result
                for _, item in ipairs(items) do
                  if
                    not (item.data and item.data.funcParensDisabled)
                    and (item.kind == CIK.Function or item.kind == CIK.Method or item.kind == CIK.Constructor)
                  then
                    item.insertText = item.label .. "($1)$0"
                    item.insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet
                  end
                end
              end
              return orig_handler(...)
            end
          end
          return orig_rpc_request(method, params, handler, ...)
        end
        ]]
      end,
    }
    require("jdtls").start_or_attach(config)

    -- Give enough time for jdt to fully load the project, or it will fail with
    -- "No LSP client found"
    local timer = 2500
    for _ = 0, 12, 1 do
      vim.defer_fn(function()
        require("jdtls.dap").setup_dap_main_class_configs()
      end, timer)
      timer = timer + 2500
    end
  end
end
