return {
  {
    "saghen/blink.cmp",
    dependencies = {
      'rafamadriz/friendly-snippets',
      'fang2hou/blink-copilot' -- Required copilot-language-server is managed by mise
    },
    version = "1.*",
    lazy = false,
    opts = {
      keymap = {
        preset = "none",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "snippet_forward", "fallback" },
        ["<C-p>"] = { "snippet_backward", "fallback" },
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 100 },
        list = { selection = { preselect = false, auto_insert = true } },
      },
      sources = {
        default = { "lsp", "path", "buffer", "snippets", "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            async = true,
          },
        }
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
      signature = { enabled = true },
      cmdline = {
        keymap = { preset = "inherit" },
        completion = {
          list = { selection = { preselect = false } },
          menu = { auto_show = true },
        },
      },
    },
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    init = function()
      local severity = vim.diagnostic.severity
      vim.diagnostic.config({
        virtual_text = false, -- Disable Neovim's default virtual text diagnostics
        signs = {
          text = {
            [severity.ERROR] = "",
            [severity.WARN] = "",
            [severity.INFO] = "",
            [severity.HINT] = "",
          },
        }
      })
    end,
    opts = {
      multilines = {
        enabled = true,
      },
      show_source = {
        enabled = true,
      },
    }
  },
  {
    'nvim-treesitter/nvim-treesitter', -- Required tree-sitter-cli is managed by mise
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function(opts)
      require("nvim-treesitter").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("dotfiles-treesitter-start", { clear = true }),
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = { char = "┃" },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      render_modes = true,
      file_types = { "markdown" },
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
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  }
}
