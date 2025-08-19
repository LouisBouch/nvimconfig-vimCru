return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "L3MON4D3/LuaSnip", -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "rcarriga/cmp-dap", -- autocompletion source when in debug mode
    "hrsh7th/cmp-nvim-lsp-signature-help", -- function parameter help
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- loads vscode style snippets from installed plugins
    require("luasnip.loaders.from_vscode").lazy_load()
    -- luasnip.filetype_extend("typescriptreact", {"html"}) -- Adds html snippets to .tsx. No longer required since emmet-language-server

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show coompletion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<A-j>"] = cmp.mapping.confirm({ select = true }),

        -- Snippet navigation
        ["<Tab>"] = cmp.mapping(function(fallback) -- Next placeholder
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end),
        ["<S-Tab>"] = cmp.mapping(function(fallback) -- Previous placeholder
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- lsp servers
        { name = "luasnip" }, -- snippets
        { name = "nvim_lsp_signature_help" }, -- function parameter help
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
        { name = "dap" }, -- debugging
      }),
    })
    -- Example custom snippets
    --luasnip.add_snippets("lua", {
    --  luasnip.parser.parse_snippet("fff", "oi")
    --})
    local s = luasnip.snippet
    local i = luasnip.insert_node
    local t = luasnip.text_node
    local c = luasnip.choice_node
    luasnip.add_snippets("lua", { -- else snippet
      s("else", {
        t({ "else", "\t" }),
        i(1, "--code"),
        t({ "", "end" }),
      }),
    })
  end,
}
