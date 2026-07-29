# shellcheck shell=zsh

### Options ############################################################

# Keep track of lots of history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Use Emacs-style keyboard shortcuts (otherwise zsh will detect EDITOR=vim)
bindkey -e

# Allow writing comments in interactive mode (why not?)
setopt INTERACTIVE_COMMENTS

# Allow command substitution inside PROMPT
setopt PROMPT_SUBST

### Helpers ############################################################

# $OSTYPE avoids forking uname (saving 60 +ms)
__os.is-mac() {
  [[ $OSTYPE == darwin* ]]
}

__os.is-linux() {
  [[ $OSTYPE == linux* ]]
}

# WSL is linux-gnu to zsh, so sniff the kernel version instead.
# $(< file) is special-cased by zsh and doesn't fork.
__os.is-windows() {
  [[ $OSTYPE == linux* && -r /proc/version && "$(< /proc/version)" == *[Mm]icrosoft* ]]
}

# Check whether a command is installed
__command.exists() {
  which "$1" >/dev/null 2>&1
}

__source.try() {
  if [[ -f "$1" ]]; then
    source "$1"
  fi
}

### Prompt #############################################################

# Highlight the last dir in the cwd
# ${(%):-%~} expands %~ outside the prompt
__prompt.path-update() {
  local cwd=${(%):-%~}
  cwd=${cwd//\%/%%} # escape % so prompt expansion shows it literally
  if [[ $cwd == */* ]]; then
    __prompt_path="%F{8}${cwd%/*}/%F{cyan}${cwd##*/}"
  else
    __prompt_path="%F{cyan}${cwd}" # no separator, e.g. ~
  fi
}

PROMPT='%B${__prompt_path}%f%b
%B%F{8}%%%f%b '
PROMPT2='%B%F{cyan}%~ %F{8}?%f%b '

# zle_highlight=(default:fg=magenta,bold)
zle_highlight=(default:bold)

# Print a blank line between prompts to make it easier to read
precmd() {
  echo
  __prompt.path-update
}

### Environment ########################################################

# Python virtualenv assumes you want your shell prompt mangled without this
export VIRTUAL_ENV_DISABLE_PROMPT="true"

# English and Unicode, please
export LANG="en_US.UTF-8"

# Make folders bold using ls on macOS
export LSCOLORS="ExfxcxdxBxegedabagacad"

# less is better than more
# -R preserves ANSI color codes
export PAGER="less -R"

# Still easier to use vim for quick edits even though I prefer VS Code
if __command.exists nvim; then
  export EDITOR="nvim"
  alias vim='nvim'
else
  export EDITOR="vim"
fi
export GIT_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

### Path ###############################################################

path=(
  # Aseprite
  "$HOME/Applications/aseprite/Aseprite.app/Contents/MacOS"
  # Load user installed commands
  "$HOME/.local/bin"
  "$HOME/dotfiles/bin"
  "$HOME/w/dotfiles/bin"
  # Homebrew
  "/opt/homebrew/bin"
  "/home/linuxbrew/.linuxbrew/bin"
  # zdocs
  "$HOME/.zdocs/bin"
  "/opt/homebrew/opt/openjdk/bin"
  # Load Rust Cargo commands
  "$HOME/.cargo/bin"
  "$HOME/.poetry/bin"
  $path
)

if __os.is-mac; then
  export PNPM_HOME="$HOME/Library/pnpm"
  path=("$PNPM_HOME" $path)
fi

fpath=(
  $fpath
)

### Deferred loads #####################################################

# Defer work until after the first prompt
__source.try ~/.zsh-defer/zsh-defer.plugin.zsh
__defer() {
  if __command.exists zsh-defer; then
    zsh-defer "$@"
  else
    "$@"
  fi
}

# Automatic command suggestions as I type
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
__defer __source.try ~/.zsh-autosuggestions/zsh-autosuggestions.zsh

# Load homebrew
__load.brew() {
  if __command.exists brew; then
    eval "$(brew shellenv)"
  fi
}
__defer __load.brew

# Load direnv
__load.direnv() {
  if __command.exists direnv; then
    eval "$(direnv hook zsh)"
  fi
}
__defer __load.direnv

# Load mise (asdf replacement)
__load.mise() {
  if __command.exists mise; then
    eval "$(mise activate zsh)"
  fi
}
__defer __load.mise

# Deferred after brew so its completions are picked up
__load.compinit() {
  autoload -Uz compinit
  compinit
}
__defer __load.compinit

# iTerm2 shell integration; install with __install.iterm2-shell-integration
__defer __source.try ~/.iterm2_shell_integration.zsh

### Aliases ############################################################

# Easy open files
if __os.is-windows; then
  alias o='explorer.exe'
else
  alias o='open'
fi

# Use color with ls
if __os.is-mac; then
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi

# Replace `ls` with `eza`
# https://github.com/eza-community/eza
# https://eza.rocks/
if __command.exists eza; then
  alias ls='eza --group-directories-first'
  alias l='ls'
  alias ll='ls -l'
  alias la='ls -la'
else
  alias l="ls"
  alias ll="l -hl"
  alias la="ll -a"
fi

# Lets you paste shell commands from the internet that start with "$" verbatim
alias '$'=""

# Time saving shortcuts
alias g="git status"
alias gl="git log"

# Faster directory movement
alias d='pwd'
alias s="cd ..; pwd"
alias ..="s"

### Installers #########################################################

# Use tab completion to install missing plugins on the current system
__install.autosuggestions() {
  git clone \
    https://github.com/zsh-users/zsh-autosuggestions \
    ~/.zsh-autosuggestions
}

# Install zsh-defer
__install.zsh-defer() {
  git clone https://github.com/romkatv/zsh-defer ~/.zsh-defer
}

# Install mise
__install.mise() {
  echo "https://mise.jdx.dev/getting-started.html"
  echo "brew install mise"
}

# Install homebrew
__install.homebrew() {
  bash <(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
}

# Install eza replacement for ls
__install.eza() {
  brew install eza
}

# Install iTerm2 shell integration (command marks, cmd+click downloads,
# jump-between-prompts, etc.)
__install.iterm2-shell-integration() {
  curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
}


### Misc functions #####################################################

__path.print() {
  echo $path | tr ' ' '\n'
}

# Benchmark interactive shell startup
# no_zle so the shell reads "exit" from stdin instead of the tty
__benchmark.zsh-startup() {
  local i
  for i in {1..5}; do
    time zsh -i -o no_zle <<< exit
  done
}

# Convert file to ALAC in MP4 (.m4a) container
__convert.to-alac() {
  ffmpeg -y -i "$1" -vcodec copy -acodec alac "$2"
}

### Device-specific ####################################################

# Load device specific customizations
__source.try ~/.after.zshrc.zsh
