return {
  { "folke/tokyonight.nvim" },
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      -- Ensure parameters have different color from member variables in gruvbox.
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "gruvbox",
        callback = function()
          vim.cmd("highlight! link @parameter GruvboxAqua")
        end,
      })
      -- Makes whitespace visible in fox colorschemes.
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*fox",
        callback = function()
          -- Current whitespace highlight.
          local whitespace_hl = vim.api.nvim_get_hl(0, { name = "Whitespace" }).fg

          -- Value to add to whitespace highlight.
          local extra_hl = tonumber("0x101010")

          -- Set new value for whitespace.
          vim.api.nvim_set_hl(0, "Whitespace", {fg=whitespace_hl+extra_hl})
        end,
      })
    end,
  },
  { "EdenEast/nightfox.nvim" },
  { "rebelot/kanagawa.nvim" },
}
