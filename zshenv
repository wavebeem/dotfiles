export VIRTUAL_ENV_DISABLE_PROMPT="yup"
export LANG="en_US.UTF-8"
export LSCOLORS="ExfxcxdxBxegedabagacad"
export EDITOR="code --wait"
export GIT_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "/sbin"
  "/usr/sbin"
  "/usr/local/bin"
  "/usr/local/sbin"
  $path
)

__Maybe_source() {
  local file="$1"
  test -f "$file" && source "$file"
}

__Has_cmd() {
  local cmd="$1"
  which "$cmd" >/dev/null 2>&1
}

__Maybe_source ~/.after.zshenv.zsh
