return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
  local treesitter = require("nvim-treesitter.configs")

  -- configure treesitter
  treesitter.setup({
    -- enable syntax highlighting
    highlight = {
      enable = true,
      -- disable treesitter for large files and specific languages
      disable = function(lang, buf)
        -- list of languages with disabled treesitter
        local disabled_languages = { -- set to true to disable
          ["lua"] = false,
          ["latex"] = false
        }
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
        if disabled_languages[lang] then
          return true
        end
      end,
    -- remove vim syntax highlight
    additional_vim_regex_highlighting = false,
    },
    -- enable indentation
    indented = { enable = true },
    -- ensure language parsers are installed for the following languages
    ensure_installed = {
      "lua",
      "rust",
      "latex",
      "c",
      "cpp",
      "bash",
      "vim",
      "query",
      "gitignore",
      "java",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn", -- set to `false` to disable one of the mappings
        node_incremental = "grn",
        scope_incremental = false,
        node_decremental = "grm",
      },
    },
  })
end,
}
