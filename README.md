# nvimconfig-vimCru

Contains the configuration files for my neovim setup.

# Current plugins and their dependencies

**File browsing**

- [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim)
  - [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
  - [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
  - [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [harpoon](https://github.com/ThePrimeagen/harpoon/tree/harpoon2)

**Fuzzy search for files**

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
  - [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
  - [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
  - [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)

**Text highlighting and file tree structure**

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

**Autocompletion**

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
  - [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
  - [cmp-path](https://github.com/hrsh7th/cmp-path)
  - [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
  - [cmp-dap](https://github.com/rcarriga/cmp-dap)
  - [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)\*
  - [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)\*

**LSP stuff**

- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) ([Language specific setup](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md))
  - [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
  - [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)\*
    - Used for java. (microsoft/java-debug needed?)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
  - [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
  - [mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)\*

**Autopairing of brackets and such**

- [mini.nvim](https://github.com/echasnovski/mini.nvim)

**Fancy line at the bottom of editor**

- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
  - [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)

**Better looking option list and input (for \***vim.ui.select**_ and _**vim.ui.input**\*)**

- [dressing.nvim](https://github.com/stevearc/dressing.nvim)

**Colorschemes**

- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)

**Editor terminal**

- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)

**Live pdf editing**

- [vimtex](https://github.com/lervag/vimtex)
- [Inlyne](https://github.com/Inlyne-Project/inlyne) is a sweet tool for markdown previews. (Not in nvim, but I might make a plugin for it for better integration.)

**Linting (Error analyzing)**

- [nvim-lint](https://github.com/mfussenegger/nvim-lint)

**Formatting**

- [conform.nvim](https://github.com/stevearc/conform.nvim)

**Debugging**

- [nvim-dap](https://github.com/mfussenegger/nvim-dap) ([Language specific setup](https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation))
  - [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python)\*
  - [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)\*
  - [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)\*
  - [nvim-nio](https://github.com/nvim-neotest/nvim-nio)\*
  - [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)\*
    - Used for java.

**Movement**

- [vim-easymotion](https://github.com/easymotion/vim-easymotion)
  - [vim-repeat](https://github.com/tpope/vim-repeat)

**Better deleting**

- [vim-cutlass](https://github.com/svermeulen/vim-cutlass)

\*<sup>Optional addons</sup>  
Complete list of plugins

- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [cmp-dap](https://github.com/rcarriga/cmp-dap)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [cmp-path](https://github.com/hrsh7th/cmp-path)
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
- [conform.nvim](https://github.com/stevearc/conform.nvim)
- [dressing.nvim](https://github.com/stevearc/dressing.nvim)
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)
- [harpoon](https://github.com/ThePrimeagen/harpoon/tree/harpoon2)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [mini.nvim](https://github.com/echasnovski/mini.nvim)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python)
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
- [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)
- [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)
- [nvim-lint](https://github.com/mfussenegger/nvim-lint)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-nio](https://github.com/nvim-neotest/nvim-nio)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim)
- [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- [vim-cutlass](https://github.com/svermeulen/vim-cutlass)
- [vim-easymotion](https://github.com/easymotion/vim-easymotion)
- [vim-repeat](https://github.com/tpope/vim-repeat)
- [vimtex](https://github.com/lervag/vimtex)

# External dependencies

# Fixes

**The easymotion version used is a fork from the original that surrounds "keepjumps..." with the following if statement in ~/.local/share/vimCru/lazy/vim-easymotion/autoload/EasyMotion.vim in order to fix issues with folds.**
  "timsu92/vim-easymotion",
  branch = "timsu92-fix-error-with-folds",
```
if foldclosedend(pos[0]+1) != -1
    keepjumps call cursor(foldclosedend(pos[0]+1), 0)
endif
```
