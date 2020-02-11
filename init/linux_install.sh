#!/bin/sh
sudo apt-get update

#zsh のインストールと設定
sudo apt-get -y install zsh
sudo apt-get -y install curl
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
echo "DO 'chsh' to change default shell!!"

#英字キーボード用の設定
sudo apt-get -y install fcitx fcitx-mozc

#neovimのインストールと設定
sudo apt -y install python3-pip python3-dev
sudo apt -y install python-pip python-dev

sudo apt-get -y install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get -y install neovim
pip3 install neovim
pip install neovim
sudo apt -y install clang
sudo apt -y install libclang-dev
ln -s ~/dotfiles/nvim ~/.config/nvim

#dockerとdocker-composeのインストール
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get install -y docker-ce
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

##sudoなしでdockerを使えるようにする
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo systemctl restart docker
