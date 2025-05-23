return {
  {
    "L3MON4D3/LuaSnip",
    lazy = false,
    config = function()
      local luasnip = require('luasnip')

      vim.keymap.set({ "i" }, "<C-k>",
        function()
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          end
        end,
        { silent = true }
      )

      vim.keymap.set({ "i", "s" }, "<C-n>",
        function()
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          end
        end,
        { silent = true }
      )

      vim.keymap.set({ "i", "s" }, "<C-p>",
        function()
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          end
        end,
        { silent = true }
      )

      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  -- Lua base completion engine
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
      -- Completion sources for nvim-cmp
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
    },
    config = function()
      local cmp = require('cmp')

      local cmp_kinds = {
        Text = '  ',
        Method = '  ',
        Function = '  ',
        Constructor = '  ',
        Field = '  ',
        Variable = '  ',
        Class = '  ',
        Interface = '  ',
        Module = '  ',
        Property = '  ',
        Unit = '  ',
        Value = '  ',
        Enum = '  ',
        Keyword = '  ',
        Snippet = '  ',
        Color = '  ',
        File = '  ',
        Reference = '  ',
        Folder = '  ',
        EnumMember = '  ',
        Constant = '  ',
        Struct = '  ',
        Event = '  ',
        Operator = '  ',
        TypeParameter = '  ',
      }

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(
            { border = 'double' }
          ),
          documentation = cmp.config.window.bordered(
            { border = 'double' }
          ),
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, vim_item)
            vim_item.menu = vim_item.kind or ''
            vim_item.kind = (cmp_kinds[vim_item.kind] or '')

            if entry.source.name == 'calc' then
              vim_item.kind = '󰃬  '
            end

            return vim_item
          end,
        },
        mapping = {
          ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        },
        sources = cmp.config.sources(
          {
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lua' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'calc' },
          }
        )
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
          { name = 'cmdline_history' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          {
            { name = 'path' }
          },
          {
            { name = 'cmdline' }
          },
          {
            { name = 'cmdline_history' }
          }
        )
      })
    end
  },
  -- Auto insert corresponding parentheses
  {
    "cohama/lexima.vim",
    lazy = false,
  },
}
