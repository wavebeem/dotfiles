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

# Terminal-aware prompt colors. Run __prompt.fix if they render as garbage.
__prompt.set() {
  local mode="${1:-auto}"
  if [[ "$mode" == auto ]]; then
    if [[ "$COLORTERM" == (24bit|truecolor) ]]; then
      mode=truecolor
    elif [[ "$TERM" == *256color* ]]; then
      mode=256
    else
      mode=ansi
    fi
  fi
  local edge dir bg err
  case "$mode" in
    truecolor)
      bg='%K{#1d2021}'
      edge='%F{#928374}'
      dir='%F{#b8bb26}'
      err='%F{#fb4934}'
      ;;
    256)
      bg='%K{234}'
      edge='%F{245}'
      dir='%F{142}'
      err='%F{167}'
      ;;
    *)
      bg=''
      edge='%F{8}'
      dir='%F{green}'
      err='%F{red}'
      ;;
  esac
  # %(?.A.B) picks A on success, B (red) when the last command failed
  PROMPT="%B${bg}%(?.${dir}.${err})%~ ${edge}%%%f%k%b "
  PROMPT2="%B${bg}${dir}%~ ${edge}?%f%k%b "
}
__prompt.fix() {
  __prompt.set ansi
}
__prompt.set

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
  # zdocs
  "$HOME/.zdocs/bin"
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

__path.print() {
  echo $path | tr ' ' '\n'
}

__source.try() {
  if [[ -f "$1" ]]; then
    source "$1"
  fi
}

__os.is-mac() {
  [[ $(uname) = Darwin ]]
}

__os.is-linux() {
  [[ $(uname) = Linux ]]
}

__os.is-windows() {
  [[ $(uname -r) = *Microsoft ]]
}

# Use tab completion to install missing plugins on the current system
__install.autosuggestions() {
  git clone \
    https://github.com/zsh-users/zsh-autosuggestions \
    ~/.zsh-autosuggestions
}

# Install asdf
__install.asdf() {
  # git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  echo "https://asdf-vm.com/guide/getting-started.html"
  echo "brew install asdf"
  echo "yay asdf-vm"
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
  asdf plugin add deno https://github.com/asdf-community/asdf-deno.git
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

# Update WezTerm nightly (won't auto-update via brew)
__upgrade.wezterm-nightly() {
  if __os.is-mac; then
    brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest
  else
    echo "unsupported platform"
  fi
}

# Automatic command suggestions as I type
__source.try ~/.zsh-autosuggestions/zsh-autosuggestions.zsh

# Convert file to ALAC in MP4 (.m4a) container
__convert.to-alac() {
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

# Load direnv
if which direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# Replace `ls` with `eza`
# https://github.com/eza-community/eza
# https://eza.rocks/
if which eza >/dev/null 2>&1; then
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

# WezTerm shell integration (OSC 7 cwd reporting, semantic zones)
__source.try "${WEZTERM_EXECUTABLE_DIR}/../shell-integration/wezterm.sh"

# Load device specific customizations
__source.try ~/.after.zshrc.zsh
