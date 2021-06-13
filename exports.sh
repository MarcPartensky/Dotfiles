#!/bin/sh

# Path variables
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# export PATH="$PATH:/Library/Java/JavaVirtualMachines/jdk-9.0.1.jdk/Contents/Home/bin"
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
export PATH="/usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="/Users/marcpartensky/flutter/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/opt/local/bin:$PATH"
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="$PATH:/opt/gradle/gradle-7.0/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
# export PATH=$(brew --prefix openvpn)/sbin:$PATH

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
export HISTFILE=/tmp/.zsh_history
export MAC_TEL="fc:19:99:cd:6c:91"
# export LS_COLORS="auto"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-13.jdk/Contents/Home"
