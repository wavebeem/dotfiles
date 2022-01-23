# shellcheck shell=zsh

# Keep track of lots of history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY

# Use Emacs-style keyboard shortcuts (bash default)
bindkey -e

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

# Python virtualenv assumes you want your shell prompt mangled without this
export VIRTUAL_ENV_DISABLE_PROMPT="true"

# English and Unicode, please
export LANG="en_US.UTF-8"

# Make folders bold using ls on macOS
export LSCOLORS="ExfxcxdxBxegedabagacad"

# Still easier to use vim for quick edits even though I prefer Code
export EDITOR="vim"
export GIT_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

# less is better than more
export PAGER="less"

export PYENV_ROOT="$HOME/.pyenv"

path=(
  # Load user installed commands
  "$HOME/.local/bin"
  # Load Rust Cargo commands
  "$HOME/.cargo/bin"
  # Python stuff
  "$PYENV_ROOT/bin"
  "$PYENV_ROOT/shims"
  "$HOME/.poetry/bin"
  $path
)

__path() {
  echo $path | tr ' ' '\n'
}

__bench.start() {
  __bench_last_time=$(ruby -e 'p Time.now.to_f')
}

__bench.end() {
  start="$__bench_last_time" ruby -e 'p Time.now.to_f - ENV["start"].to_f'
}

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

# Install pyenv
__install.pyenv() {
   git clone https://github.com/pyenv/pyenv.git ~/.pyenv
}

# Install homebrew
__install.homebrew() {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

# Upgrade pyenv to a shell function
if command -v pyenv >/dev/null; then
  eval "$(pyenv init -)"
fi

# Load nodenv if it exists
if which nodenv >/dev/null; then
  eval "$(nodenv init - --no-rehash)"
fi

# Load device specific customizations
source ~/.after.zshrc.zsh
