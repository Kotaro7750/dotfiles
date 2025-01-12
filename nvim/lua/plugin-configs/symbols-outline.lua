require("symbols-outline").setup({
  position = "left",
})

vim.api.nvim_set_keymap('n', '<Leader>so', ':SymbolsOutline<CR>', { silent = true, noremap = true })
