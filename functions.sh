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
			pipenv shell
			pipenv install
			n Locking
			$(pipenv lock --pre --clear &> /var/log/pipenv.log && n Locked) & disown
    fi
}

dc() {
	if [ "$1" != "-f" ]; then
		if [ -f $PWD/docker-compose.yml ]; then
			docker-compose --file $PWD/docker-compose.yml $@
		else
			docker-compose --file $PROGRAMS_DOCKER_PATH/docker-compose.yml $@
			if [ "$1" = "up" ]; then
				if [ "$2" = "-d" ]; then
					docker-compose --file $PROGRAMS_DOCKER_PATH/docker-compose.yml logs -f ${@: 3}
				else
					docker-compose --file $PROGRAMS_DOCKER_PATH/docker-compose.yml logs -f ${@: 2}
				fi
			elif [ "$1" = "start" ]; then
				docker-compose --file $PROGRAMS_DOCKER_PATH/docker-compose.yml logs -f ${@: 2}
			elif [ "$1" = "restart" ]; then
				docker-compose --file $PROGRAMS_DOCKER_PATH/docker-compose.yml logs -f ${@: 2}
			fi
		fi
	fi
}

p() {
	if [ -d $PROGRAMS_PATH/$1 ]; then
		cd $PROGRAMS_PATH/$1
	else
		cd $PROGRAMS_PATH
		if command -v gh; then
			gh repo clone $1
		else
			git clone https://github.com/$1
		fi
		f=$(basename $1)
		f=$(/bin/ls | grep -i $f)
		fm=$(echo $f | tr '[A-Z]' '[a-z]')
		mv -v $f $fm
		cd $fm
	fi
}

updategit() {
	for f in `/bin/ls $PROGRAMS_PATH`; do; printf "\e[1m$f\e[0m: "; git -C $f pull ; done
}


# brew() {
# 	/usr/bin/env brew >& /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# 	/usr/bin/env brew $@
# }

# rename() {
# 	/usr/bin/env rename >& /dev/null || brew install rename
# 	/usr/bin/env rename $@
# }

gh() {
	/usr/bin/env gh >& /dev/null || brew install gh
	/usr/bin/env gh $@
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
alias postman="open -a 'Postman'"

openyoutube() {
	open -a 'Google Chrome' "https://www.youtube.com/results?search_query=$1"
}

spam() {
	exec "messengerterminal";
	exec "/search $1";
	exec "0";
	for i in {1...$3}; do
		exec $2;
	done
}

troll() {
	sleep $1;
	for i in {1..$2}; do
		osascript -e 'display notification "you are useless"'
		say "you are useless"
	done
}

dlmusic() {
	youtube-dl -ciw -x --audio-format "mp3" --audio-quality 0 -f bestaudio --embed-thumbnail -o '%(title)s.%(ext)s' --rm-cache-dir  $*
}

dlvideo() {
	youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' -ciw --audio-quality 0 --embed-thumbnail -o '%(title)s.%(ext)s' --rm-cache-dir  $*
}

ytdl() {
	youtube-dl -ciw -x --audio-format 'mp3' --audio-quality 0 -f bestaudio --embed-thumbnail -o '%(title)s.%(ext)s' --rm-cache-dir
}

weather() {
	curl wttr.in/$@
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


urlparse() {
	local proto="$(echo $1 | grep :// | sed -e's,^\(.*://\).*,\1,g')"
	local url=$(echo $1 | sed -e s,$proto,,g)
	local user="$(echo $url | grep @ | cut -d@ -f1)"
	local hostport=$(echo $url | sed -e s,$user@,,g | cut -d/ -f1)
	local host="$(echo $hostport | sed -e 's,:.*,,g')"
	local port="$(echo $hostport | sed -e 's,^.*:,:,g' -e 's,.*:\([0-9]*\).*,\1,g' -e 's,[^0-9],,g')"
	local path="$(echo $url | grep / | cut -d/ -f2-)"
	echo $url
	echo $proto
	echo $user
	echo $host
	echo $port
	echo $path
}

expose() {
	echo $1
	local source_port=$(httprandomvpsport)
	# local proto="$(echo $1 | grep :// | sed -e's,^\(.*://\).*,\1,g')"
	# local url=$(echo $1 | sed -e s,$proto,,g)
	# local user="$(echo $url | grep @ | cut -d@ -f1)"
	# local hostport=$(echo $url | sed -e s,$user@,,g | cut -d/ -f1)
	# local host="$(echo $hostport | sed -e 's,:.*,,g')"
	# local port="$(echo $hostport | sed -e 's,^.*:,:,g' -e 's,.*:\([0-9]*\).*,\1,g' -e 's,[^0-9],,g')"
	# local path="$(echo $url | grep / | cut -d/ -f2-)"

	if [ $# -eq 1 ]; then
		local host=${2:-"localhost"}
		local port=$1
	elif [ $# -eq 2 ]; then
		local host=$1
		local port=$2
	elif [ $# -eq 3 ]; then
		# if [ $1 -eq http ]; then
		local host=$1
		local port=$2
		source_port=$3
	fi
	echo $host
	echo $port
	echo "${proto}marcpartensky.com:$source_port"
	if [ -f ~/.ssh/expose ]; then
		ssh -i ~/.ssh/expose -R $source_port:$host:$port expose@marcpartensky.com -N -p 7022
	else
		ssh -R $source_port:$host:$port expose@marcpartensky.com -N -p 7022
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

spy() {
	watch -n 0.5 ps -jFu $@
}

countdown() {
	$(sleep $1 && terminal-notifier -title "Time is up!" -message "$1 seconds passed") & disown
}

trim() {
	echo $1 | awk '{$1=$1};1'
}

focus() {
	index=$1; eval "$(yabai -m query --spaces | jq --argjson index "${index}" -r '(.[] | select(.index == $index).windows[0]) as $wid | if $wid then "yabai -m window --focus \"" + ($wid | tostring) + "\"" else "skhd --key \"ctrl - " + (map(select(."native-fullscreen" == 0)) | index(map(select(.index == $index))) + 1 % 10 | tostring) + "\"" end')"
}

webserver() {
	while true; do echo "HTTP/1.1 200 OK\nContent-Type: text/html; charset=UTF-8\nServer: netcat!\n\n" $2 | nc -vlp $1 -c; sleep 1; done
	# echo "HTTP/1.1 200 OK\nContent-Type: text/html; charset=UTF-8\nServer: netcat!\n\n" $2 | nc -vlp $1 -c
}

httpcode() {
	while true; do echo "HTTP/1.1 $3\nContent-Type: text/html; charset=UTF-8\nServer: netcat!\n\n" $2 | nc -vlp $1 -c -w 0.5; done
}

\#() {
	echo $1 >> /var/log/hashtag.log
}

ms() {
	echo "Playlist: $1"
	mkdir /Volumes/\$/Musique/Youtube/$1
	cd /Volumes/\$/Musique/Youtube/$1
}

sshupdate(){
	ssh vps $(curl -sL marcpartensky.com//update | bash) &
	ssh tower $(curl -sL marcpartensky.com//update | bash) &
	ssh boulimix $(curl -sL marcpartensky.com//update | bash) &
	ssh gigabix $(curl -sL marcpartensky.com//update | bash) &
	ssh idefix $(curl -sL marcpartensky.com//update | bash) &
	ssh boulimix $(curl -sL marcpartensky.com//update | bash) &
	ssh memorix $(curl -sL marcpartensky.com//update | bash) &
	ssh pandemix $(curl -sL marcpartensky.com//update | bash) &
	ssh phoenix $(curl -sL marcpartensky.com//update | bash) &
	ssh phoenix-staging $(curl -sL marcpartensky.com//update | bash) &
}

progress-bar() {
  local duration=${1}
    already_done() { for ((done=0; done<$elapsed; done++)); do printf "▇"; done }
    remaining() { for ((remain=$elapsed; remain<$duration; remain++)); do printf " "; done }
    percentage() { printf "| %s%%" $(( (($elapsed)*100)/($duration)*100/100 )); }
    clean_line() { printf "\r"; }
  for (( elapsed=1; elapsed<=$duration; elapsed++ )); do
      already_done; remaining; percentage
      sleep 1
      clean_line
  done
  clean_line
}


mountall() {
	for i in $(/bin/ls /etc/systemd/system/*.mount); do
		sudo systemctl start $(basename $i)
	done
}

proxmox() {
	pass -c proxmox
	$(sleep 1 && xdg-open https://proxmox) &
	sudo ssh -NL 127.0.0.6:443:192.168.0.16:8006 kong
}

webedgix() {
	$(sleep 1 && xdg-open https://edgix) &
	sudo ssh -NL 127.0.0.1:443:192.168.0.1:443 kong
}

novpn() {
	sudo ssh -NL 127.0.0.1:443:192.168.0.1:443 kong &
	sudo ssh -NL 127.0.0.6:443:192.168.0.6:443 kong &
	sudo ssh -NL 127.0.0.16:443:192.168.0.16:8006 kong &
	# sudo ssh -NL 127.0.0.18:443:192.168.0.18:443 kong &
	# sudo ssh -NL 127.0.0.19:443:192.168.0.19:443 kong &
	# sudo ssh -NL 127.0.0.145:443:192.168.0.145:443 kong &
	# sudo ssh -NL 127.0.0.29:80:192.168.0.29:80 kong &
}

darkproxmox() {
	ssh marc@gigabix sudo ./PVEDiscordDark.sh install
}

whiteproxmox() {
	ssh marc@gigabix sudo ./PVEDiscordDark.sh uninstall
}


# progress_bar()
# {
#   local DURATION=$1
#   local INT=0.25      # refresh interval

#   local TIME=0
#   local CURLEN=0
#   local SECS=0
#   local FRACTION=0

#   local FB=2588       # full block

#   trap "echo -e $(tput cnorm); trap - SIGINT; return" SIGINT

#   echo -ne "$(tput civis)\r$(tput el)│"                # clean line

#   local START=$( date +%s%N )

#   while [ $SECS -lt $DURATION ]; do
#     local COLS=$( tput cols )

#     # main bar
#     local L=$( bc -l <<< "( ( $COLS - 5 ) * $TIME  ) / ($DURATION-$INT)" | awk '{ printf "%f", $0 }' )
#     local N=$( bc -l <<< $L                                              | awk '{ printf "%d", $0 }' )

#     [ $FRACTION -ne 0 ] && echo -ne "$( tput cub 1 )"  # erase partial block

#     if [ $N -gt $CURLEN ]; then
#       for i in $( seq 1 $(( N - CURLEN )) ); do
#         echo -ne \\u$FB
#       done
#       CURLEN=$N
#     fi

#     # partial block adjustment
#     FRACTION=$( bc -l <<< "( $L - $N ) * 8" | awk '{ printf "%.0f", $0 }' )

#     if [ $FRACTION -ne 0 ]; then 
#       local PB=$( printf %x $(( 0x258F - FRACTION + 1 )) )
#       echo -ne \\u$PB
#     fi

#     # percentage progress
#     local PROGRESS=$( bc -l <<< "( 100 * $TIME ) / ($DURATION-$INT)" | awk '{ printf "%.0f", $0 }' )
#     echo -ne "$( tput sc )"                            # save pos
#     echo -ne "\r$( tput cuf $(( COLS - 6 )) )"         # move cur
#     echo -ne "│ $PROGRESS%"
#     echo -ne "$( tput rc )"                            # restore pos

#     TIME=$( bc -l <<< "$TIME + $INT" | awk '{ printf "%f", $0 }' )
#     SECS=$( bc -l <<<  $TIME         | awk '{ printf "%d", $0 }' )

#     # take into account loop execution time
#     local END=$( date +%s%N )
#     local DELTA=$( bc -l <<< "$INT - ( $END - $START )/1000000000" \
#                    | awk '{ if ( $0 > 0 ) printf "%f", $0; else print "0" }' )
#     sleep $DELTA
#     START=$( date +%s%N )
#   done

#   echo $(tput cnorm)
#   trap - SIGINT
# }
gitregister () { $(echo $1 || echo $PWD) >> $GIT_RECORD }
gitunregister() { grep -v $1 $GIT_RECORD > /tmp/gitrecord; mv /tmp/gitrecord $GIT_RECORD }
gitrecord() { cat $GIT_RECORD }
gitupdate() { for gitpath in $(cat $GIT_RECORD); do; git -c $gitpath pull; done }

docker-clean() {
	docker service rm $(docker service ls -q)
}

snapdump() {
	snap list | tail -n +2 | awk '{print $1}' > snapfile.txt
}

snapbundle() {
	for dependency in $(cat snapfile.txt); do
		snap install $dependency
	done
}
