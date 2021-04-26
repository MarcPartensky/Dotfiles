#!/usr/bin/env sh

alias v="nvim"
alias ls="exa"
alias restart="exec $SHELL"
alias finder="open ."
alias mcd="mkcdir"
alias desk="desktop"
alias t="todo"
alias todo="nvim $PROGRAMS_PATH/markdown/todolist/todolist.md"
alias tpic="nvim $PROGRAMS_PATH/markdown/todolist/pickup-todolist.md"
alias dk="docker"
alias dc="docker-compose"
alias dota="dotaliases"
alias dotm="dotmain"
alias dotf="dotfunctions"
alias dote="dotexports"
alias dotz="dotzshenv"
alias vimrc='nvim ~/.vimrc'
alias ev="cd ~/.config/nvim"
alias ez='nvim ~/.zshrc'
alias e='nvim ~/.zshenv'
alias dotfiles="cd $DOTFILES_PATH"
alias dotmain="v $DOTFILES_PATH/main.sh"
alias dotaliases="v $DOTFILES_PATH/aliases.sh"
alias dotfunctions="v $DOTFILES_PATH/functions.sh"
alias dotexports="v $DOTFILES_PATH/exports.sh"
alias dotzshenv="v $DOTFILES_PATH/.zshenv"
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
alias alacritty="v ~/.config/alacritty/alacritty.yml"
alias ports="lsof -Pn -i4"
alias ports2="netstat -ap tcp"
alias network="watch -n 1 \"netstat -p tcp\""
alias isep="cd /Volumes/$/isep"
alias youtube='cd /Volumes/\$/Musique/Youtube'
alias yt="youtube"

# Navigation shortcuts
alias home='cd'
alias desktop="cd ~/desktop"
alias documents="cd ~/documents"
alias images="cd ~/images"
alias downloads="cd ~/downloads"

# Programming shortcuts
alias programs='cd ~/programs/'
alias website='cd ~/programs/website'
alias web='cd ~/programs/web'
alias javascript='cd ~/programs/web/javascript'
alias canvas='cd ~/programs/web/javascript/canvas'
alias html='cd ~/programs/web/html'
alias css="cd ~/programs/web/css"
alias wadjet='cd ~/unity games/asteroids'
alias gitprojects="cd ~/git-projects"
alias brain="cd ~/programs/brainperformer"

# Quick temporary aliases
alias asteroids="cd ~/programs/web/javascript/canvas/asteroids"
alias server="ssh remote-root"
