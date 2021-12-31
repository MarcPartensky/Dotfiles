dump:
	brew bundle dump -f
	snapdump
	dconf dump / > ${DOTFILES_PATH}/gnome.conf
restore:
	brew bundle
	snaprestore
build:
	docker build /home/marc -f Dockerfile -t marcpartensky/env
push:
	docker push marcpartensky/env
run:
	docker run -it --name env marcpartensky/env
	docker rm env
