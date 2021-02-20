FROM ubuntu:lastest

RUN apt-get update
RUN apt-get install -y \
	git \
	python3 \
	golang \
	nodejs \
	yarn \
	make \
	cmake \
	doas \
	nmap \
	zsh

# Install docker in the docker container

RUN chsh /usr/bin/zsh
RUN exec /usr/bin/zsh

RUN mkdir .config
RUN git clone -C .config https://github.com/marcpartensky/nvim

RUN mkdir git
RUN git clone -C git https://github.com/marcpartensky/dotfiles

RUN source ~/git/dotfiles/main.sh
