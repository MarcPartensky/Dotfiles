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
			$(pipenv sync --pre --clear &> /tmp/pipenv.log && n Locked) & disown
    fi
}

dc() {
	if [ "$1" = "-f" ]; then
        docker-compose --file $@
    else
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
        if [[ $1 =~ $REGEX_URL ]]; then
            git -C $PROGRAMS_PATH clone $1
		elif command -v gh; then
			gh repo clone $1
		else
			git clone https://github.com/$1 $PROGRAMS_PATH/$2
		fi
		f=$(basename $1)
		f=$(/bin/ls | grep -i $f)
		fm=$(echo $f | tr '[A-Z]' '[a-z]')
		mv -v $f $fm
		cd $fm
	fi
}

dotc() {
    git -C $DOTFILES_PATH add -A
    git -C $DOTFILES_PATH commit -m $1
    git -C $DOTFILES_PATH push
    exec $SHELL
}

pki() {
    $(command -v apt &>/dev/null && sudo apt install -y $1) ||
    $(command -v dnf &>/dev/null && sudo dnf install -y $1) ||
    $(command -v apk &>/dev/null && sudo apk add $1) ||
    $(command -v brew &>/dev/null && brew install $1) ||
    $(command -v pip &>/dev/null && pip install $1) ||
    $(command -v npm &>/dev/null && npm install --global $1) ||
    $(command -v snap && sudo snap install $1)
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

listswap() {
	ls ~/.local/share/nvim/swap/*
}
swaps() {
	ls ~/.local/share/nvim/swap/*
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
	http -f --follow post https://marc.wf/u$2 target=$1 description=$3
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
	# echo $1
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
	# echo $host
	# echo $port
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

comments() {
    cat $HISTFILE | cut -d';' -f2 | grep -P '^\#'
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
	sudo echo https://proxmox.tun
	$(sleep 1 && xdg-open https://proxmox.tun) &
	sudo ssh -NL 127.0.1.16:443:192.168.0.16:8006 kong
}

webedgix() {
	sudo echo https://edgix.tun
	$(sleep 1 && xdg-open https://edgix.tun) &
	sudo ssh -NL 127.0.1.1:443:192.168.0.1:443 kong
}

ipa() {
    sudo echo https://ipa.tun
    $(sleep 1 && xdg-open https://ipa.tun) &
    sudo ssh -NL 127.0.1.5:443:192.168.0.5:443 kong
}

pihole() {
    sudo echo http://pihole.tun
    $(sleep 1 && xdg-open http://pihole.tun) &
    sudo ssh -NL 127.0.1.6:80:192.168.0.6:80 kong
}

novpn() {
	sudo ssh -NL 127.0.0.1:443:192.168.0.1:443 kong &
    sudo ssh -NL 127.0.0.5:443:192.168.0.5:443 kong &
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
getmetasploit() {
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall

}

fcd() {
	cd $(find -type d | fzf)
}

fv() {
    nvim $(fzf)
}

fp() {
	cd "$PROGRAMS_PATH/$(/bin/ls -1 $PROGRAMS_PATH | fzf)"
}

randomproxy() {
    shuf -n 1 $PROGRAMS_PATH/secrets/proxy.md
}

if ! command -v pbcopy > /dev/stdout ; then
    pbcopy() {
        cat $1 | xclip -selection clipboard
    }
fi

runkraken() {
    git -C $PROGRAMS_PATH/colis21 pull
    git -C $PROGRAMS_PATH/tia21 pull
    git -C $PROGRAMS_PATH/tia21 pull
    code $PROGRAMS_PATH/tia21
    docker-compose -f $PROGRAMS_PATH/tia21/docker-compose.yml up -d mongo lapin
    docker-compose -f $PROGRAMS_PATH/tia21/docker-compose.yml logs -f mongo lapin >> /tmp/kraken.log 2>&1 &
    dotnet run --project $PROGRAMS_PATH/tia21/src/Pssa.Tia21.Web >> /tmp/kraken.log 2>&1 &
    dotnet run --project $PROGRAMS_PATH/tia21/src/Pssa.Tia21.PicktalkIn >> /tmp/kraken.log 2>&1 &
    sleep 5
    xdg-open https://localhost:5000
}

gwl() {
    repo=$(gh repo view --json 'nameWithOwner' --jq '.nameWithOwner')
    gh workflow list | awk '{print $3}' | while read line ; do
        echo https://github.com/$repo/runs/$line?check_suite_focus=true
    done
}

# CB to copy in clipboard no matter the os
LINUX_copy(){
    cat | xclip -selection clipboard
}

LINUX_paste(){
    xclip -selection clipboard -o
}

WSL_copy(){
    cat | /mnt/c/Windows/System32/clip.exe
}

WSL_paste(){
    /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe Get-Clipboard | sed 's/\r//'
}

CYGWIN_copy(){
    cat > /dev/clipboard
}

CYGWIN_paste(){
    cat /dev/clipboard
}


MAC_copy(){
    cat | pbcopy
}

MAC_paste(){
    pbpaste
}

stdin_is_a_pipe(){
    [[ -p /dev/stdin ]]
}

stdin_is_a_tty(){
    [[ -t 0 ]]
}

stdin_is_pipe_like(){
    stdin_is_a_pipe || ! stdin_is_a_tty
}

stdout_is_pipe_like(){
    ! stdout_is_a_tty # meaning # it must be a pipe or redirection
}

stdout_is_a_tty(){
    [[ -t 1 ]]
}

requested_open_ended(){
    [[ "${args[0]:-}" == "-" ]]
}

requested_test_suite(){
    [[ "${args[0]:-}" == "--test" ]]
}

enable_tee_like_chaining(){
    # see `man tee`
    if stdout_is_pipe_like; then
        ${os}_paste
    elif requested_open_ended; then
        ${os}_paste
        echo
    fi
}

prevent_prompt_from_being_on_the_same_line(){
    if stdout_is_a_tty; then # we don't have to be strict about not altering the output
        echo
    fi
}

detect_os(){
    if [[ -f /proc/version ]] && grep -iq Microsoft /proc/version; then
        printf WSL
    else
        case "$(uname -s)" in
            Linux*)     printf LINUX;;
            Darwin*)    printf MAC;;
            CYGWIN*)    printf CYGWIN;;
        esac
    fi
}

test_suite(){
    # setup
    printf '1234' | ${BASH_SOURCE[0]}

    printf "\n1. output to TTY\n"
    ${BASH_SOURCE[0]}
    printf "1234 should be above.\n"

    printf "\n2. output to pipe\n"
    ${BASH_SOURCE[0]} | cat; echo
    printf "1234 should be above.\n"

    printf "\n3. input from pipe and output to pipe\n"
    printf '1234' | ${BASH_SOURCE[0]} | cat; echo
    printf "1234 should be above.\n"
}

function debug(){
    stdin_is_a_pipe      && echo "stdin_is_a_pipe: 1"     >> /tmp/ono ||  echo "stdin_is_a_pipe: 0"     >> /tmp/ono
    stdin_is_a_tty       && echo "stdin_is_a_tty: 1"      >> /tmp/ono ||  echo "stdin_is_a_tty: 0"      >> /tmp/ono
    stdin_is_pipe_like   && echo "stdin_is_pipe_like: 1"  >> /tmp/ono ||  echo "stdin_is_pipe_like: 0"  >> /tmp/ono
    stdout_is_pipe_like  && echo "stdout_is_pipe_like: 1" >> /tmp/ono ||  echo "stdout_is_pipe_like: 0" >> /tmp/ono
    stdout_is_a_tty      && echo "stdout_is_a_tty: 1"     >> /tmp/ono ||  echo "stdout_is_a_tty: 0"     >> /tmp/ono
    echo >> /tmp/ono
}

maincopy(){
    os="$(detect_os)"
    if stdin_is_pipe_like; then
        ${os}_copy
        enable_tee_like_chaining
    else # stdin is not pipe-like
        ${os}_paste
        prevent_prompt_from_being_on_the_same_line
    fi
}

cb() {
    args=("$@")
    if requested_test_suite; then
        export DEBUG=1
        test_suite
    else
        [[ ${DEBUG:-} == 1 ]] && debug
        maincopy
    fi
}
portkill() {
    kill -9 $(lsof -i:$1 | tail -1 | awk '{print $2}')
}


pt5() {
    echo $$ > /tmp/pt5.pid
    # git -C $PROGRAMS_PATH/colis21 pull pickup master:master
    docker-compose -f $PROGRAMS_PATH/colis21/docker-compose.yml up -d mongo lapin elasticsearch
    sleep 5
    # dotnet run --project $PROGRAMS_PATH/colis21/src/Pssa.Colis21.MainEventService >& /tmp/c21_maineventservice.log &
    ASPNETCORE_ENVIRONMENT=Development dotnet run --project $PROGRAMS_PATH/colis21/src/Pssa.Colis21.ModuleWebHost >& /tmp/c21_modulewebhost.log &
    npm --prefix $PROGRAMS_PATH/colis21/src/Pssa.Colis21.ModuleWebHost/React start >& /tmp/c21_react.log &
    tail -f /tmp/c21_*.log
}

pt5kill() {
    kill $(cat /tmp/pt5.pid)
}


pt5log() {
    tail -f /tmp/c21_*.log
}

extract_pids() {
    awk '{
        if (NF == 1) { print -$1 }
        else if (NF > 1) {
            if ($2 == "+" || $2 == "-") { print -$3 }
            else { print -$2 }
        }
    }'
}

kaj() {
    jobs -p | extract_pids | xargs --no-run-if-empty kill -TERM -- || true
}
whereami() {
    echo $PWD $HOST $(curl -s ipinfo.io | jq -r '[.ip,.city] | @tsv')
}

# Give vnc access to tower inside of a docker container
vnctower() {
    ssh tower docker-compose -f /home/marc/git/docker/tower.yml up -d novnc
    ssh -R 5900:localhost:5900 tower
}

# man() {
#     LESS_TERMCAP_md=$'\e[01;31m' \
#     LESS_TERMCAP_me=$'\e[0m' \
#     LESS_TERMCAP_us=$'\e[01;32m' \
#     LESS_TERMCAP_ue=$'\e[0m' \
#     LESS_TERMCAP_so=$'\e[45;93m' \
#     LESS_TERMCAP_se=$'\e[0m' \
#     command man "$@"
# }

set_title() {
    echo -en "\e]0;$*\a"
}
prettyarpscan() {
    sudo arp-scan $@ | awk '/([a-f0-9]{2}:){5}[a-f0-9]{2}/&&!seen[$1]++{print $1}'
}

iswireless() {
    lshw -C network | grep Wireless
}
