#!/bin/sh

# This file aims to install my dotfiles config in any unix system.

# install git no matter the os
if [[ $(uname Darwin) ]]; then
	brew install git
elif [[ $(uname Linux) ]]; then
	apt update
	apt install -y git
fi

# clone dotfiles repo
git clone https://github.com/marcpartensky/dotfiles -C $HOME
source $HOME/main.sh

# install docker if not installed
if [[ -d $(which docker) ]]; then
	getdocker
fi

# install docker-compose
if [[ -d $(which docker) ]]; then
	getdocker
fi

# docker-compse up with '/' as volume
docker-compose up -d
