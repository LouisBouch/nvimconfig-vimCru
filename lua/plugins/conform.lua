return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        cpp = { "clang-format" },
        lua = { "stylua" },
      },
      format_on_save = function(bufnr)
        -- Disable formatting on save if certain properties are set
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          lsp_fallback = true, -- use lsp for formatting if no specific formatter
          async = false, -- non asynchronous mapping (so synchronous?)
          timeout_ms = 500, -- fails if formatting takes more than 500 ms
        }
      end,
    })
    -- disable auto formatting on save
    vim.g.disable_autoformat = true

    -- keymap for formatting
    vim.keymap.set({ "n", "v" }, "<leader>fo", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout = 500,
      })
    end, { desc = "Formats file" })
  end,
}
