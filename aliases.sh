#!/usr/bin/env sh

alias v="nvim"
alias l="ls"
alias s="ssh"
alias m="make"
alias t="todo"
alias f="find . -name"
alias d="docker"
alias e='nvim ~/.zshenv'
alias vim="nvim"
alias ls="exa"
alias ll="exa -la"
alias la="exa -a"
alias restart="exec $SHELL"
alias finder="open ."
alias mcd="mkcdir"
alias desk="desktop"
alias pt="nvim $PROGRAMS_PATH/Markdown/todolist/pickup-todolist.md"
alias todo="nvim $PROGRAMS_PATH/markdown/todolist/todolist.md"
alias tpic="nvim $PROGRAMS_PATH/markdown/todolist/pickup-todolist.md"
alias dk="docker"
# alias dc="docker-compose"
alias d="docker"
alias dotd="dotfiles"
alias dota="dotaliases"
alias dotm="dotmain"
alias dotf="dotfunctions"
alias dote="dotexports"
alias dotz="dotzshenv"
alias dotu="dotupdate"
alias dott="dottmux"
alias dots="dotsymlinks"
alias dotg="dotgit"
alias doti="dotignore"
alias doth="dotssh"
alias vimrc='nvim ~/.vimrc'
alias ev="cd ~/.config/nvim"
alias ez='nvim ~/.zshrc'
alias dotfiles="cd $DOTFILES_PATH"
alias dotmain="nvim $DOTFILES_PATH/main.sh"
alias dotaliases="nvim $DOTFILES_PATH/aliases.sh"
alias dotfunctions="nvim $DOTFILES_PATH/functions.sh"
alias dotsymlinks="nvim $DOTFILES_PATH/symlinks.sh"
alias dotexports="nvim $DOTFILES_PATH/exports.sh"
alias dotzshenv="nvim $DOTFILES_PATH/.zshenv"
alias dotupdate="nvim $DOTFILES_PATH/update.sh"
alias dottmux="nvim $DOTFILES_PATH/.tmux.conf"
alias dotgit="nvim $DOTFILES_PATH/.gitconfig"
alias dotignore="nvim $DOTFILES_PATH/.gitignore_global"
alias dotssh="nvim ~/.ssh/config"
alias esclave="cd ~/discordbot/esclave"
alias servant="cd ~/discordbot/servant-de-marc"
alias esclaveaws="ssh -i 'discordbotofmarcpartensky.pem' ubuntu@ec2-15-236-33-61.eu-west-3.compute.amazonaws.com"
alias mampstart='/Applications/MAMP/bin/start.sh && echo http://localhost:8888/phpmyadmin'
alias mampstop='/Applications/MAMP/bin/stop.sh'
alias jsonbeautify="chrome https://jsonformatter.curiousconcept.com/"
alias github="chrome https://github.com/MarcPartensky/"
alias activate="source venv/bin/activate"
alias py20='cd ~/programs/python/repository-2020'
alias pygames='cd ~/programs/python/repository-games'
alias pyml='cd ~/programs/python/machine-learning'
alias pyhome='cd ~/programs/python'
alias pypackages='cd /library/frameworks/python.framework/versions/3.8/lib/python3.8/site-packages/'
alias tetris="bastet"
alias spaceinvader="ninvaders"
alias alacrittyrc="nvim ~/.config/alacritty/alacritty.yml"
alias yabairc="nvim ~/.yabairc"
alias skhdrc="nvim ~/.config/skhd/skhdrc"
alias ports="lsof -Pn -i4"
alias ports2="netstat -ap tcp"
alias openports="netstat -plant"
alias network="watch -n 1 \"netstat -p tcp\""
# alias youtube='cd /Volumes/\$/Musique/Youtube'
# alias yt="youtube"
alias runsh="nvim run.sh"
alias ignore="nvim .gitignore"
alias preview="nvim +MarkdownPreview README.md"
alias dockerfile="nvim Dockerfile"
alias makefile="nvim Makefile"
alias vps="ssh vps"
alias tel="ssh tel"
alias tablette="ssh tablette"
alias mini="ssh mini"
alias tower="ssh tower"
alias minilocal="ssh minilocal"
alias towerlocal="ssh towerlocal"
alias kong="ssh kong"
alias gigabix="ssh gigabix"
alias sharkhttp="tshark -d tcp.port==443,http"
alias sharkwho="tshark -d tcp.port==22,ssh"
alias sharkssh="tshark -d udp.port==53,who"
alias redmatrix="cmatrix -C red"
alias sshc="nvim ~/.ssh/config"
alias ssha="nvim ~/.ssh/authorized_keys"
alias sshp="cat ~/.ssh/id_rsa.pub"
alias sshps="ps aux | grep ssh"
alias sshk="cat ~/.ssh/known_hosts"
alias myip="curl ipconfig.io"
alias updatepyenv="git -C $PYENV_ROOT pull"
alias vpsvpn="sudo openvpn --config ~/junior/macdemarc.ovpn"
alias osxupdate="softwareupdate --all --install --force"
alias to="nvim $PROGRAMS_PATH/markdown/oxivia.md"
alias planformation="open /Users/marcpartensky/Desktop/Marc\ Partensky/AutoEntreprise/Formation/plan_de_formation.docx"
alias cv="$MARCPARTENSKY_PATH/CV/cv-2p && open cv-2p.pages"
alias steph="ssh -t kong ping 192.168.0.31"
alias corinne="ssh -t kong ping 192.168.0.32"
alias didier="ssh -t kong ping 192.168.0.33"
alias boticellix="ssh -t kong ping 192.168.0.27"
alias boulimix="ssh -t kong ping 192.168.0.19"
alias did="docker ps -a | awk '{ print $2 }'"
alias iptel="arp -a | grep \$MAC_TEL | cut -d \"(\" -f2 | cut -d \")\" -f1"
alias iplocal="open http://net.ipcalf.com"
alias ipdns="cat /etc/resolv.conf | grep -v # | awk '{print \$2}'"
alias notif="terminal-notifier"
alias vd="nvim docker-compose.yml"
alias sd="ssh docker"
alias schtroumpfix="cd $PROGRAMS_PATH/schtroumpfix; pipenv shell; nvim main.py"

# Navigation shortcuts
alias cdd="cd ~/docker"
alias desktop="cd ~/desktop"
alias documents="cd ~/documents"
alias images="cd ~/images"
alias downloads="cd ~/downloads"
alias isep="cd /Volumes/$/isep"
alias marc="cd ~/desktop/Marc\ Partensky"
alias programs='cd ~/programs/'
alias website='cd ~/programs/website'
alias domination="cd $PROGRAMS_PATH/kingdomino"
alias web='cd ~/programs/web'
alias javascript='cd ~/programs/web/javascript'
alias canvas='cd ~/programs/web/javascript/canvas'
alias html='cd ~/programs/web/html'
alias css="cd ~/programs/web/css"
alias wadjet='cd ~/unity games/asteroids'
alias gitprojects="cd ~/git-projects"
alias brain="cd ~/programs/brainperformer"
alias asteroids="cd ~/programs/web/javascript/canvas/asteroids"
alias junior="cd ~/junior"
alias cv1="cd $MARCPARTENSKY_PATH/CV/cv-1p"
alias cv2="cd $MARCPARTENSKY_PATH/CV/cv-2p"
alias translator="cd ~/pickup/colis21/tools/Traduction/Translator"
alias phoenix="cd ~/junior/phoenix-api"
alias colis21="cd ~/pickup/colis21"
alias tia21="cd ~/pickup/tia21"
