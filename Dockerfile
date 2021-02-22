FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

# USER marc

ENV DEBIAN_FRONTEND=noninteractive

# USER marc
RUN apt-get update

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

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
				tmux \
				ranger \
        neovim \
        nmap \
        curl \
        zsh

RUN apt-get update

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

=======

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
RUN cd ~/.pyenv && src/configure && make -C src

RUN mkdir ~/git

RUN mkdir ~/git
RUN git clone https://marcpartensky:marcgptl44@github.com/marcpartensky/dotfiles ~/git/dotfiles

RUN zsh ~/git/dotfiles/main.sh
RUN source ~/git/dotfiles/main.sh

RUN mkdir ~/.config
RUN git clone https://github.com/marcpartensky/nvim ~/.config/nvim

# RUN chmod -R +rwx ~/.config/nvim
RUN curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN chmod +rwx ~/.vimrc
RUN source ~/.config/nvim/vim-plug/plugins.vim
RUN nvim --headless +PlugInstall +qall
# RUN nvim --headless +PlugInstall +qall >/dev/null 2>&1
(END)
