#!/usr/bin/env zsh

export DOTFILES_PATH=${0:a:h}
export PROGRAMS_PATH=$(readlink -f "$DOTFILES_PATH/..")
export FPATH=$HOME/usr/share/zsh/*/functions:$FPATH
# $(readlink -f "$(which $0)/..")

# vim mode inside the terminal
set -o vi
set editing-mode vi
set keymap vi
set shiftwidth=4
set clipboard=unnamedplus


#\\\_ COMPLETIONS _///#

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' menu yes select
zstyle ':completion:*' extra-verbose yes

zstyle ':autocomplete:*' config on
zstyle ':autocomplete:*' min-input 3
zstyle ':autocomplete:tab:*' fzf-completion yes
zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-complete
zstyle ':autocomplete:tab:*' widget-style menu-select

# autoload -Uz compdef && compdef
autoload -Uz compinit && compinit
# autoload -Uz bashcompinit && bashcompinit

# The following lines were added by compinstall
# zstyle :compinstall filename '/Users/marcpartensky/.zshrc'

# pip zsh completion start
# function _pip_completion {
#   local words cword
#   read -Ac words
#   read -cn cword
#   reply=( $( COMP_WORDS="$words[*]" \
#              COMP_CWORD=$(( cword-1 )) \
#              PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
# }
# compctl -K _pip_completion pip3

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
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
#antigen bundle soimort/translate-shell
antigen apply

bindkey '\t' autosuggest-accept

if [[ ! -d ~/.antigen/bundles/marlonrichert/zsh-autocomplete ]]
then
	git clone https://github.com/marlonrichert/zsh-autocomplete.git ~/.antigen/bundles/marlonrichert/zsh-autocomplete
fi

# autocompletion
source ~/.antigen/bundles/marlonrichert/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.antigen/bundles/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.antigen/bundles/zsh-users/zsh-completions/zsh-completions.plugin.zsh
source ~/.antigen/bundles/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="eastwood"

# Deprecated
# export GREP_OPTIONS="--color=always"
# export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"

# "bat" as manpager
# if [[ uname == "Darw" ]]
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# "nvim" as manpager
# export MANPAGER="nvim -c 'set ft=man' -"


source ${0:a:h}/setup.sh
source ${0:a:h}/exports.sh
source ${0:a:h}/aliases.sh
source ${0:a:h}/functions.sh

ln -snf ${0:a:h}/.gitconfig ~
ln -snf ${0:a:h}/.zshenv ~
ln -snf ${0:a:h}/.p10k.zsh ~
source ${0:a:h}/.zshenv
source ${0:a:h}/.p10k.zsh


if [[ ! -f ~/.vimrc ]]
then
	touch ~/.vimrc
fi

if [[ ! -f ~/.zshrc ]]
then
	echo "source ${0:a:h}/main.sh" > ~/.zshrc
fi

if [[ ! -d ~/.pyenv ]]
then
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	cd ~/.pyenv && src/configure && make -C src && cd -
fi

if [[ ! -d $(pyenv root)/plugins/pyenv-virtualenv ]]
then
	git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
fi

if [[ -f "$HOME/.cargo/env" ]]
then
	source "$HOME/.cargo/env"
fi

# pyenv setup
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

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
