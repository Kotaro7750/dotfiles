vim.g['deoplete#enable_at_startup'] = 1

-- Use \\ to pass \ itself to vim
vim.api.nvim_command('imap <expr><tab> pumvisible() ? "\\<C-n>" : neosnippet#expandable_or_jumpable() ? "\\<Plug>(neosnippet_expand_or_jump)" : "\\<tab>"')

-- Don't show preview window
vim.opt.completeopt:remove({'preview'})
