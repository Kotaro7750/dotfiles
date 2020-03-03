#!/bin/bash -xeu

#update requirement
source ~/nvim-python3/bin/activate
pip install -r ~/dotfiles/init/linux/python/nvim-python3-requirements.txt
deactivate

source ~/nvim-python2/bin/activate
pip install -r ~/dotfiles/init/linux/python/nvim-python2-requirements.txt
deactivate
