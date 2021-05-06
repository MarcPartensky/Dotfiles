FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y \
        git \
        golang \
        npm \
        make \
        cmake \
				automake \
				libtool \
        nmap \
        curl \
				wget \
				fuse \
				libfuse2 \
				python3-pip \
				ack-grep \
				cowsay \
				lolcat \
        zsh \
				pkg-config \
				build-essential
        # doas

RUN apt update
RUN apt upgrade

COPY . /root/git/dotfiles
WORKDIR /root/git/dotfiles

RUN chsh -s /usr/bin/zsh
SHELL ["/usr/bin/zsh", "-c"]

RUn curl https://pyenv.run | bash
RUN source main.sh

# Nvim
WORKDIR /tmp
RUN wget https://github.com/neovim/neovim/archive/nightly.tar.gz
RUN tar -xzvf nightly.tar.gz
WORKDIR neovim-nightly
RUN make
RUN make install

# RUN wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvim
# RUN chmod +x nvim
# RUN chown root:root nvim
# RUN mv nvim /usr/bin

# RUN exec zsh

# RUN pyenv install 3.9-dev
RUN pip install neovim

WORKDIR ~
RUN mkdir ~/.config
RUN git clone https://github.com/marcpartensky/nvim ~/.config/nvim

# RUN chmod -R +rwx ~/.config/nvim
RUN curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN nvim --headless +"source ~/.config/nvim/vim-plug/plugins.vim" +PlugInstall +UpdateRemotePlugins +qall

RUN echo "You're good to cow!" | cowsay | lolcat
