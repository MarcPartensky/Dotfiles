#!/bin/sh

cd() {
    # actually change the directory with all args passed to the function
    builtin cd "$@"
    # if there's a regular file named `run.sh`
    if [ -f "run.sh" ] ; then
        source run.sh
    fi
    if [ -d ".git" ] ; then
			git pull
    fi
    if [ -f "Pipfile" ] ; then
			echo -e "\e[31mLocking\e[0m"
			$(pipenv lock --pre --clear &> /var/log/pipenv.log && echo -e "\e[31mLocked\e[0m") &
    fi
}

mkcdir() {
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

exists() {
	which $1 &> /dev/null
}

# if exists percol; then
#     percol_select_history() {
#         local tac
#         exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
#         BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
#         CURSOR=$#BUFFER         # move cursor
#         zle -R -c               # refresh
#     }

#     zle -N percol_select_history
#     bindkey '^R' percol_select_history
# fi

div() {
  local _d=${3:-2}
  local _n=0000000000
  _n=${_n:0:$_d}
  local _r=$(($1$_n/$2))
  _r=${_r:0:-$_d}.${_r: -$_d}
  return $_r
}

# Ffmpeg
speedup() {
	local n=$(python3 -c "print(1/$3)" 2>&1)
	ffmpeg -i $1 -filterv "setpts=$n*PTS" $2
}

filename=""
copy() {
	filename=$1
	echo $filename is copied
	cat $1 | pbcopy
}

paste() {
	echo $filename is pasted
	pbpaste > $filename
}

# alias chrome="open -a 'Google Chrome' $1"
# alias daisy="open -a 'DaisyDisk'"

search() {
	open -a 'Google Chrome' "http://www.google.com/search?q=$1"
}

alias chrome="open -a 'Google Chrome' $1";
alias daisy="open -a 'DaisyDisk'"

openyoutube() {
	open -a 'Google Chrome' "https://www.youtube.com/results?search_query=$1"
}

openmessenger() {
	open -a 'Google Chrome' "https://www.facebook.com/messages"
}

messengerterminal() {
	exec "fb-messenger-cli"
}

alias postman="open -a 'Postman'"

spam() {
	exec "messengerterminal";
	exec "/search $1";
	exec "0";
	for i in {1...$3}
	do
		exec $2;
	done
}

troll() {
	sleep $1;
	for i in {1..$2}
	do
		osascript -e 'display notification "you are useless"'
		say "you are useless"
	done
}

touchtyping() {
	open -a 'Google Chrome' 'https://www.typingclub.com/sportal/program-3.game'
}

keybr() {
	open -a 'Google Chrome' 'https://keybr.com'
}

dlmusic() {
	youtube-dl -ciw -x --audio-format "mp3" --audio-quality 0 -f bestaudio --embed-thumbnail -o '%(title)s.%(ext)s' --rm-cache-dir  $*
}

ytdl() {
	youtube-dl -ciw -x --audio-format 'mp3' --audio-quality 0 -f bestaudio --embed-thumbnail -o '%(title)s.%(ext)s' --rm-cache-dir
}

weather() {
	curl wttr.in
}

p() {
	cd ~/$PROGRAMS_PATH/$@
}

pj() {
	cd ~/$GIT_PROJECTS/$@
}

n() {
	terminal-notifier -message $@
}

getdocker() {
	curl -fsSL https://get.docker.com | sh
}

clearswap() {
	rm ~/.local/share/nvim/swap/*
}

giterase() {
	git filter-branch --force --index-filter "git rm --cached --ignore-unmatch $@" --prune-empty --tag-name-filter cat -- --all
}

gitfetch() {
	if [ ! -d $2 ]
	then
		git clone $2 $1
	else
		git --git-dir=$2 pull $1
	fi
}

pullall() {
	for repo_name in $(find $PROGRAMS_PATH -maxdepth 1 -type d); do
		echo $repo_name/.git
		git --work-tree=$repo_name --git-dir=$repo_name/.git pull
	done
}

pushall() {
	for repo_name in $(find $PROGRAMS_PATH -maxdepth 1 -type d); do
		echo $repo_name/.git
		git push --repo $repo_name
	done
}

secret() {
	openssl rand -base64 64
}

readme() {
	bat README.md
}


cheat() {
	curl cheat.sh/$@
}

url() {
	http -f --follow post https://marcpartensky.com/u$2 target=$1 description=$3
}

format() {
	scp $1 vps:pandoc/$1
	ssh vps pandoc /root/pandoc/$1 -o /root/pandoc/$2
	scp vps:pandoc/$2 $2
	ssh vps rm /root/pandoc/$1 /root/pandoc/$2
}

compress() {
	if [ $(uname) == Linux ]; then
		tar cf - $1 -P | pv -s $(du -sb /$1 | awk '{print $1}') | gzip > big-$1.tar.gz
	elif [ $(uname) == Darwin ]; then
		tar cf - $1 -P | pv -s $(($(du -sk $1 | awk '{print $1}') * 1024)) | gzip > $1.tar.gz
	fi
}

mac2ip() {
	arp -a | grep $1 | awk '{print $2}' | sed -e 's/(//' -e 's/)//'
	# arp -a | grep $1 | cut -d "(" -f2 | cut -d ")" -f1
}

sshtel() {
	ssh -t -p 8022 u0_a425@$(mac2ip $MAC_TEL)
}

arpscanip() {
	arp-scan -l | awk 'NR>3 { print $1 }' | sort | uniq | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
}

dns2ip() {
	nslookup $1 | grep -E 'Address: [0-9]' | awk '{print $2}'
}

# default port range allocation should be within 49152 and 65535 but choosing ports within firewall exposed ports range
randomport() {
	local port=${1:-1}
	comm -23 <(seq 49152 65535 | sort) <(ss -htan | awk '{print $4}' | cut -d':' -f2 | sort -u) | shuf | head -n $port
}

# get a random vps port within allowed range using ssh
sshrandomvpsport() {
	local port=${1:-1}
	ssh expose@marcpartensky.com -p 7022 "comm -23 <(seq 8000 8099 | sort) <(ss -Htan | awk '{print $4}' | cut -d':' -f2 | sort -u) | shuf | head -n $port"
}

# get a random vps port within allowed range using http
httprandomvpsport() {
	local port=${1:-1}
	curl -s https://marcpartensky.com/api/port
}

expose() {
	local source_port=$(httprandomvpsport)
	local host=${2:-"localhost"}
	local target_port=${1:-1}
	echo "marcpartensky.com:$source_port"
	if [ -f ~/.ssh/expose ]; then
		ssh -i ~/.ssh/expose -R $source_port:$host:$target_port expose@marcpartensky.com -N -p 7022
	else
		ssh -R $source_port:$host:$target_port expose@marcpartensky.com -N -p 7022
	fi
}

pst() {
	pstree -ps $@
}

wallpaper() {
	osascript -e 'tell application "System Events" to tell first Desktop to get its picture'
}

killapp() {
	osascript -e "quit app \"$1\""
}
