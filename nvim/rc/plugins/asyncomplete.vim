let g:asyncomplete_auto_popup = 0
set completeopt+=preview

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =- '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ asyncomplete#force_refresh()
