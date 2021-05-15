#!/bin/sh

# This file aims to install my dotfiles config in any unix system.

# install git no matter the os
if [[ $(uname Darwin) ]]; then
	brew install git
elif [[ $(uname Linux) ]]; then
	apt update
	apt install -y git
	apt install -y zsh
fi

run_dockerfile() {
	export DEBIAN_FRONTEND=noninteractive
	apt-get update
	apt-get install -y software-properties-common
	add-apt-repository ppa:neovim-ppa/unstable
	apt-get install -y --no-install-recommends \
        git \
        golang \
				nodejs \
        npm \
        make \
        nmap \
        curl \
				wget \
				unzip \
				python3-dev \
				python3-pip \
				cowsay \
				lolcat \
				apt-transport-https \
				ca-certificates \
				gnupg-agent \
				openssh-server \
				tmate \
				podman \
				neovim \
				locales \
				sudo \
        zsh
				# file \
				# ruby-full \
				# build-essential
        # doas

	service ssh start
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
	add-apt-repository \
		"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
		$(lsb_release -cs) stable"
	apt update
	apt install -y docker-ce

RUN localedef -i en_US -f UTF-8 en_US.UTF-8
RUN npm i -g yarn
RUN pip3 install --user neovim
# RUN rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash linuxbrew && \
    echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
USER linuxbrew
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

USER root
RUN git clone https://github.com/marcpartensky/dotfiles ~/git/dotfiles
# COPY /root/git/dotfiles /root/git/dotfiles
RUN chsh -s /usr/bin/zsh
SHELL ["/usr/bin/zsh", "-c"]
RUN curl https://pyenv.run | bash
RUN source ~/git/dotfiles/main.sh

RUN git clone https://github.com/marcpartensky/nvim ~/.config/nvim
# COPY .config/nvim /root/.config/nvim
COPY .config/coc /root/.config/coc
# COPY .config/ranger ~/.config/ranger

WORKDIR /tmp
RUN wget https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip
RUN unzip  -d exa exa-linux-x86_64-v0.10.1.zip
RUN mv exa/bin/exa /usr/bin/exa
RUN mv exa/man/* /usr/local/man
RUN chmod +x /usr/bin/exa
RUN rm -r exa

RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
RUN unzip ngrok-stable-linux-amd64.zip
RUN rm ngrok-stable-linux-amd64.zip
RUN mv ngrok /usr/local/bin

WORKDIR /root
RUN touch .vimrc
RUN nvim \
	+"source ~/.config/nvim/vim-plug/plugins.vim" \
	+PlugUpdate \
	+UpdateRemotePlugins \
	+CocUpdate \
	+qall

RUN echo "git -C ~/.config/nvim pull" >> ~/.zshrc
RUN echo "git -C ~/git/dotfiles pull" >> ~/.zshrc

ENTRYPOINT ["zsh"]
}

# clone dotfiles repo
chsh -s /
mkdir ~/git
git clone https://github.com/marcpartensky/dotfiles -C ~/git
source ~/git/dotfiles/main.sh

# install docker if not installed
if [[ -d $(which docker) ]]; then
	getdocker
fi

# install docker-compose
if [[ -d $(which docker) ]]; then
	getdocker
fi

# docker-compse up with '/' as volume
docker-compose up -d
