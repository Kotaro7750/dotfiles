let g:seiya_auto_enable=1
" Work correctly when using neovim with true-color terminal
let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']
