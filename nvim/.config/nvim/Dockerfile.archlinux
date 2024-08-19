FROM archlinux:latest

LABEL maintainer="Marc Partensky <marc.partensky@gmail.com"

RUN touch .vimrc
RUN localedef -i en_US -f UTF-8 en_US.UTF-8

RUN pacman -Syu --noconfirm \
        git \
        npm \
        yarn \
#         go \
#         make \
        python-pip \
        neovim

RUN npm i -g neovim
RUN pip install neovim

RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

COPY . /root/.config/nvim
RUN nvim --headless -c "TSInstallSync maintained" -c q
RUN nvim --headless -c PackerSync -c q

RUN nvim --headless \
    +"source /root/.config/nvim/init.lua" \
    +PackerSync \
    +PackerUpdate \
    +qall

# RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

ENTRYPOINT ["nvim", "+checkhealth"]
