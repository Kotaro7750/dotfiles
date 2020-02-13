#!/bin/sh
sudo apt-get update

#zshのインストールと設定
./zsh.sh

#英字キーボード用の設定
sudo apt-get -y install fcitx fcitx-mozc

#dockerのインストール
./docker.sh

#neovimのインストールと設定
./nvim.sh

#python周り
./python/pyenv.sh

#albert
./albert.sh

#リンク作成
./link.sh
