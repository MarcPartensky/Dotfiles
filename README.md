[![Docker](https://github.com/MarcPartensky/Dotfiles/actions/workflows/docker.yml/badge.svg)](https://github.com/MarcPartensky/Dotfiles/actions/workflows/docker.yml)
# My dotfiles config.
[![Logo](https://repository-images.githubusercontent.com/326477236/556f52f7-61e7-43b0-b2b9-c7f98886dc9b)](https://hub.docker.com/repository/docker/marcpartensky/dotfiles)

## Run with Docker
```
docker run -it marcpartensky/dotfiles
```

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
