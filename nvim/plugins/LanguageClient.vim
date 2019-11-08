set hidden "can change buffer without saving
filetype on "can recognize filetype

let g:LanguageClient_serverCommands = {
\ 'python': ['pyls'],
\ 'go': [$GOPATH.'/bin/gopls'],
\ 'c': ['clangd-8'],
\ 'cpp': ['clangd-8'],
\ 'javascript': ['javascript-typescript-stdio'],
\ 'typescript': ['javascript-typescript-stdio'], 
\ }

let g:LanguageClient_rootMarkers = {
    \ 'go': ['go.mod'],
    \ 'javascript': ['jsconfig.json'],
    \ 'typescript': ['tsconfig.json'],
    \ }

let g:LanguageClient_autoStart = 1

nnoremap <silent> <Leader>lk :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <Leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <Leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <Leader>lf :call LanguageClient#textDocument_formatting()<CR>

autocmd BufWritePre *.c :call LanguageClient#textDocument_formatting_sync()
autocmd BufWritePre *.h :call LanguageClient#textDocument_formatting_sync()
autocmd BufWritePre *.cpp :call LanguageClient#textDocument_formatting_sync()
autocmd BufWritePre *.python :call LanguageClient#textDocument_formatting_sync()
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
