dump:
	dconf dump / > ${DOTFILES_PATH}/.gnome.conf
	dnf history userinstalled > ${DOTFILES_PATH}/.dnf.conf
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
