FROM ubuntu
MAINTAINER Marc Partensky marc.partensky@gmail.com

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/usr/bin:/opt/local/bin:/opt/local/sbin:$PATH"

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
				python2 \
        python3.9 \
        golang \
        nodejs \
        yarn \
				# nvm \
        # doas \
				bat \
				tmux \
				ranger \
        neovim \
        zsh \
        nmap \
				# openssh \
				docker \
				docker.io

# For compiling python for pyenv
RUN apt-get install -y \
				bzip2 \
				python3-distutils \
				python3-apt

RUN ln -s /usr/bin/python3 /bin/python
RUN curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
RUN /bin/python /tmp/get-pip.py
RUN rm /tmp/get-pip.py
RUN /bin/python -m pip install pynvim neovim pylint black

RUN apt-get update
RUN apt-get autoremove
RUN apt-get upgrade -y

RUN yarn global add neovim

RUN chsh -s $(which zsh)
RUN exec zsh

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
RUN cd ~/.pyenv && src/configure && make -C src

RUN mkdir ~/git
RUN git clone https://marcpartensky:marcgptl44@github.com/marcpartensky/dotfiles ~/git/dotfiles

RUN mkdir ~/.config
RUN git clone https://github.com/marcpartensky/nvim ~/.config/nvim

SHELL ["/usr/bin/zsh", "-c"]
RUN exec zsh
RUN zsh

RUN zsh ~/git/dotfiles/antigen.zsh
RUN zsh ~/git/dotfiles/main.sh

RUN source ~/git/dotfiles/antigen.zsh
RUN source ~/git/dotfiles/main.sh

RUN restart
RUN exec zsh

RUN nvim --headless +'source ~/.config/nvim/vim-plug/plugins.vim' +qall

RUN nvim --headless +PlugInstall +qall

RUN nvim --headless +CocInstall +qall
RUN nvim +CocUpdateSync +qall

RUN nvim +'CocInstall -sync coc-json' +qall
# RUn nvim +'CocInstall coc-json' +qall
# RUN nvim +CocInstall coc-json
RUN nvim +CocUpdateSync +qall

# RUN nvim +'CocInstall -sync coc-svg' +qall
# RUN nvim +'CocUpdateSync +qall
# RUN nvim +'CocInstall -sync coc-json' +qall
# RUN nvim --headless +PlugInstall +qall >/dev/null 2>&1
# RUN chmod -R +rwx ~/.config/nvim
# RUN chmod +rwx ~/.vimrc

WORKDIR /root
RUN cd

ENTRYPOINT ["zsh"]

# RUN sshd

# RUN addgroup -S guest
# RUN useradd -ms /usr/bin/zsh guest

# RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 ubuntu
# USER ubuntu
