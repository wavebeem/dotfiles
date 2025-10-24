# shellcheck shell=zsh

# Keep track of lots of history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

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

# Simple prompt that doesn't change size
PROMPT="%B%F{green}zsh:%f%b "
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
# -R preserves ANSI color codes
export PAGER="less -R"

# export PYENV_ROOT="$HOME/.pyenv"

export PNPM_HOME="$HOME/Library/pnpm"

path=(
  # Aseprite
  "$HOME/Applications/aseprite/Aseprite.app/Contents/MacOS"
  # Load user installed commands
  "$HOME/.local/bin"
  "$HOME/dotfiles/bin"
  "$HOME/w/dotfiles/bin"
  "$PNPM_HOME"
  # Homebrew
  "/opt/homebrew/bin"
  "/home/linuxbrew/.linuxbrew/bin"
  # asdf
  "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
  "/opt/homebrew/opt/openjdk/bin"
  # Load Rust Cargo commands
  "$HOME/.cargo/bin"
  # Python stuff
  # "$PYENV_ROOT/bin"
  # "$PYENV_ROOT/shims"
  "$HOME/.poetry/bin"
  # Ruby
  "$HOME/.rvm/bin"
  $path
)

fpath=(
  "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
  $fpath
)

autoload -Uz compinit && compinit

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

# Install asdf
__install.asdf() {
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
}

# Install asdf Node.js plugin
__install.asdf.nodejs() {
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
}

# Install asdf Python plugin
__install.asdf.python() {
  asdf plugin add python https://github.com/asdf-community/asdf-python.git
}

# Install asdf Deno plugin
__install.asdf.deno() {
  asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git
}

# Install pyenv
__install.pyenv() {
   git clone https://github.com/pyenv/pyenv.git ~/.pyenv
}

# Install rvm
__install.rvm() {
  curl -sSL https://get.rvm.io | bash
}

# Install homebrew
__install.homebrew() {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Install eza replacement for ls
__install.eza() {
  brew install eza
}

# Convert file to ALAC in MP4 (.m4a) container
__to.alac() {
  ffmpeg -y -i "$1" -vcodec copy -acodec alac "$2"
}

# Print a blank line between prompts to make it easier to read
precmd() {
  echo
}

# Load homebrew
if which brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

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

# Load direnv
if which direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# Replace `ls` with `exa`
# https://the.exa.website/
if which exa >/dev/null 2>&1; then
  alias ls='exa --group-directories-first'
  alias l='ls'
  alias ll='ls -l'
  alias la='ls -la'
else
  alias l="ls"
  alias ll="l -hl"
  alias la="ll -a"
fi

# Allow pasting commands with "$" from the internet
alias '$'=""

# Time saving shortcuts
alias g="git status"
alias gl="git log"

# Faster directory movement
alias d='pwd'
alias s="cd ..; pwd"
alias ..="s"

# Upgrade pyenv to a shell function
# if command -v pyenv >/dev/null; then
#   eval "$(pyenv init -)"
# fi

# Load asdf
# if [[ -e "$HOME/.asdf/asdf.sh" ]]; then
#   source "$HOME/.asdf/asdf.sh"
#   # append completions to fpath
#   fpath=(${ASDF_DIR}/completions $fpath)
#   # initialize completions with zsh's compinit
#   autoload -Uz compinit && compinit
# fi

# if [[ -e /opt/homebrew/opt/asdf/libexec/asdf.sh ]]; then
#   source /opt/homebrew/opt/asdf/libexec/asdf.sh
# fi

# if [[ -e "$(brew --prefix asdf)/libexec/asdf.sh" ]]; then
#   source "$(brew --prefix asdf)/libexec/asdf.sh"
# fi

# Load rvm if it exists
if [[ -e ~/.rvm/scripts/rvm ]]; then
  source ~/.rvm/scripts/rvm
fi

# Load device specific customizations
source ~/.after.zshrc.zsh
