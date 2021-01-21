# Keep track of lots of history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY

# Allow use of ** globbing
setopt EXTENDED_GLOB

# Fail with an error if glob fails to match any files
setopt NO_MATCH

# Allow writing **.x instead of **/*.x (requires zsh 5.1+)
setopt GLOB_STAR_SHORT 2>/dev/null

# Allow writing comments in interactive mode (why not?)
setopt INTERACTIVE_COMMENTS

# Simple prompt that doesn't change size
PROMPT="%B%F{cyan}zsh:%f%b "
PROMPT2="$PROMPT"

# Automatic command suggestions as I type
__source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh

# nvm loads kinda slowly, so let's wait to load it until we actually use node
export NVM_DIR="$HOME/.nvm"
__lazy_nvm() {
  cmd="$1"
  shift
  unfunction nvm npm npx node
  __source "$NVM_DIR/nvm.sh"
  "$cmd" "$@"
}
nvm() { __lazy_nvm nvm "$@"; }
npm() { __lazy_nvm npm "$@"; }
npx() { __lazy_nvm npx "$@"; }
node() { __lazy_nvm node "$@"; }

# Change the zsh-autosuggestion colors (must be set after loading the plugin...)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

# Some kind of autocomplete system? Not sure why I have to do this
autoload -Uz compinit
compinit

# Use tab completion to install missing plugins on the current system
__install.autosuggestions() {
  git clone \
    https://github.com/zsh-users/zsh-autosuggestions \
    ~/.zsh-autosuggestions
}

# Install nvm
__install.nvm() {
  git clone https://github.com/nvm-sh/nvm.git ~/.nvm
}

# Print a blank line between prompts to make it easier to read
precmd() {
  echo
}

# Easy open files
if [[ $(uname -r) = *Microsoft ]]; then
  alias o='explorer.exe'
else
  alias o='open'
fi

# Use color with ls
if [[ $(uname) = Darwin ]]; then
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi

# Allow pasting commands with "$" from the internet
alias '$'=""

# Time saving shortcuts
alias g="git status"
alias g="git log"
alias l="ls"
alias ll="ls -hl"
alias la="ll -a"

# Weird tmux shortcuts I like
alias t="tmux"
alias T="tmux attach -d"

# Faster directory movement
alias d='pwd'
alias s="cd ..; pwd"
alias ..="s"

# Show a cute little graphic in the terminal
if [[ ! $__already_welcome && -f ~/.welcome ]]; then
  cat ~/.welcome
fi
export __already_welcome="true"

# Load device specific customizations
__source ~/.after.zshrc.zsh
