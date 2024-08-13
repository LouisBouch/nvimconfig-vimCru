return {
  {
    "lervag/vimtex",
    init = function()
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_view_general_view = "zathura"
      vim.g.cimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
    end
  },
}
--Template creation can be foudn int the "...vimCru/config/autocmds" file
