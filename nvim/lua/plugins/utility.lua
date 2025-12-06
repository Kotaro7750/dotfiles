return {
  {
    "simrat39/symbols-outline.nvim",
    lazy = false,
    opts = {
      position = "left",
    },
    config = function(_, opts)
      require("symbols-outline").setup(opts)

      vim.api.nvim_set_keymap('n', '<Leader>so', ':SymbolsOutline<CR>', { silent = true, noremap = true })
    end

  },
  -- Comment in a simple way
  {
    "numToStr/Comment.nvim",
    config = true,
  },
  -- Easily operate parentheses
  {
    "kylechui/nvim-surround",
    config = true,
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- Setup key binding for lazygit
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true })
      function _lazygit_toggle()
        lazygit:toggle()
      end

      vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>tt', ':ToggleTerm<CR>', { silent = true, noremap = true })
    end,
    opts = {
      persist_mode = false, -- This is for entering insert mode when next toggle
      direction = "float",
      float_opts = {
        border = "double",
      },
    }
  }
}
