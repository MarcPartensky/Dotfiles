ln -snf ${0:a:h}/.gitconfig $HOME
ln -snf ${0:a:h}/.zshenv $HOME
ln -snf ${0:a:h}/.p10k.zsh $HOME
ln -snf ${0:a:h}/.tmux.conf $HOME
ln -snf ${0:a:h}/.tmate.conf $HOME
ln -snf ${0:a:h}/.yabairc $HOME
ln -snf ${0:a:h}/.skhdrc $HOME
mkdir -p $HOME/.config/alacritty
ln -snf ${0:a:h}/alacritty.yml $HOME/.config/alacritty/alacritty.yml
# ln -snf ${0:a:h}/.docker/config.json $HOME/.docker/config.json
