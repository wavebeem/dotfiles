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

# asdf nodejs defaults are not great
export NODEJS_CHECK_SIGNATURES=no
export ASDF_SKIP_RESHIM=1

# Load plugins that might exist on this device
__source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh
__source ~/.asdf/asdf.sh

# Change the zsh-autosuggestion colors (must be set after loading the plugin...)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

# Load autocomplete data for asdf
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit
compinit

# Use tab completion to install missing plugins on the current system
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

# Print a blank line between prompts to make it easier to read
precmd() {
  echo
}

# zsh (and bash) have a strange feature where the shell exits with the status
# code of the last command you ran. This means that if you Control-C to SIGINT a
# command, then exit the shell, your terminal emulator might warn you about the
# command (zsh) failing. This fixes the issue by always exiting interactive zsh
# sessions with status code 0.
zshexit() {
  exit 0
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
