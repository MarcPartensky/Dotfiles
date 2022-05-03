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
	docker build /home/marc -f Dockerfile -t marcpartensky/env
push:
	docker push marcpartensky/env
run:
	docker run -it --name env marcpartensky/env
	docker rm env
symlinks:
	./symlinks.sh
stow:
	stow -vt ~ */
