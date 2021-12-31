#!/usr/bin/env sh

# je
alias phoenix="ssh phoenix"
alias phoenixstaging="ssh phoenix-staging"
alias edgix="ssh edgix"
alias boulimix="ssh boulimix"
alias gigabix="ssh gigabix"
alias idefix="ssh idefix"
alias pandemix="ssh pandemix"
alias memorix="ssh memorix"
alias vpnix="ssh vpnix"
alias playground="ssh playground"
alias passepartix="ssh passepartix"
alias caddy="nvim ~/junior/caddix/Caddyfile"
alias schtroumpfix="cd $PROGRAMS_PATH/schtroumpfix; pipenv shell; nvim main.py"
alias pass="PASSWORD_STORE_ENABLE_EXTENSIONS=true pass"

# Navigation shortcuts
alias programs="p"
alias website="p web"
alias domination="p kingdomino"
alias esclave="p discord-bot"
alias web="p web"
alias pdc="p docker"
alias colis21="p colis"
alias c21="p colis21"
alias tia21="p tia21"
alias t21="p tia21"
alias kraken="p tia21"
alias shell="p shell"
alias desktop="cd ~/desktop"
alias documents="cd ~/documents"
alias images="cd ~/images"
alias downloads="cd ~/downloads"
alias isep="cd /Volumes/$/isep"
alias marc="cd ~/desktop/Marc\ Partensky"
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
alias translator="p colis21/tools/Traduction/Translator"
alias py20="cd ~/programs/python/repository-2020"
alias pygames="cd ~/programs/python/repository-games"
alias pyml="cd ~/programs/python/machine-learning"
alias pyhome="p python"

# basic
alias v="$EDITOR"
alias l="ls"
alias c="cd"
alias s="sudo"
alias sy="systemctl"
alias m="make"
alias t="todo"
alias f="find"
alias d="docker"
alias e='nvim ~/.zshenv'
alias r="restart"
alias u="update"
alias restart="exec $SHELL"
alias update="source $DOTFILES_PATH/update.sh"
alias finder="open ."
alias mcd="mkcdir"
alias desk="desktop"
alias pt="nvim $PROGRAMS_PATH/Markdown/todolist/pickup-todolist.md"
alias todo="nvim $PROGRAMS_PATH/markdown/todolist/todolist.md"
alias tpic="nvim $PROGRAMS_PATH/markdown/todolist/pickup-todolist.md"
alias dk="docker"
alias dcy="nvim docker-compose.yml"
alias db="docker build . -t"
alias dps="docker ps"
alias dcs="dc ps"
alias dcd="dc down"
alias dcu="dc up -d"
alias dcuf="dc up -d --force-recreate"
alias dls="docker service ls"
alias dcl="docker-compose logs -f"
alias dsl="docker service logs --raw -f"
alias drm="docker rm -f"
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
alias dotq="dotquick"
alias dotp="dotpull"
alias ud="dotc"
alias vimrc='v $HOME/.vimrc'
alias ev="cd $HOME/.config/nvim"
alias ez="v $HOME/.zshrc"
alias ei3="v $HOME/.config/i3/config"
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
alias dotquick="nvim $DOTFILES_PATH/quick.sh"
alias dotpull="git -C $DOTFILES_PATH pull && restart"
alias dotssh="nvim ~/.ssh/config"
alias servant="cd ~/discordbot/servant-de-marc"
alias esclaveaws="ssh -i 'discordbotofmarcpartensky.pem' ubuntu@ec2-15-236-33-61.eu-west-3.compute.amazonaws.com"
alias mampstart='/Applications/MAMP/bin/start.sh && echo http://localhost:8888/phpmyadmin'
alias mampstop='/Applications/MAMP/bin/stop.sh'
alias jsonbeautify="chrome https://jsonformatter.curiousconcept.com/"
alias github="chrome https://github.com/MarcPartensky/"
alias activate="source venv/bin/activate"
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
alias root="sudo su"
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
alias cnje="ssh cnje"
alias pegasus="ssh pegasus"
alias prospectixback="ssh tower \"cd git/prospectix7-api; $SHELL\""
alias roulezchampions="ssh roulezchampions"
alias sharkhttp="tshark -d tcp.port==443,http"
alias sharkwho="tshark -d tcp.port==22,ssh"
alias sharkssh="tshark -d udp.port==53,who"
alias redmatrix="cmatrix -C red"
alias sshc="nvim ~/.ssh/config"
alias ssha="nvim ~/.ssh/authorized_keys"
alias sshp="cat ~/.ssh/id_rsa.pub"
alias sshps="ps aux | grep ssh"
alias sshk="cat ~/.ssh/known_hosts"
alias gpgp="gpg --armor --export 516EAE18A5512CE9"
alias ipconf="curl ipconfig.io"
alias ipinfo="curl ipinfo.io"
alias ipi="http -b ipinfo.io"
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
alias did="docker ps -a | awk '{ print $2 }'"
alias iptel="arp -a | grep \$MAC_TEL | cut -d \"(\" -f2 | cut -d \")\" -f1"
alias iplocal="open http://net.ipcalf.com"
alias ipdns="cat /etc/resolv.conf | grep -v # | awk '{print \$2}'"
alias vd="nvim docker-compose.yml"
alias sd="ssh docker"
alias fm="nvim /tmp/fm.txt"
alias timestamp="date +%s"
alias showhiddenfiles="defaults write com.apple.finder AppleShowAllFiles -boolean true; killall Finder;"
alias zshrc="nvim $HOME/.zshrc"
alias zshenv="nvim $HOME/.zshrc"
alias bashrc="nvim $HOME/.bashrc"
alias profile="nvim $HOME/.profile"
alias wh="which"
alias bindcapslock="gsettings set org.gnome.desktop.input-sources xkb-options \"['caps:escape']\""
alias path="echo $PATH"
alias fkill="kill -9"
alias maxuserinstances="echo fs.inotify.max_user_instances=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p"
alias vpn="openvpn"
alias vpn3="openvpn3"
alias insidegitdir="git rev-parse --is-inside-work-tree"
alias robo3t="docker run --rm -d --network host -e DISPLAY -v $HOME/.config/3T:/root/.config/3T -v $HOME/.3T:/root/.3T -v $HOME/.ssh/id_rsa:/root/.ssh/id_rsa -v $HOME/.ssh/config:/root/.ssh/config -v /tmp/.X11-unix:/tmp/.X11-unix marcpartensky/robo3t"
alias krakenrestore="mongorestore -v --host localhost --port 27017 --gzip --archive=krakendump.bzip"
alias vnc="sudo systemctl start vncserver@:1.service"
alias history="history -t'%F %T'"
alias aptu="sudo apt clean && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"
alias dnfu="sudo dnf update -y && sudo dnf autoremove -y"
alias brewu="brew upgrade"
alias spd="speedtest"
alias bot="p discord-bot"
alias debian="docker run -it --rm debian"
alias alpine="docker run -it --rm alpine"
alias archlinux="docker run -it --rm archlinux"
alias spotifyplay="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play"
alias spotifystop="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause"
alias spotifytoggle="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
alias spotifiprevious="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"
alias spotifynext="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"
alias previous="spotifypause"
alias next="spotifynext"
alias play="spotifyplay"
alias pause="spotifystop"
alias lowbright="brightnessctl s 1%"
alias highbright="brightnessctl s 100%"
alias bright="brightnessctl"
alias pause="read -rsp $'Press any key to continue...\n' -n1 key"
alias p7f="p prospectix7-front"
alias p7b="p prospectix7-api"
alias p7="p prospectix7"
alias lzd="lazydocker"
alias kj="kill -9 %"
alias getbrew='/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
alias vpn="openvpn3"
alias vpnvps="openvpn3 session-start --config vps-mi.ovpn"
alias vpnvpsstop="openvpn3 session-manage --config vps-mi.ovpn --disconnect"
alias vpnje="openvpn3 session-start --config je.ovpn"
alias vpnjestop="openvpn3 session-manage --config je.ovpn --disconnect"
alias vpnlist="openvpn3 sessions-list"
alias gnomeimportovpn="sudo nmcli connection import type openvpn file"
[ -z upower ] && alias battery="upower -i `upower -e | grep 'BAT'`"
alias rawbattery="cat /sys/class/power_supply/BAT0/capacity"
alias dotpickup="v $DOTFILES_PATH/pickup.sh"
alias c21dump="cd $C21_DUMP_PATH"
alias dumpgnome="dconf dump / > $DOTFILES_PATH/gnome.conf"
alias restoregnome="dconf load / < $DOTFILES_PATH/gnome.conf"
