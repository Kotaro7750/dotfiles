#!/bin/bash -xeu
rm -f ~/.gdbinit
ln -s ~/dotfiles/gdb/gdbinit ~/.gdbinit

rm -f ~/.gitconfig
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig

rm -f ~/.gitconfig_dir
ln -s ~/dotfiles/git/gitconfig_dir ~/.gitconfig_dir

rm -f ~/.latexmkrc
ln -s ~/dotfiles/latex/latexmkrc ~/.latexmkrc

rm -f ~/.tmux.conf
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

rm -f ~/.config/nvim
mkdir -p ~/.config
ln -s ~/dotfiles/nvim ~/.config/nvim

rm -f ~/.zshrc
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc

rm -rf ~/.zsh_path
ln -s ~/dotfiles/zsh/path ~/.zsh_path
