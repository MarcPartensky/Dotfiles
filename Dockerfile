FROM debian

LABEL maintainer="Marc Partensky <marc.partensky@gmail.com>"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && apt autoremove -y
RUN apt install -y ca-certificates lsb-release gnupg curl software-properties-common
RUN  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && apt-get install docker-ce docker-ce-cli containerd.io -y

RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install -y --no-install-recommends \
			git \
			golang \
			nodejs \
			npm \
			make \
			nmap \
			tldr \
			exa \
			wget \
			python3-dev \
			python3-pip \
			apt-transport-https \
			ca-certificates \
			gnupg-agent \
			openssh-server \
			tmate \
			neovim \
			locales \
			sudo \
			build-essential \
			tldr \
			docker \
			zsh

RUN localedef -i en_US -f UTF-8 en_US.UTF-8
RUN npm i -g yarn
RUN pip3 install --user neovim

RUN git clone https://github.com/marcpartensky/dotfiles ~/git/dotfiles
RUN chsh -s /usr/bin/zsh
SHELL ["/usr/bin/zsh", "-c"]
RUN curl https://pyenv.run | bash
RUN source ~/git/dotfiles/main.sh

RUN useradd -m -s /usr/bin/zsh linuxbrew
USER linuxbrew
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
ENV PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

USER root
ENV PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
RUN git clone https://github.com/marcpartensky/nvim ~/.config/nvim

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
