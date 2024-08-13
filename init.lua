require("config.options")
require("config.lazy")
require("config.colorschemeOpts")
require("config.keymaps")
require("config.autocmds")

-- -- DEFAULT SYNTAX SETTINGS

-- disables / starts the default nvim treesitter
-- vim.treesitter.start() / vim.treesitter.stop()

-- disables / activates the default vim highlighter
-- vim.cmd("syntax off")

-- checks status of nvim treesitter
-- vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()]
