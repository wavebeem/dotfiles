# zsh's first run configurator wrote this junk
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt APPEND_HISTORY EXTENDED_GLOB NO_MATCH GLOB_STAR_SHORT
bindkey -e
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

dim() {
  echo "$COLUMNS by $LINES"
}

fix_ssh() {
  eval "export $(tmux showenv SSH_AUTH_SOCK)"
}

sa() {
  eval "$(ssh-agent)"
}

__set_title() {
  print -Pn "\e]0;$1\a"
}

precmd() {
  __set_title "zsh %~"
  echo
  echo
}

preexec() {
  __set_title "$1"
}

# Fix the value of $SHELL if it's broken
case "$SHELL" in
*zsh)
  ;;
*)
  export SHELL="$(which zsh)"
  ;;
esac

# Allow pasting commands with "$" from the internet
alias '$'=""

alias gco="git checkout"
alias gdd="git diff --cached"
alias ga="git add"
alias gaa="git add -A"
alias gd="git diff"
alias gm="git commit -m"
alias g="git status"
alias gl="git log"
alias gg="git commit"

case "$(uname)" in
Darwin)
  alias ls "ls -G"
  ;;
*)
  alias ls "ls --color=auto"
  ;;
esac

alias l="ls"
alias ll="ls -hl"
alias la="ll -a"

alias t=tmux
alias T='tmux attach'

alias serve="python -m SimpleHTTPServer"

# TODO: Do I want these in zshenv instead?
path=(
  "/sbin"
  "/usr/sbin"
  "/usr/local/bin"
  "/usr/local/sbin"
  "$HOME/Library/Python/2.7/bin"
  "$HOME/.local/bin"
  "$HOME/.rbenv/bin"
  $path
)

if which rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

if test -f "$HOME/.welcome"; then
  cat "$HOME/.welcome"
else
  uptime
fi

# git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh-autosuggestions
if test -f ~/.zsh-autosuggestions/zsh-autosuggestions.zsh; then
  source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh
fi

sep=" :: "
glyph=">>-"
username="%n"
hostname="%m"
cwd="%~"
reset="%b%f%u%s"
prompt="\
${reset}\
%B${username}${reset}${sep}\
%B%F{green}${hostname}${reset}${sep}\
%B${cwd}${reset}
%B${glyph}${reset} "
