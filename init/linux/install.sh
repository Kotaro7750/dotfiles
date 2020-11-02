#!/bin/sh -xeu
sudo apt-get update

. ./isWSL.sh

#zshのインストールと設定
./script/zsh.sh

#英字キーボード用の設定
sudo apt-get -y install fcitx fcitx-mozc

#dockerのインストール
if !isWSL ; then
  ./script/docker.sh
fi

#neovimのインストールと設定
./script/nvim.sh

#python周り
./script/python/pyenv.sh

#albert
if ! isWSL ; then
  ./script/albert.sh
fi

#latex
if ! isWSL ; then
  ./script/latex.sh
fi

#tmux
./script/tmux.sh
