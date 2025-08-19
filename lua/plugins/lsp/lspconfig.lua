return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  enabled = true,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    --{ "antosha417/nvim-lsp-file-operations", config = true}, -- Can only be used with nvim-tree or neo-tree
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap

    local opts = { noremap = true, silent = true }
    local on_attach = function(_, bufnr)
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
      keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts) -- restarts lsp
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- change the diagnostic symbols in the sign column
    local symbols = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    local signs = { text = {}, numhl = {}, linehl = {} }
    for type, icon in pairs(symbols) do
      local hl = "DiagnosticSign" .. type
      -- vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      signs.text[vim.diagnostic.severity[type:upper()]] = icon
      signs.numhl[vim.diagnostic.severity[type:upper()]] = hl
      signs.linehl[vim.diagnostic.severity[type:upper()]] = ""
      -- Sets hl for diangostic (Doesn't work, it is set before coloscheme is activated. Use autocmd instead.)
      -- vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "Black" })
    end
    -- vim.diagnostic.config({ signs = { text = text, numhl = numhl } })
    vim.diagnostic.config({ signs = signs })

    -- sorts gutter icons by severity Error>Warn>...
    vim.diagnostic.config({ severity_sort = true })

    -- -- Setup language servers -- --

    -- lua
    vim.lsp.config("lua_ls", {
      on_attach = on_attach,
      capabilities = capabilities,
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath("config")
            and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
          then
            return
          end
        end

        -- Substitutes the "settings.Lua" options defined later
        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using (most
            -- likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Tell the language server how to find Lua modules same way as Neovim
            -- (see `:h lua-module-load`)
            path = {
              "lua/?.lua",
              "lua/?/init.lua",
            },
          },
          completion = {
            callSnippet = "Both",
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            -- make language esrver aware of runtime files
            library = {
              vim.env.VIMRUNTIME,
              vim.fn.expand("$VIMRUNTIME/lua"),
              vim.fn.stdpath("config") .. "/lua",
              "${3rd}/luv/library",
              "${3rd}/busted/library",
            },
          },
        })
      end,
      settings = {
        Lua = {
        },
      },
    })
    vim.lsp.enable("lua_ls")

    -- HTML/CSS/... (requires: npm install -g emmet-ls? maybe not sinec I have it in mason)
    vim.lsp.enable("emmet_language_server")

    -- rust
    lspconfig["rust_analyzer"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { "rust-analyzer" },
      filetypes = { "rust" },
      root_dir = function()
        return vim.fs.dirname(vim.fs.find({ "Cargo.toml", "rust-project.json", ".git" }, { upward = true })[1])
      end,
      single_file_support = true,
      settings = {
        ["rust-analyzer"] = {
          completion = {
            addCallArgumentSnippets = true,
            addCallParenthesis = true,
          },
        },
      },
    })

    -- c/cpp
    lspconfig["clangd"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- html
    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "php" }, -- Run lsp on php files too
    })
    -- html
    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- php
    lspconfig["phpactor"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- python
    local root_pyt = vim.fs.dirname(vim.fs.find({ ".venv" }, { upward = true })[1])
    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        python = {
          pythonPath = root_pyt and root_pyt .. "/.venv/bin/python3",
        },
        analysis = {
          extraPaths = {
            ".",
            "./src",
          },
        },
      },
    })
    -- lspconfig["pylsp"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   settings = {
    --     pylsp = {
    --       plugins = {
    --         -- formatter options
    --         black = { enabled = true },
    --         autopep8 = { enabled = false },
    --         yapf = { enabled = false },
    --         -- linter options
    --         pylint = { enabled = true, executable = "pylint" },
    --         pyflakes = { enabled = false },
    --         pycodestyle = { enabled = false },
    --         -- type checker
    --         pylsp_mypy = { enabled = true },
    --         -- auto-completion options
    --         jedi_completion = { fuzzy = true },
    --         -- import sorting
    --         pyls_isort = { enabled = true },
    --         -- jedi = {
    --         --   -- Allows for own imports
    --         --   extra_paths = {
    --         --     ".",
    --         --     "./src",
    --         --   },
    --         -- },
    --       },
    --     },
    --   },
    --   flags = {
    --     debounce_text_changes = 200,
    --   },
    -- })

    -- java -> check jdtls.lua setup instead
    -- local on_attach_java = function(_, bufnr)
    --   on_attach(nil, bufnr)
    --   vim.keymap.set("n", "<leader>ji", "<cmd>lua require('jdtls').organize_imports()<CR>", { noremap = true, silent = true, desc = "Organize imports" })
    -- end
    -- lspconfig["jdtls"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach_java,
    -- })

    --[[ creates autocommand to manually display floating error/warning signs upon entering normal mode ]]

    vim.api.nvim_create_augroup("lsp", { clear = true })
    vim.api.nvim_create_autocmd({ "modechanged" }, {
      group = "lsp",
      pattern = "*:n",
      callback = function()
        vim.diagnostic.show()
      end,
    })
  end,
}
