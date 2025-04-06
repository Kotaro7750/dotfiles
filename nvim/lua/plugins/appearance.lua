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
        disabled_filetypes = {
          statusline = {
            "Avante",
            "AvanteSelectedFiles",
            "AvanteInput",
          },
        },
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
    build = ":TSUpdate",
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
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },
  -- Render markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      render_modes = true,
      file_types = { "markdown", "Avante" },
      latex = { enabled = false },

      sign = { enabled = false },

      heading = {
        width = "block",
        left_pad = 0,
        right_pad = 4,
        icons = {},
      },
      code = {
        width = "block",
        left_pad = 0,
        right_pad = 4,
      },
    },
    ft = { "markdown", "Avante" },
  },
}
