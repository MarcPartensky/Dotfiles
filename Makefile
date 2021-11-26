dump:
	brew bundle dump -f
	snapdump
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
