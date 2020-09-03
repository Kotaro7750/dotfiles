#!/bin/bash
sudo apt update
sudo apt install -y libevent-dev libncurses-dev bison automake

rm -rf ./tmux
git clone https://github.com/tmux/tmux.git
cd tmux
./autogen.sh
./configure
make
sudo make install
rm -rf ../tmux
