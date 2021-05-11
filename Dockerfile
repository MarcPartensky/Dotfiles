FROM ubuntu

LABEL maintainer="Marc Partensky <marc.partensky@gmail.com"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y \
        git \
        golang \
        npm \
        make \
        cmake \
				kmod \
				# automake \
				# exa \
        nmap \
        curl \
				wget \
				python3-pip \
				cowsay \
				lolcat \
        zsh
				# pkg-config \
				# build-essential
        # doas

# RUN curl https://sh.rustup.rs -sSf | sh

RUN apt-get update
RUN apt-get install -y git locales curl wget nodejs npm golang make python3-dev --no-install-recommends
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
RUN npm i -g yarn
# RUN curl https://bootstrap.pypa.io/get-pip.py | python3
RUN python3 -m pip install --user neovim
# RUN rm -rf /var/lib/apt/lists/*

RUN localedef -i en_US -f UTF-8 en_US.UTF-8

RUN apt-get update && \
    apt-get install build-essential curl file git ruby-full locales --no-install-recommends -y && \
    rm -rf /var/lib/apt/lists/*
RUN useradd -m -s /bin/bash linuxbrew && \
    echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
USER linuxbrew
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

USER root
COPY . /root/git/dotfiles
RUN chsh -s /usr/bin/zsh
SHELL ["/usr/bin/zsh", "-c"]
RUN curl https://pyenv.run | bash
RUN source ~/git/dotfiles/main.sh

# Nvim
# WORKDIR /tmp
# RUN wget https://github.com/neovim/neovim/archive/nightly.tar.gz
# RUN tar -xzvf nightly.tar.gz
# WORKDIR neovim-nightly
# RUN make
# RUN make install

# RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
# RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
# RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
# RUN locale-gen en_US.UTF-8

RUN git clone https://github.com/marcpartensky/nvim ~/.config/nvim
# COPY ~/.config/nvim ~/.config/nvim
# COPY ~/.config/coc ~/.config/coc
# COPY ~/.config/ranger ~/.config/ranger

WORKDIR /tmp
RUN wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
RUN tar xzvf nvim-linux64.tar.gz
RUN mv nvim-linux64/bin/nvim /usr/local/bin/nvim
RUN mv nvim-linux64/share/* /usr/local/share
RUN mv nvim-linux64/lib/* /usr/local/lib
RUN chmod +x /usr/local/bin/nvim
RUN rm -r nvim-linux64

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
