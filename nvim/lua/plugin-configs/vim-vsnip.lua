vim.api.nvim_set_keymap('i', '<C-k>', '<Plug>(vsnip-expand-or-jump)', {})
vim.api.nvim_set_keymap('s', '<C-k>', '<Plug>(vsnip-expand-or-jump)', {})

vim.g.vsnip_snippet_dir = vim.call("expand", "~/.vsnip_snippet")
