export VIRTUAL_ENV_DISABLE_PROMPT="yup"
export LANG="en_US.UTF-8"
export LSCOLORS="ExfxcxdxBxegedabagacad"
export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
export LESS="-R"
export ANDROID_HOME="$HOME/Library/Android/sdk"

path=(
  "$HOME/.local/bin"
  "$HOME/.rbenv/bin"
  "$HOME/Library/Python/2.7/bin"
  "$ANDROID_HOME/tools"
  "$ANDROID_HOME/platform-tools"
  "/sbin"
  "/usr/sbin"
  "/usr/local/bin"
  "/usr/local/sbin"
  $path
)
