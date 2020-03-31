set hidden "can change buffer without saving
filetype on "can recognize filetype

let g:LanguageClient_serverCommands = {
\ 'sh': ['bash-language-server', 'start'],
\ 'python': ['~/nvim-python3/bin/pyls'],
\ 'go': [$GOPATH.'/bin/gopls'],
\ 'c': ['clangd-8'],
\ 'cpp': ['clangd-8'],
\ 'javascript': ['typescript-language-server','--stdio'],
\ 'typescript': ['typescript-language-server','--stdio'], 
\ 'verilog': ['svls'],
\ 'tex': ['texlab'],
\ }

let g:LanguageClient_rootMarkers = {
    \ 'go': ['go.mod'],
    \ 'javascript': ['jsconfig.json','babel.config.json','.eslintrc.json'],
    \ 'typescript': ['tsconfig.json','babel.config.json','.eslintrc.json'],
    \ }

let g:LanguageClient_autoStart = 1
let g:LanguageClient_virtualTextPrefix = "[LC]: "

nnoremap <silent> <Leader>lk :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <Leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <Leader>li :call LanguageClient#textDocument_implementation()<CR>
nnoremap <silent> <Leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <Leader>lf :call LanguageClient#textDocument_formatting()<CR>

let s:filetype_list=["*.c","*.h","*.py","*.cpp","*.go","*.sh"]

augroup LCHighlight
    autocmd!
    autocmd CursorHold *.c,*.h,*.py,*.cpp,*.hpp,*.go,*.sh,*.js,*.ts call LanguageClient#textDocument_documentHighlight()
    autocmd CursorMoved *.c,*.h,*.py,*.cpp,*.hpp,*.go,*.sh,*.js,*.ts call LanguageClient#clearDocumentHighlight()
    "autocmd CursorHold *.c,*.h,*.py,*.cpp,*.go,*.sh call LanguageClient#textDocument_hover()
    "autocmd CursorHold *.py,*.c,*.cpp call LanguageClient#textDocument_hover()
augroup END

    autocmd BufWritePre *.c,*.h,*.cpp,*.hpp,*.py,*go,*.sh,*.js,*.ts call LanguageClient#textDocument_formatting_sync()

"50ms
set updatetime=50
