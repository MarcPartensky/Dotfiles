FROM ubuntu
FROM dind

ENV DEBIAN_FRONTEND=noninteractive

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
        nmap \
        curl \
        zsh

RUN mkdir -p ~/git/dotfiles
COPY . ~/git/dotfiles
WORKDIR ~/git/dotfiles

RUN chsh -s /usr/bin/zsh
SHELL ["/usr/bin/zsh", "-c"]

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
RUN cd ~/.pyenv && src/configure && make -C src

RUN zsh ~/git/dotfiles/main.sh
RUN source ~/git/dotfiles/main.sh

# Nvim
RUN mkdir ~/.config
RUN git clone https://github.com/marcpartensky/nvim ~/.config/nvim

# RUN chmod -R +rwx ~/.config/nvim
RUN curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/pug.vim
RUN chmod +rwx ~/.vimrc
RUN source ~/.config/nvim/vim-plug/plugins.vim
RUN nvim --headless +PlugInstall +qall
# RUN nvim --headless +PlugInstall +qall >/dev/null 2>&1
