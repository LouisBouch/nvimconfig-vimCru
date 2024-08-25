return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")

    -- Linters by file type
    lint.linters_by_ft = {
      c = {"cpplint"},
      cpp = {"cpplint"},
    }

    -- Linter customization
    require("lint").linters.cpplint.args = {
      "--filter=-legal/copyright"
    }

    -- Autocommand to trigger linting when certain events are met
    vim.api.nvim_create_augroup("lint", {clear = true})
    vim.api.nvim_create_autocmd({
      "BufEnter", "BufWritePost", "InsertLeave"
    }, {
      group = "lint",
      callback = function()
        lint.try_lint()
      end
    })

    -- Manual linting
    vim.keymap.set("n", "<leader>li", function()
      lint.try_lint()
    end, {desc = "Triggers linting for current file"})
  end,
}
