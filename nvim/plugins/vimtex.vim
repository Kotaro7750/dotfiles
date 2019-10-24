if has("mac")
  let g:latex_latexmk_options = '-pdf'
  let g:vimtex_imap_enabled = 0

endif

let g:latex_latexmk_options = '-pdf'
let g:vimtex_quickfix_open_on_warning = 0

let g:vimtex_compiler_latexmk = {
      \ 'background': 1,
      \ 'build_dir': '',
      \ 'continuous': 1,
      \ 'options': [
      \    '-pdfdvi', 
      \    '-verbose',
      \    '-file-line-error',
      \    '-synctex=1',
      \    '-interaction=nonstopmode',
      \],
      \}

let g:vimtex_view_general_options = '-r @line @pdf @tex'

autocmd BufEnter *.ltx :VimtexCompile
