-- The following code updates the telescope picker in order to modifiy its entry_maker.
-- It appends the module directory after the modules name, i.e. "mod.rs (module_name)".
local telescope = require("telescope")
telescope.setup({
  pickers = {
    find_files = {
      entry_maker = function(path, _, opts)
        -- Get the default entry
        local entry = require("telescope.make_entry").gen_from_file(opts)(path)
        local full = vim.fn.fnamemodify(path, ":p")
        local parent = full:match(".*/(.-)/[^/]+$")
        local ancestors = vim.fs.dirname(path)
        if ancestors == "." then
          ancestors = ""
        end

        -- local icon, hl = devicons.get_icon(path, nil, { default = true })
        local display = getmetatable(entry).display
        entry.display = function(self)
          -- Get default icon+text rendering
          local text, icon = display(self)
          -- Customize display/ordinal for mod.rs files
          local tail = text:match(".*/([^/]+)$")
          local iconText = ""
          if tail == nil then
            tail = text
          else
            iconText = text:sub(icon[1][1][1], icon[1][1][2] + 1)
          end
          if path:match("mod%.rs$") then
            return string.format("%s%s (%s)\t\t%s", iconText, tail, parent, ancestors), icon
          else
            return string.format("%s%s\t\t%s", iconText, tail, ancestors), icon
          end
        end
        entry.ordinal = entry:display() -- Make it searchable

        return entry
      end,
    },
  },
})
-- Add module information to lualine when opening mod.rs file.
local lualine = require("lualine")
lualine.setup({
  sections = {
    lualine_c = {
      {
        function()
          local tail = vim.fn.expand("%:t")
          if tail:match("mod%.rs") then
            local full = vim.fn.expand("%:p")
            local parent = full:match(".*/(.-)/[^/]+$")
            tail = tail .. " (" .. parent ..")"
          end
          return tail .. (vim.bo.modified and " [+]" or "")
        end,
        color = { fg = "", gui = "bold" },
      },
      { "filetype" },
    },
  },
})
