#!/usr/bin/env zsh
ln -snf ${0:a:h}/.gitconfig $HOME
ln -snf ${0:a:h}/.zshenv $HOME
ln -snf ${0:a:h}/.p10k.zsh $HOME
ln -snf ${0:a:h}/.tmux.conf $HOME
ln -snf ${0:a:h}/.tmate.conf $HOME
ln -snf ${0:a:h}/.yabairc $HOME
ln -snf ${0:a:h}/.skhdrc $HOME
mkdir -p $HOME/.config/bspwm
ln -snf ${0:a:h}/bspwmrc $HOME/.config/bspwm/bspwmrc
mkdir -p $HOME/.config/sxhkd
ln -snf ${0:a:h}/sxhkdrc $HOME/.config/sxhkd/sxhkdrc
mkdir -p $HOME/.config/alacritty
ln -snf ${0:a:h}/alacritty.yml $HOME/.config/alacritty/alacritty.yml
# ln -snf ${0:a:h}/.docker/config.json $HOME/.docker/config.json
