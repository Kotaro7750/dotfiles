let g:vim1cache_dir = expand("~/Dropbox/vim1cache")
let g:vim1cache_entry_dir = 'entry'
let g:vim1cache_daily_memo = 'Changelog.md'
let g:vim1cache_username = 'Kotaro Arata'
let g:vim1cache_email = '7750koutarou@gmail.com'

nnoremap <silent> <Leader>ma :AddMemo<CR>
nnoremap <silent> <Leader>ms :SearchMemo<CR>
nnoremap <silent> <Leader>ml :ListMemo<CR>
nnoremap <silent> <Leader>mo :OpenMemoUnderCursor<CR>
nnoremap <silent> <Leader>mm :ToggleDailyMemo<CR>
