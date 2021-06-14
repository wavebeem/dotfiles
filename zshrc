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

# Enable both zsh and bash completion systems (nvm only support bash)
autoload -Uz compinit
compinit

# Simple prompt that doesn't change size
PROMPT="%B%F{cyan}zsh:%f%b "
PROMPT2="$PROMPT"

# Automatic command suggestions as I type
source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

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

# Install nodenv
__install.nodenv() {
  brew install nodenv node-build nodenv/nodenv/nodenv-package-rehash
  nodenv package-hooks install --all
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
alias gl="git log"
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

# Load device specific customizations
source ~/.after.zshrc.zsh
