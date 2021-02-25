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
  start="$__bench_last_time" ruby -e 'p(Time.now.to_f - ENV["start"].to_f)'
}

# lazy load nvm since it takes half a second to load on my work mac
export NVM_DIR="$HOME/.nvm"
__lazy_nvm() {
  # Remove zsh function shims
  cmd="$1"
  shift
  unfunction nvm npm npx node
  # Load bash completion system
  autoload -Uz bashcompinit
  bashcompinit
  # Load nvm
  source "$NVM_DIR/nvm.sh"
  source "$NVM_DIR/bash_completion"
  # Run the originally intended command
  "$cmd" "$@"
}
nvm() { __lazy_nvm nvm "$@"; }
npm() { __lazy_nvm npm "$@"; }
npx() { __lazy_nvm npx "$@"; }
node() { __lazy_nvm node "$@"; }

# Load device specific customizations
source ~/.after.zshenv.zsh
