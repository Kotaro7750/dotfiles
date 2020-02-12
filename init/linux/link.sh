#!/bin/bash
rm ~/.gdbinit
ln -s ~/dotfiles/gdb/gdbinit ~/.gdbinit

rm ~/.gitconfig
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig

rm ~/.latexmkrc
ln -s ~/dotfiles/latex/latexmkrc ~/.latexmkrc

rm ~/.tmux.conf
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

rm ~/.config/nvim
ln -s ~/dotfiles/nvim ~/.config/nvim

rm ~/.zshrc
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
