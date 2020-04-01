#!/bin/sh -xeu
sudo apt-get update

#zshのインストールと設定
./script/zsh.sh

#英字キーボード用の設定
sudo apt-get -y install fcitx fcitx-mozc

#dockerのインストール
./script/docker.sh

#neovimのインストールと設定
./script/nvim.sh

#python周り
./script/python/pyenv.sh

#albert
./script/albert.sh

#latex
./script/latex.sh
