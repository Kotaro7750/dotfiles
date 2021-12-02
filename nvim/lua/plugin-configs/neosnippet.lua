-- For LanguageClient
vim.g['neosnippet#enable_complete_done'] = 1

vim.api.nvim_set_keymap('i', '<C-k>', '<Plug>(neosnippet_expand_or_jump)', {})
vim.api.nvim_set_keymap('s', '<C-k>', '<Plug>(neosnippet_expand_or_jump)', {})
vim.api.nvim_set_keymap('x', '<C-k>', '<Plug>(neosnippet_expand_or_target)', {})
