#!/usr/bin/env zsh

export DOTFILES_PATH=${0:a:h}
export PROGRAMS_PATH=$(readlink -f "$DOTFILES_PATH/..")
export JUNIOR_PATH=~/junior
export GIT_PROJECTS_PATH=/Volumes/$/git-project
export FPATH=$HOME/usr/share/zsh/*/functions:$FPATH
# $(readlink -f "$(which $0)/..")

# vim mode inside the terminal
set -o vi
set editing-mode vi
set keymap vi
set shiftwidth=4
set clipboard=unnamedplus
setxkbmap -option caps:escape

export SHELL_NAME=$(echo $SHELL | rev | cut -d/ -f1 | rev)

# Cd by name of folder
if [ "$SHELL_NAME" = "zsh" ]; then
    setopt autocd
elif [ "$SHELL_NAME" = "bash" ]; then
    shopt -s autocd
fi

homebrew_command_not_found_handle() {
    local cmd="$1"
    # The code below is based off this Linux Journal article:
    #   http://www.linuxjournal.com/content/bash-command-not-found
    # do not run when inside Midnight Commander or within a Pipe, except if CI
    if test -z "$CONTINUOUS_INTEGRATION" && test -n "$MC_SID" -o ! -t 1 ; then
        [ -n "$BASH_VERSION" ] && \
            TEXTDOMAIN=command-not-found echo $"$cmd: command not found"
        # Zsh versions 5.3 and above don't print this for us.
        [ -n "$ZSH_VERSION" ] && [[ "$ZSH_VERSION" > "5.2" ]] && \
            echo "zsh: command not found: $cmd" >&2
        return 127
    fi
    local txt="$(brew which-formula --explain $cmd 2>/dev/null)"
    if [ -z "$txt" ]; then
        [ -n "$BASH_VERSION" ] && \
            TEXTDOMAIN=command-not-found echo $"$cmd: command not found"
        # Zsh versions 5.3 and above don't print this for us.
        [ -n "$ZSH_VERSION" ] && [[ "$ZSH_VERSION" > "5.2" ]] && \
            echo "zsh: command not found: $cmd" >&2
    else
        echo "$txt"
    fi
    return 127
}

command_not_found_handler() {
    if [[ -o interactive && -w $1 ]]; then
        $EDITOR $1
    elif command -v brew &>/dev/null; then
        homebrew_command_not_found_handle $*
    elif command -v fuck &>/dev/null; then
        fuck
    else
        echo $@ not found
        return $?
    fi
}


# autocompletion
if [ ! -d ~/.antigen/bundles/marlonrichert/zsh-autocomplete ]; then
	git clone https://github.com/marlonrichert/zsh-autocomplete.git ~/.antigen/bundles/marlonrichert/zsh-autocomplete
fi
source ~/.antigen/bundles/zsh-users/zsh-completions/zsh-completions.plugin.zsh
source ~/.antigen/bundles/marlonrichert/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.antigen/bundles/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.antigen/bundles/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh


# autoload -Uz compdef && compdef
# autoload -Uz compinit && compinit
# autoload -Uz bashcompinit && bashcompinit


# Antigen
ANTIGEN_CACHE=false
source ${0:a:h}/antigen.zsh

antigen theme romkatv/powerlevel10k
antigen theme eastwood
antigen theme kardan
antigen theme nicoulaj
# antigen theme candy
# antigen theme robbyrussell
# antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle agkozak/zsh-z
#antigen bundle soimort/translate-shell
antigen apply


## zsh completions
zstyle -d ':completion:*' list-prompt
zstyle -d ':completion:*' select-prompt
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' menu yes select
zstyle ':completion:*' extra-verbose yes
zstyle ':completion:*' max-matches-width 0
zstyle ':completion:*' list-suffixes false
zstyle ':completion:*' accept-exact true
zstyle ':completion:*' menu select=0
# zstyle ':completion:*' commands base
# zstyle ':completion:*:' group-order \
zstyle ':completion:*:' group-order \
	expansions history-words options list=20 \
	aliases \
	local-directories directories
#   expansions history-words options \
#   aliases functions builtins reserved-words \
#   executables local-directories directories suffix-aliases

## zsh-autocomplete
zstyle ':autocomplete:*' config on
zstyle ':autocomplete:*' min-input 3
zstyle ':autocomplete:*' list-lines 16
# zstyle ':autocomplete:*' default-context ''
# zstyle ':autocomplete:*' default-context \
# 	expansions history-words options \
#   aliases functions builtins reserved-words \
#   executables local-directories directories suffix-aliases
zstyle ':autocomplete:*' default-context \
	expansions history-words options \
	local-directories directories
zstyle ':autocomplete:*' add-space \
    executables aliases functions builtins reserved-words commands
# zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':autocomplete:*' ignored-input ''
zstyle ':autocomplete:tab:*' fzf-completion yes
zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-complete
zstyle ':autocomplete:tab:*' widget-style menu-select
# zstyle ':autocomplete:tab:*' widget-style complete-word
# zstyle ':autocomplete:*' add-space executables aliases functions builtins reserved-words commands


## zsh menu selection
# bindkey '\t' autosuggest-accept
# bindkey $key[Space] list-expand
# # bindkey -M menuselect $key[Tab] .accept-line
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char # unecessary


# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="eastwood"

# Deprecated
# export GREP_OPTIONS="--color=always"
# export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"

# "bat" as manpager
if [[ "$OSTYPE" = "linux-gnu"* ]]; then
	export DISTRIB=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
	export DISTRIB=$(echo $DISTRIB | sed -r 's/"//g' | sed -r 's/Linux//g' | sed -r 's/ //g')
	if [ "$DISTRIB" = "Ubuntu" ]; then
		export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
	elif [ "$DISTRIB" = "Fedora" ]; then
        # export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
	else
		export MANPAGER="sh -c 'col -bx | bat -l man -p'"
	fi
elif [ "$OSTYPE" = "darwin" ]; then
	export DISTRIB="Darwin"
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi
# "nvim" as manpager
# export MANPAGER="nvim -c 'set ft=man' -"

# Find distribution
if [ "$DISTRIB" = "Debian" ]; then
    export PKM="apt"
elif [ "$DISTRIB" = "Ubuntu" ]; then
    export PKM="apt"
elif [ "$DISTRIB" = "Alpine" ]; then
    export PKM="apk"
elif [ "$DISTRIB" = "Termux" ]; then
    export PKM="pkg"
elif [ "$DISTRIB" = "Centos" ]; then
    export PKM="dnf"
elif [ "$DISTRIB" = "Fedora" ]; then
    if command -v dnf > /dev/null; then
        export PKM="dnf"
    else
        export PKM="dnf"
    fi
elif [ "$DISTRIB" = "OpenSUSE" ]; then
    export PKM="zipper"
elif [ "$DISTRIB" = "Solus" ]; then
    export PKM="eopkg"
elif [ "$DISTRIB" = "Arch" ]; then
    if command -v paru > /dev/null; then
        export PKM="paru"
    elif command -v yay > /dev/null; then
        export PKM="yay"
    else
        export PKM="pacman"
    fi
elif [ "$DISTRIB" = "Darwin" ]; then
    export PKM="brew"
else [ "$OS" = "Linux" ]
    export PKM="snap"
    # or homebrew?
    export PKM="brew"
fi

# ssl certificates for dotnet
if [ "$DISTRIB" = "Fedora" ]; then
	export SSL_CERT_FILE="/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem"
	export SSL_CERT_DIR=/dev/null
elif [ "$DISTRIB" = "OpenSUSE" ]; then
	export SSL_CERT_FILE="/etc/ssl/ca-bundle.pem"
	export SSL_CERT_DIR=/dev/null
elif [ "$DISTRIB" = "Solus" ]; then
	export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
	export SSL_CERT_DIR=/dev/null
fi

# source ${0:a:h}/setup.sh
source ${0:a:h}/exports.sh
source ${0:a:h}/aliases.sh
source ${0:a:h}/functions.sh
source ${0:a:h}/symlinks.sh
source ${0:a:h}/zsh/.zshenv
source ${0:a:h}/zsh/.p10k.zsh

[ -f ${0:a:h}/secrets.sh ] && source ${0:a:h}/secrets.sh
# [ -f ~/.zshrc ] || echo "git -C $DOTFILES_PATH pull" >> ~/.zshrc
# [ -f ~/.zshrc ] || echo "source ${0:a:h}/main.sh" >> ~/.zshrc
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# export NVM_DIR="$HOME/.nvm"
# [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && . "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# History
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTFILE=$HOME/.zsh_history
export HISTTIMEFORMAT="[%F %T] "
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
export SAVEHIST=1000000
setopt appendhistory
setopt EXTENDED_HISTORY
export HIST_STAMPS="yyyy-mm-dd"
# export HISTTIMEFORMAT="%F %T "

if command -v mcfly >& /dev/null; then
	mkdir -p $HOME/.local/share/zsh
	touch $HISTFILE
    export MCFLY_KEY_SCHEME=vim
	eval "$(mcfly init zsh)"
fi


mkdir -p ~/.local/share
mkdir -p ~/.local/bin
if [[ ! :$PATH: == *:"$HOME/.local/bin":* ]] ; then
	echo "Adding $HOME/.local/bin to \$PATH"
	export $PATH="$PATH:$HOME/.local/bin"
fi

# Default editor
if command -v nvim >& /dev/null; then
	export EDITOR="nvim"
elif command -v vim >& /dev/null; then
	export EDITOR="vim"
elif command -v vi >& /dev/null; then
	export EDITOR="vi"
elif command -v nano >& /dev/null; then
	export EDITOR="nano"
elif command -v code >& /dev/null; then
	export EDITOR="code"
elif command -v subl >& /dev/null; then
	export EDITOR="subl"
else
	echo "No editor found."
fi

if ! command -v open >& /dev/null; then
    alias open="xdg-open"
fi

if command -v thefuck >& /dev/null; then
    eval $(thefuck --alias)
fi

if [ "$DESKTOP_SESSION" = "i3" ]; then
    xmodmap -e "clear lock" #disable caps lock switch
    xmodmap -e "keysym Caps_Lock = Escape" #set caps_lock as escape
fi


# if has("vms"); then
#  set nobackup
# do not keep a backup file, use versions instead
# else
#  set backup
# keep a backup file (restore to previous version)
#  if has('persistent_undo'); then
#    set undofile	# keep an undo file (undo changes after closing)
#  fi
# fi

# if [&t_Co > 2 -o has("gui_running")]; then
# Switch on highlighting the last used search pattern.
#  set hlsearch
# fi

# Put these in an autocmd group, so that we can delete them easily.
# augroup vimrcEx
#  au!
# For all text files set 'textwidth' to 78 characters.
#  autocmd FileType text setlocal textwidth=78
# augroup END

# Add optional packages.
# The matchit plugin makes the % command work better, but it is not backwards
# compatible.
# The ! means the package won't be loaded right away but when plugins are
# loaded during initialization.
# if [has('syntax') -a has('eval')]; then
#  packadd! matchit
# fi

# prompt_context() {
#   if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
#     prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
#   fi
# }
