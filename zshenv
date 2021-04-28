# Python virtualenv assumes you want your shell prompt mangled without this
export VIRTUAL_ENV_DISABLE_PROMPT="true"

# English and Unicode, please
export LANG="en_US.UTF-8"

# Make folders bold using ls on macOS
export LSCOLORS="ExfxcxdxBxegedabagacad"

# Edit using VSCode for git command line stuff
export EDITOR="code --wait"
export GIT_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

# less is better than more
export PAGER="less"

path=(
  # Load user installed commands
  "$HOME/.local/bin"
  # Load Rust Cargo commands
  "$HOME/.cargo/bin"
  # Load "restricted" commands for use with sudo
  "/sbin"
  "/usr/sbin"
  # Load commands from Homebrew or other package managers
  "/usr/local/bin"
  "/usr/local/sbin"
  $path
)

__bench.start() {
  __bench_last_time=$(ruby -e 'p Time.now.to_f')
}

__bench.end() {
  start="$__bench_last_time" ruby -e 'p Time.now.to_f - ENV["start"].to_f'
}

# Load nvm if it exists
export NVM_DIR="$HOME/.nvm"
if [[ -e "$NVM_DIR" ]]; then
  autoload -Uz bashcompinit
  bashcompinit
  source "$NVM_DIR/nvm.sh"
  source "$NVM_DIR/bash_completion"
fi

# Load device specific customizations
source ~/.after.zshenv.zsh
