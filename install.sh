#!/bin/sh

sudo apt-get -y install zsh
sudo apt-get -y install curl
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
echo "DO 'chsh' to change default shell!!"

sudo apt -y install python3-pip python3-dev
sudo apt -y install python-pip python-dev

sudo apt-get -y install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get -y update
sudo apt-get -y install neovim
pip3 install neovim
pip install neovim
sudo apt -y install clang
sudo apt -y install libclang-dev

ln -s ~/dotfiles/nvim ~/.nvim
