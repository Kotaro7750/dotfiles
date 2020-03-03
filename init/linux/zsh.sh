#!/bin/bash -xeu
sudo apt-get update
sudo apt-get -y install zsh curl
#zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
