return {
  "echasnovski/mini.nvim",
  version = false,
  event = "InsertEnter",  -- Only load when going into insert mode
  config = function()
    local opts = {}
    require("mini.pairs").setup(opts)
  end,
}
