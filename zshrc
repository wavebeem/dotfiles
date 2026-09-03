# shellcheck shell=zsh

### Options ############################################################

# Keep track of lots of history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Prefix a command with a space to keep it out of history (secrets, etc.)
setopt HIST_IGNORE_SPACE

# Use Emacs-style keyboard shortcuts (otherwise zsh will detect EDITOR=vim)
bindkey -e

# Allow writing comments in interactive mode (why not?)
setopt INTERACTIVE_COMMENTS

# Allow command substitution inside PROMPT
setopt PROMPT_SUBST

### Helpers ############################################################

# $OSTYPE avoids forking uname (saving 60 +ms)
_os.is-mac() {
  [[ $OSTYPE == darwin* ]]
}

_os.is-linux() {
  [[ $OSTYPE == linux* ]]
}

# WSL is linux-gnu to zsh, so sniff the kernel version instead. $(< file) is
# special-cased by zsh and doesn't fork.
_os.is-windows() {
  [[ $OSTYPE == linux* && -r /proc/version && "$(< /proc/version)" == *[Mm]icrosoft* ]]
}

# Check whether a command is installed
_command.exists() {
  which "$1" >/dev/null 2>&1
}

_source.try() {
  if [[ -f "$1" ]]; then
    source "$1"
  fi
}

### Prompt #############################################################

# Highlight the last dir in the cwd ${(%):-%~} expands %~ outside the prompt
_prompt.path-update() {
  local cwd=${(%):-%~}
  cwd=${cwd//\%/%%} # escape % so prompt expansion shows it literally
  if [[ $cwd == */* ]]; then
    _prompt_path="%F{8}${cwd%/*}/%F{cyan}${cwd##*/}"
  else
    _prompt_path="%F{cyan}${cwd}" # no separator, e.g. ~
  fi
}

PROMPT='%B${_prompt_path}%f%b
%B%F{8}%%%f%b '
PROMPT2='%B%F{cyan}%~ %F{8}?%f%b '

# zle_highlight=(default:fg=magenta,bold)
zle_highlight=(default:bold)

# Print a blank line between prompts to make it easier to read
precmd() {
  echo
  _prompt.path-update
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
if _command.exists nvim; then
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

if _os.is-mac; then
  export PNPM_HOME="$HOME/Library/pnpm"
  path=("$PNPM_HOME" $path)
fi

### Deferred loads #####################################################

# Work that's safe to put off until after the first command runs. None of this
# blocks typing: nothing here runs until the first preexec, which fires the
# instant Enter is pressed on the first typed command.

autoload -Uz add-zsh-hook

typeset -ga _defer_queue
typeset -gA _bg_eval_fd

# Queue a zero-arg function to run once, on the first preexec.
_defer.add() {
  _defer_queue+=("$1")
}

_defer.flush() {
  add-zsh-hook -d preexec _defer.flush
  local fn
  for fn in "${_defer_queue[@]}"; do
    "$fn"
  done
  _defer_queue=()
}
add-zsh-hook preexec _defer.flush

# Start `name`'s command running now, in the background, via a saved file
# descriptor (a pipe) instead of a temp file. By the time _bg-eval.finish runs,
# after the first preexec, the command has almost always already finished, so
# the eval that follows is effectively instant.
_bg-eval.start() {
  local name=$1
  shift
  local -i fd
  # {fd}< <(...) opens fd bound to the process substitution's read end; the
  # command starts running now, in the background, no wait needed.
  exec {fd}< <("$@" 2>/dev/null)
  _bg_eval_fd[$name]=$fd
}

_bg-eval.finish() {
  local name=$1
  local -i fd=${_bg_eval_fd[$name]:-0}
  if (( fd <= 0 )); then
    return
  fi
  local out
  # read -d '' blocks until EOF, i.e. until the command is done; no fork
  IFS= read -r -d "" out <&$fd
  exec {fd}<&- # closes fd, unsets the binding
  unset "_bg_eval_fd[$name]"
  if [[ $out != "" ]]; then
    eval "$out"
  fi
}

_bg-eval.load-if-exists() {
  local name=$1
  shift
  if _command.exists "$name"; then
    _bg-eval.start "$name" "$@"
  fi
}

_bg-eval.load-if-exists brew brew shellenv
_bg-eval.load-if-exists direnv direnv hook zsh
_bg-eval.load-if-exists mise mise activate zsh

_load.brew() {
  _bg-eval.finish brew
}
_load.direnv() {
  _bg-eval.finish direnv
}
_load.mise() {
  _bg-eval.finish mise
}
_defer.add _load.brew
_defer.add _load.direnv
_defer.add _load.mise

# Automatic command suggestions as I type
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
_load.autosuggestions() {
  _source.try ~/.zsh-autosuggestions/zsh-autosuggestions.zsh
}
_load.autosuggestions

# Deferred after brew so its completions are picked up
_load.compinit() {
  autoload -Uz compinit
  compinit
}
_defer.add _load.compinit

# iTerm2 shell integration; install with _install.iterm2-shell-integration
_load.iterm2-integration() {
  _source.try ~/.iterm2_shell_integration.zsh
}
_defer.add _load.iterm2-integration

### Aliases ############################################################

# Easy open files
if _os.is-windows; then
  alias o='explorer.exe'
else
  alias o='open'
fi

# Use color with ls
if _os.is-mac; then
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi

# Replace `ls` with `eza`
# https://github.com/eza-community/eza
# https://eza.rocks/
if _command.exists eza; then
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
_install.autosuggestions() {
  git clone \
    https://github.com/zsh-users/zsh-autosuggestions \
    ~/.zsh-autosuggestions
}

# Install mise
_install.mise() {
  echo "https://mise.jdx.dev/getting-started.html"
  echo "brew install mise"
}

# Install homebrew
_install.homebrew() {
  bash <(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
}

# Install eza replacement for ls
_install.eza() {
  brew install eza
}

# Install iTerm2 shell integration (command marks, cmd+click downloads,
# jump-between-prompts, etc.)
_install.iterm2-shell-integration() {
  curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
}


### Misc functions #####################################################

_path.print() {
  echo $path | tr ' ' '\n'
}

_path.stem() {
  local file="$1"
  echo "${file:t:r}"
}

_convert.apng-to-webp() {
  local src="$1"
  local fallback="$(_path.stem "$src").webp"
  local out="${2:-$fallback}"
  ffmpeg -y -i "$src" -lossless 1 -loop 0 "$out"
}

# Benchmark interactive shell startup
# no_zle so the shell reads "exit" from stdin instead of the tty
_benchmark.zsh-startup() {
  local i
  for i in {1..5}; do
    time zsh -i -o no_zle <<< exit
  done
}

### Device-specific ####################################################

# Load device specific customizations
_source.try ~/.after.zshrc.zsh
