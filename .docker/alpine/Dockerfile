FROM alpine

LABEL maintainer="Marc Partensky <marc.partensky@gmail.com>"

RUN apk upgrade
RUN apk add neovim \
			git \
			go \
			nodejs \
			npm \
			make \
			nmap \
			exa \
            curl \
			wget \
            python3 \
            py3-pip \
			ca-certificates \
			# gnupg-agent \
			openssh-server \
			neovim \
			# locales \
			sudo \
			# build-essential \
			docker \
            stow \
			zsh \
            bash \
            shadow

RUN useradd --create-home --groups wheel --shell /usr/bin/zsh marc
RUN passwd -d marc
RUN echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
# RUN localedef -i en_US -f UTF-8 en_US.UTF-8
RUN npm i -g yarn

USER marc
RUN pip install --user neovim
RUN git clone https://github.com/marcpartensky/dotfiles ~/git/dotfiles
SHELL ["/bin/zsh", "-c"]
RUN curl https://pyenv.run | bash
RUN source ~/git/dotfiles/main.sh

# RUN useradd -m -s /usr/bin/zsh linuxbrew
# USER linuxbrew
# RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
# ENV PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

# USER root
# ENV PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
# RUN git clone https://github.com/marcpartensky/nvim ~/.config/nvim

WORKDIR /root/git/dotfiles
RUN make stow

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
RUN rm .profile

ENTRYPOINT ["zsh"]
