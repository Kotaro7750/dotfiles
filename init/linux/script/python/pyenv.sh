#!/bin/bash -xeu
#install pyenv
git clone git://github.com/yyuu/pyenv.git ~/.pyenv

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#install 2 and 3
pyenv install 3.8.1
pyenv install 2.7.15

#make virtualenv
pyenv global 3.8.1
pip install virtualenv
virtualenv -p python3 ~/nvim-python3

pyenv global 2.7.15
pip install virtualenv
virtualenv -p python ~/nvim-python2

pyenv global system

REQUIREMENT_3=`eval "echo ~/dotfiles/init/linux/python/nvim-python3-requirements.txt"`
if [ ! -e $REQUIREMENT_3 ]; then
  REQUIREMENT_3=`find . -name nvim-python3-requirements\.txt`
fi
#install requirement
source ~/nvim-python3/bin/activate
pip install -r $REQUIREMENT_3
deactivate

REQUIREMENT_2=`eval "echo ~/dotfiles/init/linux/python/nvim-python2-requirements.txt"`
if [ ! -e $REQUIREMENT_2 ]; then
  REQUIREMENT_2=`find . -name nvim-python2-requirements\.txt`
fi
source ~/nvim-python2/bin/activate
pip install -r $REQUIREMENT_2
deactivate
