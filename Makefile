dump: gnome dnf brew
gnome:
	dconf dump / > dep/.local/dep/gnome/gnome.conf
dnf:
	dnf history userinstalled > dep/.local/dep/dnf/dnf.conf
brew:
	brew bundle dump -f
restore:
	brew bundle
build:
	docker-compose -f .docker/docker-compose.yml build debian
push:
	docker-compose -f .docker/docker-compose.yml push debian
run:
	docker-compose -f .docker/docker-compose.yml --rm run debian
symlinks:
	./symlinks.sh
stow:
	stow -vt ~ */
zip:
	zip -r -9 dotfiles.zip .
