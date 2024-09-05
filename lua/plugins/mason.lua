return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- import mason
      local mason = require("mason")

      -- import mason-lspconfig
      local mason_lspconfig = require("mason-lspconfig")

      -- enable mason and configure icons
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
      mason_lspconfig.setup({
        -- list of servers for mason to isntall
        ensure_installed = {
          -- LSP
          "lua_ls",
          "rust_analyzer",
          "pylsp",
          "clangd",
          "jdtls",
          -- For linters/formatters/dap check mason-tool-installer
        },
        -- auto-install configured servers (with lspconfig)
        automatic_installation = true, -- not the same as ensure_installed
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      -- import mason-tool-installer
      local mason_tool_installer = require("mason-tool-installer")

      -- Plugin for auto-installing formatters/linters
      mason_tool_installer.setup({
        ensure_installed = {
          "cpplint", -- litner for cpp and c
          "clang-format", -- formatter for c, cpp
          "stylua", -- formatter for lua
          "codelldb", -- dap for c/c++/rust
          "java-test", -- java tests?
          "java-debug-adapter", -- dap for java
        },
      })
    end,
  },
}
