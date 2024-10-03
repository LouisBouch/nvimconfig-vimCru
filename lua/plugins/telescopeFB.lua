local telescope = require("telescope")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- Modified from fb_actions.change_cwd @ /home/moyenmedium/.local/share/vimCru/lazy/telescope-file-browser.nvim/lua/telescope/_extensions/file_browser/actions.lua
-- Inspired by fb_actions.goto_parent_dir @ /home/moyenmedium/.local/share/vimCru/lazy/telescope-file-browser.nvim/lua/telescope/_extensions/file_browser/actions.lua
local custom_change_cwd = function(prompt_bufnr)
  -- Adds path to allow for fb_utils and fb_lsp to load properly. Not ideal.
  package.path = package.path .. ";/home/moyenmedium/.local/share/vimCru/lazy/telescope-file-browser.nvim/lua/?.lua"
  local fb_utils = require("telescope._extensions.file_browser.utils")
  local fb_lsp = require("telescope._extensions.file_browser.lsp")
  local Path = require("plenary.path")
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local finder = current_picker.finder

  finder.path = Path:new(finder.path):absolute()
  finder.cwd = finder.path
  vim.cmd("cd " .. finder.path)

  -- Visually update changes
  fb_utils.redraw_border_title(current_picker)
  current_picker:refresh(
    finder,
    { new_prefix = fb_utils.relative_path_prefix(finder), reset_prompt = true, multi = current_picker._multi }
  )
  fb_utils.notify(
    "action.change_cwd",
    { msg = "Set the current working directory!", level = "INFO", quiet = finder.quiet }
  )
end

return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local fb_actions = require("telescope._extensions.file_browser.actions")
    local actions = require("telescope.actions")
    require("telescope").setup({
      extensions = {
        file_browser = {
          --theme = "ivy", -- Makes it fullscreen
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              ["<C-n>"] = function(prompt_buffer)
                local entry = require("telescope.actions.state").get_selected_entry()
                if entry and not entry.Path:is_dir() then
                  -- Goes to normal mode first
                  vim.cmd.stopinsert()
                  -- Then select file after entering normal mode
                  vim.schedule(function()
                    actions.select_default(prompt_buffer)
                  end)
                else
                  -- Open normally if folder
                  actions.select_default(prompt_buffer)
                end
                -- Otherwise, the selected folds upon opening a file break
              end,
              ["<C-h>"] = fb_actions.backspace,
              ["<C-_>"] = fb_actions.toggle_hidden,
              ["<C-o>"] = function()
                print(vim.fn.getcwd())
              end,
              ["<C-t>"] = custom_change_cwd,
            },
            ["n"] = {},
          },
        },
      },
    })
    -- To get telescope-file-browser loaded and working with telescope,
    -- you need to call load_extension, somewhere after setup function:
    require("telescope").load_extension("file_browser")

    -- open file_browser with the path of the current buffer
    -- vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true no_ignore=true<CR>")
    vim.keymap.set("n", "<space>fb", function()
      require("telescope").extensions.file_browser.file_browser({
        path = "%:p:h",
        select_buffer = true,
        no_ignore = true,
      })
    end)
  end,
}
