[![Docker](https://github.com/MarcPartensky/Dotfiles/actions/workflows/docker.yml/badge.svg)](https://github.com/MarcPartensky/Dotfiles/actions/workflows/docker.yml)
# My dotfiles config.

## Zsh plugins
* zsh autocomplete

## Aliases
* dotm => ./main.sh
* dotf => ./functions.sh
* dota => ./aliases.sh
* dote => ./exports.sh
* dotz => ~/.zshenv
* dott => ~/.tmux.conf
* dotg => ~/.gitconfig
* doti => ~/.gitignore_global

## Symlinks

### Zshenv
```sh
ln -s .zshenv ~/.zshenv
```

### Alacritty
```sh
ln -s alacritty.yml ~/.config/alacritty/alacritty.yml
```

### Git
```sh
ln -s .gitconfig ~/.gitconfig
ln -s .gitignore_global ~/.gitignore_global
```

### Tmux
```sh
ln -s .tmux.conf ~/.tmux.conf
```
