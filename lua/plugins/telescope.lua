local file_path = function(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)
  if parent == "." then
    return tail
  end
  return string.format("%s\t\t%s", tail, parent)
end

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-n>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            -- ["<C-n>"] = actions.select_default,
            ["<A-j>"] = function(prompt_buffer)
              -- Sends escape
              -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
              -- Goes to normal mode first
              -- vim.cmd([[stopinsert]])
              vim.cmd.stopinsert()
              -- Then select file
              vim.schedule(function()
                actions.select_default(prompt_buffer)
              end)
              -- vim.cmd([[call feedkeys("\<CR>")]])
              -- Otherwise, the selected folds upon opening a file break
            end,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "-g", "!.git", "--no-ignore" },
          path_display = file_path,
        },
        oldfiles = {
          path_display = file_path,
        },
        live_grep = {
          path_display = file_path,
        },
        grep_string = {
          path_display = file_path,
        },
      },
    })

    telescope.load_extension("fzf")

    -- KEYMAPS
    local keymap = vim.keymap

    --keymap.set("n", "<leader>ff", "<cmd>Telescope find_files path=%:p:h select_buffer=true<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
  end,
}
