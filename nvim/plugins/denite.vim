let s:denite_win_width_percent = 0.7
let s:denite_win_height_percent = 0.7

autocmd BufEnter * silent! lcd %:p:h

call denite#custom#option('default', 'prompt', '$')
call denite#custom#option('default', {
    \ 'split': 'floating',
    \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
    \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
    \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
    \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
    \ })

let s:ignore_globs = ['.git', '.svn', 'node_modules']
call denite#custom#var('file/rec', 'command', [
      \ 'ag',
      \ '--follow',
      \ ] + map(deepcopy(s:ignore_globs), { k, v -> '--ignore=' . v }) + [
      \ '--nocolor',
      \ '--nogroup',
      \ '-g',
      \ ''
      \ ])
call denite#custom#source('file/rec', 'matchers', ['matcher/substring'])
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs', s:ignore_globs)

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',['-i','--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> s denite#do_map('do_action','vsplit')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
  nnoremap <silent><buffer><expr> . denite#do_map('move_up_path')
  set splitright
endfunction

nnoremap <silent> <Leader>db   :Denite buffer<CR>
nnoremap <silent> <Leader>df   :Denite file<CR>
nnoremap <silent> <Leader>dg   :Denite grep<CR>
nnoremap <silent> <Leader>dG   :DeniteCursorWord grep<CR>
nnoremap <silent> <Leader>dr   :Denite register<CR>
