return {
  -- Cool status line
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    opts = {
      options = {
        theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = { left = '/', right = '/' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          'diff',
          {
            'diagnostics',
            sources = { 'nvim_lsp' },
            symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
            update_in_insert = false,
          }
        },
      }
    }
  },
  -- Visible indent
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = { char = "┃" }
    }
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require('notify').setup()

      vim.notify = require('notify')
    end

  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = "all",
      sync_install = false,
      highlight = {
        enable = true,

        -- Disable vim built-in highlighting
        additional_vim_regex_highlighting = false
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },

      indent = {
        enable = false,
      },
    }
  }
}
