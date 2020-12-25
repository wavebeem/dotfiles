export VIRTUAL_ENV_DISABLE_PROMPT="yup"
export LANG="en_US.UTF-8"
export LSCOLORS="ExfxcxdxBxegedabagacad"
export EDITOR="code --wait"
export GIT_EDITOR="$EDITOR"
export VISUAL="$EDITOR"
export PAGER="less"

path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "/sbin"
  "/usr/sbin"
  "/usr/local/bin"
  "/usr/local/sbin"
  $path
)

__source() {
  local file="$1"
  test -f "$file" && source "$file"
}

__source ~/.after.zshenv.zsh
