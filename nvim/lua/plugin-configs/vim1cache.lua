vim.g.vim1cache_dir = vim.fn.expand("~/Dropbox/vim1cache")
vim.g.vim1cache_entry_dir = 'entry'
vim.g.vim1cache_daily_memo = 'Changelog.md'
vim.g.vim1cache_username = 'Kotaro Arata'
vim.g.vim1cache_email = '7750koutarou@gmail.com'

vim.api.nvim_set_keymap('n', '<Leader>ma', ':AddMemo<CR>',{noremap = true,silent = true})
vim.api.nvim_set_keymap('n', '<Leader>ms', ':SearchMemo<CR>',{noremap = true,silent = true})
vim.api.nvim_set_keymap('n', '<Leader>ml', ':ListMemo<CR>',{noremap = true,silent = true})
vim.api.nvim_set_keymap('n', '<Leader>mo', ':OpenMemoUnderCursor<CR>',{noremap = true,silent = true})
vim.api.nvim_set_keymap('n', '<Leader>mm', ':ToggleDailyMemo<CR>',{noremap = true,silent = true})
