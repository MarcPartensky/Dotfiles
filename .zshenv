alias mem="du -sh"
alias memfiles="du -sh * | sort -rh;"
alias py="python"
alias pip="python -m pip"
alias pip2="python2 -m pip"
alias pip3="python3 -m pip"

# alias cat=ccat
# Git shortcuts
alias ga="git add -A"
alias gpo="git push origin"
alias gtd="git tag --delete"
alias gtdr="git tag --delete origin"
alias grv="git remote -v"
alias gbr="git branch -r"
alias gplo="git pull origin"
alias grs="git remote show"
alias glo="git log --pretty=\"oneline\""
alias glol="git log --graph --oneline --decorate"
alias glg="git log --graph --all --decorate"
alias grmc="git rm -r --cached ."

function gb { git branch $@ }
function gi { git init $@}
function gs { git status $@ }
function gco { git checkout $@ }
function gpl { git pull $@ }
function gr { git remote $@ }
function gl { git log $@ }
function gd { git diff $@ }
function gp { git push $@ }
function gc {
	echo "git commit -m \"$@\""
	eval "git commit -m \"$@\""
}
function gn { ga; gc $@ }
function gt { ga; gc $@; git push }
function gfp {
	git remote add origin $@
	git branch -M master
	git push -u origin master
}

function p { cd $PROGRAMS_PATH/$@ }
function pj { cd $GIT_PROJECTS_PATH/$@ }

function nodesktopicon {
	defaults write com.apple.finder CreateDesktop false
	killall Finder
}

function desktopicon {
	defaults write com.apple.finder CreateDesktop true
	killall Finder
}

# python programs
alias webpfix='py /users/marcpartensky/programs/python/repository-2020/webpfix.py'
alias glou="py /users/marcpartensky/git-projects/glou"
alias noscreenshots='python /users/marcpartensky/programs/python/repository-2020/no-screenshots.py'
alias video2gif='python /users/marcpartensky/programs/python/repository-2020/video2gif.py'
alias hyperplanning="python /users/marcpartensky/programs/python/repository-2020/isep-hyperplanning.py"
alias portail="python /users/marcpartensky/programs/python/repository-2020/isep-portal.py"

# messenger
alias vivelescookies="chrome https://www.facebook.com/messages/t/1830795903602344"
alias alexandre="chrome https://www.facebook.com/messages/t/alexandre.partensky"
alias maman="chrome https://www.facebook.com/messages/t/pew.pradithja.1"
alias pierre="chrome https://www.facebook.com/messages/t/pierre.barthet.5"
alias bigot="chrome https://www.facebook.com/messages/t/alexandre.bgt.12"
alias valentin="chrome https://www.facebook.com/messages/t/valentin.colin.73"
alias samy="chrome https://www.facebook.com/messages/t/samy.haffoudhi"
alias paul="chrome https://www.facebook.com/messages/t/100009925413499"
alias arnaud="chrome https://www.facebook.com/messages/t/100013962188251"
alias etienne="chrome https://www.facebook.com/messages/t/etienne.faviere"
alias baptiste="chrome https://www.facebook.com/messages/t/100009848792300"
alias lovinsky="chrome https://www.facebook.com/messages/t/skyns82"
alias maxime="chrome https://www.facebook.com/messages/t/100011382659168"
alias jp="chrome https://www.facebook.com/messages/t/jeanpascal.vostatek"
alias maximilien="chrome https://www.facebook.com/messages/t/maximilien.delagastine"
alias sacha="chrome https://www.facebook.com/messages/t/sacha.montassiet.1"
alias thibault="chrome https://www.facebook.com/messages/t/thibaut.moi"
alias philippe="chrome https://www.facebook.com/messages/t/100005499708371"
alias medhi="chrome https://www.facebook.com/messages/t/mehdi.haffoudhi.9"
alias hugues="chrome https://www.facebook.com/messages/t/hugues.rubin"
alias kevin="chrome https://www.facebook.com/messages/t/pandasus.pandasus.1"

# applications
alias chrome="open -a 'google chrome' $1"
alias unity="open -a 'unity'"
alias daisy="open -a 'daisydisk'"
alias terminal="open -a 'iterm'"
alias postman="open -a 'postman'"
alias keybr="chrome https://www.keybr.com/"
alias touch-typing="open -a 'google chrome' 'https://www.typingclub.com/sportal/program-3.game'"
alias change-extension="for file in *.$1; do mv '$file' '${file%.txt}.$2'; done"
function search { open -a 'Google Chrome' "https://www.google.com/search?q=$*" }
function youtube { open -a 'Google Chrome' "https://www.youtube.com/results?search_query=$1" }
function messenger { open -a 'Google Chrome' "https://www.facebook.com/messages"; }
function messenger-terminal { exec "fb-messenger-cli"; }

filename=""
function copy {
	filename=$1
	echo $filename is copied
	cat $1 | pbcopy
}
alias filename='echo $filename'

function paste {
	echo $filename is pasted
	pbpaste > $filename
}

# This is why being lazyness in programming even exists
function cheat { curl cheat.sh/"$@"; }

function compressgif {
    ffmpeg -i $1 -vf scale=320:-1 -r 10 -f image2pipe -vcodec ppm - | convert -delay 5 -loop 0 - $2
}
source "$HOME/.cargo/env"
