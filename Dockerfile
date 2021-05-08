FROM ubuntu

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
				# libtool \
				# libtool-bin \
				# exa \
        nmap \
        curl \
				wget \
				# fuse \
				# libfuse2 \
				# python3-pip \
				# ack-grep \
				cowsay \
				lolcat \
        zsh
				# pkg-config \
				# build-essential
        # doas

# RUN curl https://sh.rustup.rs -sSf | sh

RUN apt update

# RUN modprobe fuse
# RUN groupadd fuse
# RUN user="$(whoami)"
# RUN usermod -a -G fuse $user

RUN localedef -i en_US -f UTF-8 en_US.UTF-8


COPY . /root/git/dotfiles
WORKDIR /root/git/dotfiles

RUN chsh -s /usr/bin/zsh
SHELL ["/usr/bin/zsh", "-c"]

RUn curl https://pyenv.run | bash
RUN source main.sh

# Nvim
# WORKDIR /tmp
# RUN wget https://github.com/neovim/neovim/archive/nightly.tar.gz
# RUN tar -xzvf nightly.tar.gz
# WORKDIR neovim-nightly
# RUN make
# RUN make install

RUN wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
RUN ./nvim.appimage --appimage-extract
RUN ln -s ./squashfs-root/usr/bin/nvim /usr/bin/nvim
RUN chmod +x /usr/bin/nvim

# RUN wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvim
# RUN chmod +x nvim
# RUN chown root:root nvim
# RUN mv nvim /usr/bin

# RUN exec zsh

# RUN pyenv install 3.9-dev
# RUN pip install neovim

WORKDIR ~
RUN mkdir ~/.config
RUN git clone https://github.com/marcpartensky/nvim ~/.config/nvim

# RUN chmod -R +rwx ~/.config/nvim
RUN curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# RUN nvim --headless +"source ~/.config/nvim/vim-plug/plugins.vim" +PlugInstall +UpdateRemotePlugins +qall

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
# RUN locale-gen en_US.UTF-8

ENTRYPOINT ["zsh"]
