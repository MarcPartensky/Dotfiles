#!/usr/bin/env zsh

export DOTFILES_PATH=${0:a:h}
export PROGRAMS_PATH=$(readlink -f "$DOTFILES_PATH/..")
export GIT_PROJECTS_PATH=/Volumes/$/git-project
export FPATH=$HOME/usr/share/zsh/*/functions:$FPATH
# $(readlink -f "$(which $0)/..")

# vim mode inside the terminal
set -o vi
set editing-mode vi
set keymap vi
set shiftwidth=4
set clipboard=unnamedplus

zstyle -d ':completion:*' list-prompt
zstyle -d ':completion:*' select-prompt

# zstyle ':completion:*' list-prompt   ''
# zstyle ':completion:*' select-prompt ''

# zstyle ':completion:*' list-prompt   ''
# zstyle ':completion:*' select-prompt ''

# zstyle ':completion:*' commands base

#\\\_ COMPLETIONS _///#
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' menu yes select
zstyle ':completion:*' extra-verbose no
zstyle ':completion:*' max-matches-width 0
zstyle ':completion:*' list-suffixes false
zstyle ':completion:*' accept-exact true
zstyle ':completion:*' menu select=0
# zstyle ':completion:*:' group-order \
#   expansions history-words options \
#   aliases functions builtins reserved-words \
#   executables local-directories directories suffix-aliases
zstyle ':completion:*:' group-order \
	expansions history-words options list=20 \
	aliases \
	local-directories directories

zstyle ':autocomplete:*' config on
zstyle ':autocomplete:*' min-input 2
# zstyle ':autocomplete:*' default-context ''
# zstyle ':autocomplete:*' default-context \
# 	expansions history-words options \
#   aliases functions builtins reserved-words \
#   executables local-directories directories suffix-aliases
zstyle ':autocomplete:*' default-context \
	expansions history-words options \
	local-directories directories
	# zstyle ':autocomplete:*' default-context history-incremental-search-backward
	zstyle ':autocomplete:*' ignored-input ''
	zstyle ':autocomplete:tab:*' fzf-completion yes
	zstyle ':autocomplete:tab:*' insert-unambiguous yes
	zstyle ':autocomplete:tab:*' widget-style menu-complete
	zstyle ':autocomplete:tab:*' widget-style menu-select
	# zstyle ':autocomplete:tab:*' widget-style complete-word
	# zstyle ':autocomplete:*' add-space executables aliases functions builtins reserved-words commands


# autoload -Uz compdef && compdef
# autoload -Uz compinit && compinit
# autoload -Uz bashcompinit && bashcompinit

# The following lines were added by compinstall
# zstyle :compinstall filename '/Users/marcpartensky/.zshrc'

# pip zsh completion start

# Antigen
ANTIGEN_CACHE=false
source ${0:a:h}/antigen.zsh
# source $DOTFILES_PATH/antigen.zsh
#
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


if [[ ! -d ~/.antigen/bundles/marlonrichert/zsh-autocomplete ]]
then
	git clone https://github.com/marlonrichert/zsh-autocomplete.git ~/.antigen/bundles/marlonrichert/zsh-autocomplete
fi

# autocompletion
# source ~/.antigen/bundles/marlonrichert/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.antigen/bundles/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.antigen/bundles/zsh-users/zsh-completions/zsh-completions.plugin.zsh
source ~/.antigen/bundles/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh


# bindkey '\t' autosuggest-accept
# bindkey $key[Space] list-expand
# # bindkey -M menuselect $key[Tab] .accept-line
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char


# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="eastwood"

# Deprecated
# export GREP_OPTIONS="--color=always"
# export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"

# "bat" as manpager
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	export DISTRIB=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
	if [ $DISTRIB == "Ubuntu" ]; then
		export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
	else
		export MANPAGER="sh -c 'col -bx | bat -l man -p'"
	fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi
# "nvim" as manpager
# export MANPAGER="nvim -c 'set ft=man' -"

# source ${0:a:h}/setup.sh
source ${0:a:h}/os.sh
source ${0:a:h}/exports.sh
source ${0:a:h}/aliases.sh
source ${0:a:h}/functions.sh
source ${0:a:h}/symlinks.sh
source ${0:a:h}/.zshenv
source ${0:a:h}/.p10k.zsh
source ${0:a:h}/installs/pyenv.sh

[[ -f ${0:a:h}/secrets.sh ]] && source ${0:a:h}/secrets.sh
[[ -f ~/.vimrc ]]	|| touch ~/.vimrc
[[ -f ~/.zshrc ]] || echo "source ${0:a:h}/main.sh" > ~/.zshrc
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

if command -v mcfly >& /dev/null; then
	mkdir -p $HOME/.local/share/zsh
	touch $HISTFILE
	eval "$(mcfly init zsh)"
fi

mkdir -p ~/.local/bin
if [[ ! :$PATH: == *:"$HOME/.local/bin":* ]] ; then
	echo "Adding $HOME/.local/bin to \$PATH"
	export $PATH="$PATH:$HOME/.local/bin"
fi

ln -s ${0:a:h}/update.sh $HOME/.local/bin/update

# Get the defaults that most users want.
# source $VIMRUNTIME/defaults.vim

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
