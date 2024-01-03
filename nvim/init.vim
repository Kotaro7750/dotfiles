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

" resolve the problems of full size text. ex.◯
" Some exception is applied using setcellwidths() for preventing UI collapse. Exceptions are
" 罫線素片, ブロック要素 and Nerdfont ple lower triangle
set ambiwidth=double  
call setcellwidths([
  \ [0x2500, 0x257f, 1],
  \ [0x2580, 0x259f, 1],
  \ [0xe0b8, 0xe0be, 1],
\])

set autoread  "auto-read when editting file is changed
set hidden  "can open other files when buffer is being editting. 
set showcmd  "show command typing now on status area.
let mapleader="\<Space>"  "map Space to Leader
set number  "show line number of under cursor line
set relativenumber  "show relative line number
set nomodeline  "unset modeline

"---cursor---
set cursorline  "highlight present line
set cursorcolumn  "highlight present column
set virtualedit=onemore  "cursor can move 1 char after EOL
set whichwrap=b,s,h,l,<,>,[,],~   "move L or R at EOL can move next line 
set conceallevel=2
set concealcursor=  "only conceal not present line

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
set breakindent

"---search---
set ignorecase  "ignore upper and lower case when search string is lower case
set smartcase  "distinct upper and lower case when search string contains upper case
set incsearch  "realtime searching
set wrapscan  "next result when hit bottom move back to top
set hlsearch  "highlight hit words
"cancel highlight words when 2 ESC
nmap <Esc><Esc> :nohlsearch<CR><Esc>  

"---IME---
if has('unix') && !exists('$WSLENV')
  autocmd InsertLeave * :call OffIME()
endif

function! OffIME() abort
  " fcitx-remote returns 1 if current method is mozc
  let l:fcitx_status = system('fcitx-remote')
  if fcitx_status == 1
    call system('fcitx-remote -s fcitx-keyboard-us')
  endif
endfunction

"---log---
set verbosefile=/tmp/nvim.log
set verbose=0

"---terminal---
set shell=/bin/zsh
tnoremap <silent> <ESC><ESC> <C-\><C-n>
nnoremap <silent> <Leader>t :call ToggleTerminalMRU()<CR>

let g:mru_buffer = 1
let g:mru_buffer_prev = 1
autocmd bufleave * let g:mru_buffer_prev = bufnr()

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
let g:python3_host_prog = expand('~/nvim-python3/bin/python3')
let g:python_host_prog = expand('~/nvim-python2/bin/python2')

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
  let s:rc_dir    = expand('~/dotfiles/nvim')
  let s:toml      = s:rc_dir . '/dein.toml'
  let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'

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
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"set termguicolors
if exists('+termguicolors')
  set termguicolors
endif

let g:solarized_termcolors=256

"set background=dark
"colorscheme molokai 
"colorscheme solarized
"colorscheme wombat256
"colorscheme iceberg
"colorscheme elflord
"colorscheme nagomi

syntax on  "enable syntax highlighting

"----------------------------
"languege specific config
"----------------------------
filetype on
autocmd FileType Makefile setlocal noexpandtab
source ~/dotfiles/nvim/language/c.vim
