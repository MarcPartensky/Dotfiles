FROM ubuntu

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
        # doas \
				tmux \
				ranger \
        neovim \
        nmap \
        zsh

RUN apt-get update

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
# RUN chmod +rwx ~/.vimrc
RUN nvim --headless +PlugInstall +qall

RUN zsh ~/git/dotfiles/main.sh
RUN exec zsh

RUN restart
RUN source ~/git/dotfiles/main.sh

# RUN source ~/.config/nvim/vim-plug/plugins.vim
# RUN nvim --headless +PlugInstall +qall >/dev/null 2>&1
