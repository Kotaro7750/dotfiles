vim.g.seiya_auto_enable = 1

-- Work correctly when using neovim with true-color terminal
-- In Lua, A and B or C is equivalent to A ? B : C (ternary operator in C etc). This is because 'and' and 'or' is short circuit.
vim.g.seiya_target_groups = vim.fn.has('nvim') == 1 and {'guibg'} or {'ctermbg'}
