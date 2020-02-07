"---------------------------
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

"---memo---
nnoremap <silent> <Leader>m :call ToggleMemo()<CR>
autocmd BufEnter Changelog.md :call WhenNewDay()
autocmd BufEnter Changelog.md nnoremap <buffer> <Leader>e :call NewEntry()<CR>

function! IsMemo(buf_num) abort
  let l:memo_buf = bufnr("~/Dropbox/memo/Changelog.md")
  if a:buf_num == memo_buf
    return 1
  endif
  return 0
endfunction

function! ToggleMemo() abort
  let l:cur_buf = bufnr()
  let l:memo_buf = bufnr("~/Dropbox/memo/Changelog.md")
  if cur_buf == memo_buf
    if bufexists(g:mru_buffer) == 1
      execute('buffer '.g:mru_buffer)
    else
      :echo "restorable editor does'nt exist"
    endif
  else
    if memo_buf == -1
      execute("e ~/Dropbox/memo/Changelog.md")
    else
      execute('buffer '.l:memo_buf)
    endif
  endif
endfunction

function! InsertNewDay() abort
  let l:date = system('date +\%Y-\%m-\%d')
  let date = date." Kotaro Arata <7750koutarou@gmail.com>"
  let date = substitute(date,"[[:cntrl:]]","","g")
  :call append(0,l:date)
  :call append(1,"")
endfunction

function! WhenNewDay() abort
  let l:date = system('date +\%Y-\%m-\%d')
  let date = date." Kotaro Arata <7750koutarou@gmail.com>"
  let date = substitute(date,"[[:cntrl:]]","","g")
  
  let l:line = getline(1)
  if line != date
    :call InsertNewDay()
  endif
endfunction

function! NewEntry() abort
  :call feedkeys("1Go	* [")
endfunction

"---terminal---
set shell=/bin/zsh
tnoremap <silent> <ESC><ESC> <C-\><C-n>
nnoremap <silent> <Leader>t :call ToggleTerminalMRU()<CR>

let g:mru_buffer = 1
let g:mru_buffer_prev = 1
autocmd bufleave * let g:mru_buffer_prev = bufnr()
autocmd bufenter *  call SaveMRUBuffer()

"exec when enter
function! SaveMRUBuffer() abort
  if IsNormal(g:mru_buffer_prev) && IsMemo(g:mru_buffer_prev) == 0
    let g:mru_buffer = g:mru_buffer_prev
  endif
endfunction

function! IsNormal(buf_num) abort
  if (buflisted(a:buf_num) == 1) && (IsTerminal(a:buf_num) == 0)
    return 1
  endif
  return 0
endfunction

function! IsTerminal(buf_num) abort
  let l:term_buf = bufnr("terminal.buffer")
  if a:buf_num == term_buf
    return 1
  endif
  return 0
endfunction

function! ToggleTerminalMRU() abort
  let l:cur_buf = bufnr()
  let l:term_buf = bufnr("terminal.buffer")
  if cur_buf == term_buf
    if bufexists(g:mru_buffer) == 1
      execute('buffer '.g:mru_buffer)
    else
      :echo "does'nt exist restorable editor"
    endif
  else
    if term_buf == -1
      execute("terminal")
      execute("f terminal.buffer")
    else
      execute('buffer '.l:term_buf)
    endif
  endif
endfunction

function! ToggleFloatingTerminalMRU() abort
  let l:cur_buf = bufnr()
  let l:term_buf = bufnr("terminal.buffer")
  if cur_buf == term_buf
    if bufexists(g:mru_buffer) == 1
      call nvim_win_close(0,v:true)
    else
      :echo "does'nt exist restorable editor"
    endif
  else
    call FloatingTerminal(term_buf)
  endif
endfunction

function! FloatingTerminal(buf) abort
  let term_buf = a:buf
  if a:buf == -1
    let l:term_buf = nvim_create_buf(v:false, v:true)
  endif
  call nvim_open_win(l:term_buf, v:true, {'relative': 'win', 'height': 30, 'width': 145, 'col': 10, 'row': 3})
  set winblend=0

  if a:buf == -1
    terminal
    f terminal.buffer
  endif
endfunction

"---gdb---
packadd termdebug
let g:termdebug_wide=163

"---template---
source ~/dotfiles/nvim/template/template.vim

"----------------------------
"python3 setting
"----------------------------
let g:python3_host_prog = expand('~/dotfiles/nvim/virtualenv/nvim-python3/bin/python3')
let g:python_host_prog = expand('~/dotfiles/nvim/virtualenv/nvim-python2/bin/python2')

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
  let g:rc_dir    = expand('~/dotfiles/nvim')
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
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let g:solarized_termcolors=256

"set background=dark
"colorscheme molokai 
"colorscheme solarized
"colorscheme wombat256
colorscheme iceberg
"colorscheme elflord

syntax on  "enable syntax highlighting

"----------------------------
"languege specific config
"----------------------------
filetype on
autocmd FileType Makefile setlocal noexpandtab
source ~/dotfiles/nvim/language/c.vim
