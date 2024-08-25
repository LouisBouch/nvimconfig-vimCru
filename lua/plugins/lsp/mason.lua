return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- import mason-tool-installer
    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        }
      }
    })
    mason_lspconfig.setup({
      -- list of servers for mason to isntall
      ensure_installed = {
        -- LSP
        "lua_ls",
        "rust_analyzer",
        "pylsp",
        "clangd",
        -- For linters check mason-tool-installer
},
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })
    mason_tool_installer.setup({
        ensure_installed = {
          "cpplint", -- litner for cpp and c
      }
    })
  end,
}
