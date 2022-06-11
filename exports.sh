#!/bin/sh
export MAIN_ENV=arch

# Path variables
export PATH="$PATH:$HOME/git/shell"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"
export PATH="$PATH:$PYENV_ROOT/shims"
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export DOTNET_ROOT="$HOME/.dotnet"
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="$PATH:/usr/local/opt/php@7.1/bin"
export PATH="$PATH:/usr/local/opt/php@7.2/bin"
export PATH="$PATH:/usr/local/opt/openjdk@11/bin"
export PATH="$PATH:/usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home/bin"
export PATH="$PATH:/usr/local/opt/grep/libexec/gnubin"
export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
if [ -d /opt/local/bin ]; then
    export PATH="$PATH:/opt/local/bin"
fi
if [ -d /opt/local/sbin ]; then
    export PATH="$PATH:/opt/local/sbin"
fi
export PATH="$PATH:/opt/gradle/gradle-7.0/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/var/lib/snapd/snap/bin"
export PATH="$PATH:/opt/metasploit-framework/bin"
export PATH=$PATH:$DOTNET_ROOT
export PATH="$PATH:$PROGRAMS_PATH/docker/bin"
export PATH="$PATH:$HOME/.local/share/npm/bin"

# Homebrew
if [ -d /home/linuxbrew ]
then
    export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
    export PATH="$PATH:/home/linuxbrew/.linuxbrew/sbin"
    export PATH="$PATH:/home/linuxbrew/.linuxbrew/Cellar/mongodb-database-tools/100.5.1/bin"
    export PATH=$(brew --prefix openvpn)/sbin:$PATH
fi

# OSX
if [ $OSTYPE = "Darwin" ]
then
    # export PATH="$PATH:/Library/Java/JavaVirtualMachines/jdk-9.0.1.jdk/Contents/Home/bin"
    export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.6/bin"
    export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.7/bin"
    export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.8/bin"
    export PATH="$PATH:/Users/marcpartensky/.pyenv/versions/3.10-dev/bin"
    export PATH="$PATH:/Users/marcpartensky/flutter/bin"
    export PATH="$PATH:/Applications/MAMP/bin"
fi

export TERMINAL=alacritty
export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=nvim
export PAGER=bat
export READER=zathura
export BROWSER=firefox-nightly
export VIDEO=mpv
export IMAGE=sxiv
export COLORTERM=truecolor
export OPENER=xdg-open
export WM=dwm

export LC_ALL=en_US.UTF-8
export LC_MARC=1
export LANG=en_US.UTF-8
export LESS=-Xr
export CLICOLOR=1
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export TEST="This is a test"
export PRODUCTION=false
export DEBUG_VALUE="True"
export DEVELOPMENT=true
export WEBSITE_URL="https://marcpartensky.com"
export WEBSITE_USER="marcpartensky"
export ISEP_ID="mapa60217"
export APPLE_MAIL="marc.partensky@gmail.com"
export GMAIL="marc.partensky@gmail.com"
export FREE_MAIL="marc.partensky@free.fr"
export FACEBOOK_MAIL="marc.partensky@free.fr"
export DOCKERHUB="https://hub.docker.com/u/marcpartensky"
export GITHUB="https://github.com/marcpartensky"
export LINKEDIN="https://linkedin.com/in/marc-partensky"
export FACEBOOK_MAIL_2="marc.partensky@gmail.com"
export FACEBOOK_MAIL_MISCORD="marc.partensky.website@gmail.com"
export MISCORD_DASHBOARD_USERNAME="miscord-of-marc"
export LEEKWARS_USERNAME="Mazex"
export DISCORD_PREFIX="?"
export DISCORD_DEPLOYMENT="DEVELOPMENT"
export YTOPTS="-ciw -x --audio-format 'mp3' --audio-quality 0 -f bestaudio --embed-thumbnail -o '%(title    )s.%(ext)s' --rm-cache-dir"
# export DOCKER_HOST="tcp://marcpartensky.com:2375"
export LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib"
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
export MAC_TEL="fc:19:99:cd:6c:91"
export MARCPARTENSKY_PATH="$HOME/Desktop/Marc\ Partensky"
export BACKUPVPS_LOG="/var/log/backupvps.log"
export BIND_MOUNTS="/srv"
export NOTIFY_MEMO="$HOME/Programs/automation/memo.yml"
export GIT_RECORD="/etc/gitrecord.txt"
export GIT_DISCOVERY_ACROSS_FILESYSTEM="true"
export VAGRANT_DEFAULT_PROVIDER="virtualbox"
export PROGRAMS_DOCKER_PATH="$HOME/git/docker"
# export LS_COLORS="auto"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-13.jdk/Contents/Home"

if command -v go > /dev/null; then
	export PATH="$PATH:$(go env GOPATH)/bin"
	export GOPATH=$(go env GOPATH)
fi
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
export PICKUP_DNS_IP="10.138.68.8"
export PICKUP_C21_IP="10.137.64.217"
export PICKUP_TIA21_IP="10.137.64.218"
export MCFLY_RESULTS_SORT="LAST_RUN"
export MCFLY_RESULTS="30"
export MCFLY_KEY_SCHEME="vim"
export DISCORD_BOT_PORT="7010"
export CHNOTIF="924411208726110278"
export CHCODING="729992302575091718"
export CHGROUPEDES4="707227543220125757"
export CHTESTING="702863598761803806 "
export C21_MONGO_PARAMS="--host srvlh-mdb-b1.paris.pickup.local:45000 --db colis21_events --gzip -u hprod_RO -p Iv8E2k4Ptu7icBlRaq5A --authenticationDatabase admin"
export OCTOPUS_MONGO_PARAMS="--host srvlh-mdb-b2.paris.pickup.local:45014 --db kraken --gzip -u hprod_RO -p Iv8E2k4Ptu7icBlRaq5A --authenticationDatabase admin"
export TIA21_MONGO_PARAMS="--host srvlh-mdb-b1.paris.pickup.local:45004 --db colis21_events --gzip -u hprod_RO -p Iv8E2k4Ptu7icBlRaq5A --authenticationDatabase admin"
export REGEX_URL="^(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]\.[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$"
export LESS="-FRX"
export GP="$PROGRAMS_PATH"
export MONITOR="eDP-1"
export WALLPAPERS_PATH="$HOME/wallpapers"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python
export NNN_OPTS="derH"
