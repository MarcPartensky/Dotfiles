#!/bin/sh

# Path variables
export PATH="$PATH:$HOME/git/shell"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"
export PATH="$PATH:$PYENV_ROOT/shims"
# export PATH="$PATH:/Library/Java/JavaVirtualMachines/jdk-9.0.1.jdk/Contents/Home/bin"
export PATH="$PATH:/usr/local/opt/php@7.1/bin"
export PATH="$PATH:/usr/local/opt/php@7.2/bin"
export PATH="$PATH:/usr/local/opt/openjdk@11/bin"
export PATH="$PATH:/usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home/bin"
export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.6/bin"
export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.7/bin"
export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.8/bin"
export PATH="$PATH:/Users/marcpartensky/.pyenv/versions/3.10-dev/bin"
export PATH="$PATH:/usr/local/opt/grep/libexec/gnubin"
export PATH="$PATH:/Users/marcpartensky/flutter/bin"
export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
export PATH="$PATH:/opt/local/bin"
export PATH="$PATH:/opt/local/bin:/opt/local/sbin"
export PATH="$PATH:/opt/gradle/gradle-7.0/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/Applications/MAMP/bin"
export PATH="$PATH:/var/lib/snapd/snap/bin"
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
export PATH="$PATH:/home/linuxbrew/.linuxbrew/sbin"
export PATH=$(brew --prefix openvpn)/sbin:$PATH

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
export FACEBOOK_MAIL_2="marc.partensky@gmail.com"
export FACEBOOK_MAIL_MISCORD="marc.partensky.website@gmail.com"
export MISCORD_DASHBOARD_USERNAME="miscord-of-marc"
export LEEKWARS_USERNAME="Mazex"
export DISCORD_PREFIX="?"
export DISCORD_DEPLOYMENT="DEVELOPMENT"
export YTOPTS="-ciw -x --audio-format 'mp3' --audio-quality 0 -f bestaudio --embed-thumbnail -o '%(title    )s.%(ext)s' --rm-cache-dir"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL=bat
export LESS=-Xr
# export DOCKER_HOST="tcp://marcpartensky.com:2375"
export LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
export HISTFILE="$HOME/.local/share/zsh/.zsh_history"
export MAC_TEL="fc:19:99:cd:6c:91"
export MARCPARTENSKY_PATH="$HOME/Desktop/Marc\ Partensky"
export BACKUPVPS_LOG="/var/log/backupvps.log"
export BIND_MOUNTS="/srv"
export NOTIFY_MEMO="$HOME/Programs/automation/memo.yml"
export PROGRAMS_DOCKER_PATH="$HOME/docker"
export GIT_RECORD="/etc/gitrecord.txt"
export GIT_DISCOVERY_ACROSS_FILESYSTEM="true"
export DOTNET_ROOT="/snap/dotnet-sdk/current"
export VAGRANT_DEFAULT_PROVIDER="virtualbox"
# ln -s /snap/dotnet-sdk/current/dotnet /usr/local/bin/dotnet
# export LS_COLORS="auto"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-13.jdk/Contents/Home"

if command -v go > /dev/null; then
	export PATH="$PATH:$(go env GOPATH)/bin"
	export GOPATH=$(go env GOPATH)
fi
