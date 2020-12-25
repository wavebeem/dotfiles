HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt EXTENDED_GLOB
setopt NO_MATCH
# zsh 5.1 doesn't have this option...
setopt GLOB_STAR_SHORT 2>/dev/null
setopt INTERACTIVE_COMMENTS
bindkey -e
zstyle :compinstall filename "$HOME/.zshrc"

PROMPT="%B%F{cyan}zsh:%f%b "
PROMPT2="$PROMPT"

__source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh
__source ~/.travis/travis.sh
# __source ~/.nvm/nvm.sh
__source ~/.asdf/asdf.sh
__source ~/google-cloud-sdk/path.zsh.inc
__source ~/google-cloud-sdk/completion.zsh.inc

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

__source ~/.after.zshrc.zsh

fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit
compinit

__install.autosuggestions() {
  git clone --depth 1 \
    https://github.com/zsh-users/zsh-autosuggestions \
    ~/.zsh-autosuggestions
}

__install.asdf() {
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
}

__install.asdf.nodejs() {
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
}

precmd() {
  echo
}

if [[ $(uname -r) = *Microsoft ]]; then
  alias o='explorer.exe'
else
  alias o='open'
fi

# Allow pasting commands with "$" from the internet
alias '$'=""

if [[ $(uname) = Darwin ]]; then
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi

alias l="ls"
alias ll="ls -hl"
alias la="ll -a"

alias t="tmux"
alias T="tmux attach -d"

alias ..="cd .."

if [[ $__already_welcome != "yes" ]]; then
  if [[ -f ~/.welcome ]]; then
    cat ~/.welcome
  else
    uptime
  fi
fi
__already_welcome="yes"
