
ENV DEBIAN_FRONTEND=noninteractive

# USER marc

RUN apt-get update

RUN apt-get install -y \
				apt-utils \
				sudo \
        make \
        cmake \
				curl \
				wget \
				git \
				gnupg2

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update

RUN apt-get install -y \
        python3 \
        golang \
        nodejs \
        yarn \
				nvm \
        # doas \
				bat \
				tmux \
				ranger \
        neovim \
        zsh \
        nmap \
				openssh \
				docker \
				docker.io

RUN apt-get update

RUN chsh -s $(which zsh)
RUN exec zsh

SHELL ["/usr/bin/zsh", "-c"]

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
RUN cd ~/.pyenv && src/configure && make -C src

RUN mkdir ~/git
RUN git clone https://marcpartensky:marcgptl44@github.com/marcpartensky/dotfiles ~/git/dotfiles

RUN mkdir ~/.config
RUN git clone https://github.com/marcpartensky/nvim ~/.config/nvim

# RUN chmod -R +rwx ~/.config/nvim
# RUN chmod +rwx ~/.vimrc
RUN nvim --headless +PlugInstall +qall
# RUN source ~/.config/nvim/vim-plug/plugins.vim
# RUN nvim --headless +PlugInstall +qall >/dev/null 2>&1

RUN zsh ~/git/dotfiles/main.sh
RUN exec zsh

RUN restart
RUN source ~/git/dotfiles/main.sh

# RUN sshd

# RUN addgroup -S guest
# RUN useradd -ms /usr/bin/zsh guest

# RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 ubuntu
# USER ubuntu
# WORKDIR /home/ubuntu

