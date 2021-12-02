vim.g.NERDTreeShowHidden = 1

vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', {noremap = false})

vim.api.nvim_command('autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif')
vim.api.nvim_command('autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif')
