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
  }
}
