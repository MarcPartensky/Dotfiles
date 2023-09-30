stow:
	stow -vt ~ */
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
	docker-compose -f .docker/docker-compose.yml build alpine
push:
	docker-compose -f .docker/docker-compose.yml push alpine
run:
	docker-compose -f .docker/docker-compose.yml --rm run alpine
symlinks:
	./symlinks.sh
zip:
	zip -r -9 dotfiles.zip .
nixos:
	sudo ln -sf $(PWD)/nixos/.config/nixos/* /etc/nixos/
