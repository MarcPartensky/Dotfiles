ln -snf ${0:a:h}/.gitconfig ~
ln -snf ${0:a:h}/.zshenv ~
ln -snf ${0:a:h}/.p10k.zsh ~
ln -snf ${0:a:h}/.tmux.conf ~
ln -snf ${0:a:h}/.yabairc ~
ln -snf ${0:a:h}/.skhdrc ~
mkdir -p ~/.config/alacritty
ln -snf ${0:a:h}/alacritty.yml ~/.config/alacritty/alacritty.yml
# ln -snf ${0:a:h}/.docker/config.json ~/.docker/config.json
