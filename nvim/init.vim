"----------------------------
" How to write .vimrc
" !! Write in English !!
"----------------------------

 "----------------------------
"write index here
"----------------------------

"---write sub-index here---

"----------------------------
"general configuration 
"----------------------------
"
"---general setting---
set nocompatible  "not compatible with vi
set encoding=utf-8  "set encoding utf-8 when opening file
scriptencoding utf-8  "use multi-byte in VimScript
set nobackup  "don't make backup file
set noswapfile  "dont' make swap file
set fileencoding=utf-8  "encoding when saving
set fileencodings=ucs-boms,utf-8,euc-jp,cp932  "auto-recognize when loading. left is priority
set fileformats=unix,dos,mac  "auto-recognize newline. left is priority
set ambiwidth=double  "resolve the problems of full size text. ex.◯
set autoread  "auto-read when editting file is changed
set hidden  "can open other files when buffer is being editting. 
set showcmd  "show command typing now on status area.
let mapleader="\<Space>"  "map Space to Leader

"---cursor---
set number  "show line number
set cursorline  "highlight present line
set cursorcolumn  "highlight present column
set virtualedit=onemore  "cursor can move 1 char after EOL
set whichwrap=b,s,h,l,<,>,[,],~   "move L or R at EOL can move next line 

"can move across apparent line even if it is logicaly single line
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

set backspace=indent,eol,start  "backspace available

"---mouse---
"mouse available
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
    "set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

"---paste---
"sync to clipboard
set clipboard=unnamedplus
"indent when paste disable
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[202~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc.[200~ XTermPasteBegin("")
endif

"---bracket---
set showmatch  "show matching bracket when input bracket
source $VIMRUNTIME/macros/matchit.vim  "extend '%'

"---layout---
set laststatus=2  "show status line always
set title  "show title-name 
set visualbell  "beep sound visualization

"---completion---
set wildmode=list:longest  "file name completion in command line mode
set history=5000  "set command history  

"---Tab,Indent---
set expandtab  "chang TAB to Space  
set tabstop=2  "TAB is 2 Spaces
set softtabstop=2  "TAB or Backspace move 2 on series spaces
set shiftwidth=2  "width when new line
"TAB seems ▸-
set list listchars=tab:\▸\-
set autoindent  "continue same indent when new line
set smartindent  "enable smartindent

"---search---
set ignorecase  "ignore upper and lower case when search string is lower case
set smartcase  "distinct upper and lower case when search string contains upper case
set incsearch  "realtime searching
set wrapscan  "next result when hit bottom move back to top
set hlsearch  "highlight hit words
"cancel highlight words when 2 ESC
nmap <Esc><Esc> :nohlsearch<CR><Esc>  

"---log---
set verbosefile=/tmp/nvim.log
set verbose=0

"---terminal---
tnoremap <silent> <ESC><ESC> <C-\><C-n>

"---gdb---
packadd termdebug
let g:termdebug_wide=163


"----------------------------
"dein setting
"----------------------------

let s:dein_dir = expand('~/.cache/dein')
"repository of dein
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

"download dein when dein does not exist
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

"start configuration
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

"configuration of vimproc
call dein#add('Shougo/vimproc.vim',{'build':'make'})
  
  "configuration of TOML file
  let g:rc_dir    = expand('~/dotfiles/nvim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  "load TOML and cash
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

"install pulugins which has not installed yes
if dein#check_install()
  call dein#install()
endif
"auto recache
let g:dein#auto_recache = 1

"----------------------------
"colorscheme
"----------------------------
let g:solarized_termcolors=256

"set background=dark
"colorscheme molokai 
"colorscheme solarized
"colorscheme wombat256
colorscheme iceberg

syntax on  "enable syntax highlighting

"----------------------------
"languege specific config
"----------------------------
filetype on
autocmd FileType Makefile setlocal noexpandtab


"----------------------------
"configuration of each pulugins
"----------------------------

"---NERDTree---
"autocmd VimEnter * execute 'NERDTree'
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden = 1
map <C-n> :NERDTreeToggle<CR>

"---lightline---
let g:lightline = {
        \ 'colorscheme': 'wombat' ,
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ],['ale'] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'gitgutter': 'Lightlinegitgutter',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode',
        \ },
        \ 'component_expand':{
        \   'ale': 'Ale',
        \ },
        \ 'component_type':{
        \   'ale': 'error',
        \ }
        \ }

function! Ale()
      let l:count = ale#statusline#Count(bufnr(''))
      let l:errors = l:count.error + l:count.style_error
      let l:warnings = l:count.warning + l:count.style_warning
      return l:count.total == 0 ? '' : 'Error:' . l:errors . ' Warning:' . l:warnings
endfunction

augroup MyAutoGroup
  autocmd!
  autocmd User ALELintPost call lightline#update()
augroup END

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '⭠'._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! Lightlinegitgutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction


augroup MyAutoGroup
  autocmd!
  autocmd User ALELintPost call lightline#update()
augroup END


"---denite.vim---
"nnoremap [denite] <Nop>
nmap <C-c> :Denite 

let s:denite_win_width_percent = 0.85
let s:denite_win_height_percent = 0.7

" Change denite default options
call denite#custom#option('default', {
    \ 'split': 'floating',
    \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
    \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
    \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
    \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
    \ })

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction



"---markdown(previm)---
autocmd BufRead,BufNewFile *.{mkd,md,mdwn,mkdn,mark*} set filetype=markdown
nnoremap <silent> <C-p> :PrevimOpen<CR>
let g:vim_markdown_fonlding_disabled=1
let g:previm_enable_realtime =1

"---open-browser.vim---
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

"---Seiya.vim---
"let g:seiya_auto_enable=1


"---ale---
"let g:ale_sign_column_always=1  "show error column always
"let g:ale_sign_error='X'
"let g:ale_sign_warning='!'
"
"let g:ale_lint_on_text_changed=0
"let g:ale_lint_on_insert_leave=1

"---vim-devicons---
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1  "show file icon

