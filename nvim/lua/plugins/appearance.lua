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
    branch = "main",
    build = ":TSUpdate",
    config = function(_, _)
      require("nvim-treesitter").setup({})
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()";

      -- cf. https://blog.atusy.net/2025/08/10/nvim-treesitter-main-branch/
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
        callback = function(ctx)
          -- 必要に応じて`ctx.match`に入っているファイルタイプの値に応じて挙動を制御
          -- `pcall`でエラーを無視することでパーサーやクエリがあるか気にしなくてすむ
          pcall(vim.treesitter.start)
        end,
      });
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
