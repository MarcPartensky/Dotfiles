#!/bin/sh

eval `curl -sSL marcpartensky.com//brew`
mkdir -p $HOME/git
mkdir -p $HOME/.config

git clone https://github.com/marcpartensky/dotfiles $HOME/git
git clone https://github.com/marcpartensky/nvim $HOME/.config

