augroup templateGroup
autocmd!
autocmd BufNewFile *.ltx :0r ~/dotfiles/nvim/template/tex
autocmd BufNewFile *.py :0r ~/dotfiles/nvim/template/python
augroup END
