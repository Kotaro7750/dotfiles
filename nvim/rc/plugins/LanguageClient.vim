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

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
