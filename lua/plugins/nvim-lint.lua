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
      javascript = {"eslint_d"},
      typescript = {"eslint_d"},
      html = {"htmlhint"},
      python = {"pylint"}, -- Currently not working
    }

    -- Linter customization
    require("lint").linters.cpplint.args = {
      "--filter=-legal/copyright"
    }
    -- Set pylint to work in virtualenv
    require("lint").linters.pylint.cmd = "python"
    require("lint").linters.pylint.args = { "-m", "pylint", "-f", "json" }

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
