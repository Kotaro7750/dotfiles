#!/bin/bash
#install pyenv
git clone git://github.com/yyuu/pyenv.git ~/.pyenv

#install 2 and 3
pyenv install 3.8.1
pyenv install 2.7.15

#install requirement
source ~/dotfiles/nvim/virtualenv/nvim-python2/bin/activate
pip install -r ~/dotfiles/init/linux/python/nvim-python2-requirements.txt
deactivate

source ~/dotfiles/nvim/virtualenv/nvim-python3/bin/activate
pip install -r ~/dotfiles/init/linux/python/nvim-python3-requirements.txt
deactivate
