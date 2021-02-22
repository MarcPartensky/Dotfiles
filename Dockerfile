FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

# USER marc

RUN apt-get update
RUN apt-get install -y \
	git \
	python3 \
	golang \
	nodejs \
	yarn \
	make \
	cmake \
	# doas \
	neovim \
	nmap \
	zsh

# Install docker in the docker container

RUN chsh -s /usr/bin/zsh
RUN exec zsh

SHELL ["/usr/bin/zsh", "-c"]

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
RUN cd ~/.pyenv && src/configure && make -C src

RUN mkdir ~/git
RUN git clone https://marcpartensky:marcgptl44@github.com/marcpartensky/dotfiles ~/git/dotfiles

RUN mkdir ~/.config
RUN git clone https://github.com/marcpartensky/nvim ~/.config/nvim

# RUN chmod -R +rwx ~/.config/nvim
RUN chmod +rwx ~/.vimrc
RUN nvim --headless +PlugInstall +qall
# RUN nvim --headless +PlugInstall +qall >/dev/null 2>&1

RUN zsh ~/git/dotfiles/main.sh
RUN source ~/git/dotfiles/main.sh
