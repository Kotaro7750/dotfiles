set hidden "can change buffer without saving
filetype on "can recognize filetype
 
let g:LanguageClient_loggingFile = expand('~/LanguageClient.log')
let g:LanguageClient_loggingLevel = 'DEBUG'

let g:LanguageClient_serverCommands = {
\ 'sh': ['bash-language-server', 'start'],
\ 'python': ['~/nvim-python3/bin/pyls'],
\ 'go': [$GOPATH.'/bin/gopls'],
\ 'c': ['clangd-9'],
\ 'cpp': ['clangd-9'],
\ 'rust': ['rls'],
\ 'javascript': ['typescript-language-server','--stdio'],
\ 'typescript': ['typescript-language-server','--stdio'], 
\ 'verilog': ['svls'],
\ 'systemverilog': ['svls'],
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
    autocmd CursorHold *.c,*.h,*.py,*.cpp,*.hpp,*.rs,*.go,*.sh,*.js,*.ts call LanguageClient#textDocument_documentHighlight()
    autocmd CursorMoved *.c,*.h,*.py,*.cpp,*.hpp,*.rs,*.go,*.sh,*.js,*.ts call LanguageClient#clearDocumentHighlight()
augroup END

augroup LanguageClient_config
  autocmd!
  autocmd User LanguageClientStarted call lightline#update()
  autocmd User LanguageClientStopped call lightline#update()
  autocmd User LanguageClientDiagnosticsChanged call lightline#update()
augroup END

autocmd BufWritePre *.h,*.cpp,*.hpp,*.rs,*.py,*go,*.sh,*.js,*.ts call LanguageClient#textDocument_formatting_sync()

"50ms
set updatetime=50

let g:LanguageClient_semanticHighlightMaps = {}
let g:LanguageClient_semanticHighlightMaps['cpp'] = {
            \   'entity.name.function.cpp': 'Identifier',
            \   'entity.name.function.method.cpp': 'Identifier',
            \   'entity.name.type.class.cpp': 'Identifier',
            \   'entity.name.type.enum.cpp': 'Type',
            \   'variable.other.cpp': 'Identifier',
            \   'variable.other.enummember.cpp': 'Type',
            \   'variable.other.field.cpp': 'Type',
            \   'entity.name.type.template.cpp': 'Type',
            \   'entity.name.namespace.cpp': 'Special',
            \ }
