return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup({
      settings = {
        save_on_toggle = true,
      },
    })

    -- Mappings
    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<C-h>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    for i = 1, 9 do
      vim.keymap.set("n", "<A-" .. i .. ">", function()
        harpoon:list():select(i)
      end)
    end

    -- Toggle previous & next buffers stored within Harpoon list
    -- I won't use this (ctrl-shift doesn't even work with my terminal)
    vim.keymap.set("n", "<C-S-P>", function()
      harpoon:list():prev()
    end)
    vim.keymap.set("n", "<C-S-N>", function()
      harpoon:list():next()
    end)

    -- Setup telescope with harpoon
    -- local conf = require("telescope.config").values
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require("telescope.pickers")
    --     .new({}, {
    --       prompt_title = "Harpoon",
    --       finder = require("telescope.finders").new_table({
    --         results = file_paths,
    --       }),
    --       previewer = conf.file_previewer({}),
    --       sorter = conf.generic_sorter({}),
    --     })
    --     :find()
    -- end
    --
    -- vim.keymap.set("n", "<C-h>", function()
    --   toggle_telescope(harpoon:list())
    -- end, { desc = "Open harpoon window" })
  end,
}
