#!/bin/sh

if [[ ! -d ~/.pyenv ]]
then
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	cd ~/.pyenv && src/configure && make -C src && cd -
fi

if [[ ! -d $(pyenv root)/plugins/pyenv-virtualenv ]]
then
	git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
fi
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
