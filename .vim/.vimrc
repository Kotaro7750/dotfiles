" setting
set nocompatible
set encoding=utf-8  "set encoding when opening file
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
let mapleader = "\<Space>"

" カーソル系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
"左右移動で行末から次の行へ移動可能
set whichwrap=b,s,h,l,<,>,[,],~  
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk
"バックスペースの有効化
set backspace=indent,eol,start


"マウス系
"マウス有効化
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

"ペースト系
"ペースト時のインデント無効
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


" ビープ音を可視化
set visualbell


"括弧・タグジャンプ
" 括弧入力時の対応する括弧を表示
set showmatch
" Vimの%を拡張する
source $VIMRUNTIME/macros/matchit.vim  


"表示系
" ステータスラインを常に表示
set laststatus=2
"タイトル名を表示
set title


"コマンド補完
" コマンドラインの補完
set wildmode=list:longest
"保存するコマンドの数
set history=5000  


" Tab,Indent
set tabstop=2  "indent = 2 spaces.
set softtabstop=2  "連続した空白に対してタブやバックスペースで動く距離
set shiftwidth=2  "width when new line
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
set expandtab  "Tab = space
set autoindent  "改行時に前のインデントを継続
set smartindent  "enable smartindent


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>


let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  "vimprocの設定
call dein#add('Shougo/vimproc.vim',{'build':'make'})
  
  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  "let g:rc_dir = expand('~/dotfies/.vim/rc)'
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

"set background=dark
colorscheme molokai 
"colorscheme solarized
" シンタックスハイライト
syntax on

"----------------------------
"プラグインの設定
"----------------------------

"-----NERDTree-----

autocmd VimEnter * execute 'NERDTree'
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden = 1

"-----neocomplete,neosnippet-----

"Vim起動時にneocomplete有効化
let g:neocomplete#enable_at_startup = 1
"smartcase有効化　大文字が入力されるまで大小を区別しない
let g:neocomplete#enable_smart_case = 1
"3文字以上の単語に対して補完を有効にする
let g:neocomplete#min_keyboard_length = 3
"区切り文字まで補完する
let g:neocomplete#enable_auto_delimiter = 1
"１文字目の入力から補完のポップアップ表示
let g:neocomplete#auto_completion_start_length = 1
"バックスペースで補完のポップアップを閉じる
inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"
"エンターキーで補完候補の確定、スニペットの展開もエンターキーで確定
imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
"タブキーで補完候補の選択、スニペット内のジャンプもタブキー
imap <expr><TAB>  pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"


"-----lightline-----
let g:lightline = {
        \ 'colorscheme': 'wombat' ,
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode'
        \ }
        \ }

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
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
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


"-----caw.vim-----

"行の最初の文字の前にコメント文字をトグル
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)


"-----unite.vim-----

"バッファ一覧
noremap <C-P> :Unite buffer<CR>
"ファイル一覧
noremap <C-N> :Unite -buffer-name=file<CR>
"最近使ったファイル一覧
noremap <C-Z> :Unite file_mru<CR>
"最近開いたファイルの履歴数
let g:unite_source_file_mru_limit = 50
"ESCキーを２回で終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <silent> <ESC><ESC> <ESC> :q<CR>

"-----マークダウン関連------
autocmd BufRead,BufNewFile *.{mkd,md,mdwn,mkdn,mark*} set filetype=markdown
nnoremap <silent> <C-p> :PrevimOpen<CR>
let g:vim_markdown_fonlding_disabled=1
"----
