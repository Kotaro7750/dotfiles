"can change buffer without saving
set hidden

"can recognize filetype
filetype on

let g:LanguageClient_serverCommands = {
\ 'python': ['pyls'],
\ 'go': [$GOPATH.'/bin/go-langserver','-format-tool','gofmt','-lint-tool','golint'],
\ 'c': ['clangd-8'],
\ 'cpp': ['clangd-8'],
\ }

let g:LanguageClient_autoStart = 1

nnoremap <silent> <Leader>lk :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <Leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <Leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <Leader>lf :call LanguageClient#textDocument_formatting()<CR>


autocmd BufWritePost *.c :call LanguageClient#textDocument_formatting()
autocmd BufWritePost *.h :call LanguageClient#textDocument_formatting()
