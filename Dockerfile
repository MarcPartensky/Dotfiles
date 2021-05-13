FROM ubuntu:20.10

LABEL maintainer="Marc Partensky <marc.partensky@gmail.com"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install -y --no-install-recommends \
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
				podman \
				neovim \
				locales \
        zsh
				# file \
				# ruby-full \
				# build-essential
        # doas

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) stable"
RUN apt update
RUN apt install -y docker-ce

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
COPY git/dotfiles /root/git/dotfiles
RUN chsh -s /usr/bin/zsh
SHELL ["/usr/bin/zsh", "-c"]
RUN curl https://pyenv.run | bash
RUN source ~/git/dotfiles/main.sh

# RUN git clone https://github.com/marcpartensky/nvim ~/.config/nvim
COPY .config/nvim /root/.config/nvim
COPY .config/coc /root/.config/coc
# COPY .config/ranger ~/.config/ranger

RUN wget https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip
RUN unzip  -d exa exa-linux-x86_64-v0.10.1.zip
RUN mv exa/bin/exa /usr/bin/exa
RUN mv exa/man/* /usr/local/man
RUN chmod +x /usr/bin/exa
RUN rm -r exa

WORKDIR /root
RUN touch .vimrc
RUN nvim \
	+"source ~/.config/nvim/vim-plug/plugins.vim" \
	# +CocInstall \
	+PlugUpdate \
	+UpdateRemotePlugins \
	+qall

ENTRYPOINT ["zsh"]
