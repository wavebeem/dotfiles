dim() {
  echo "$COLUMNS by $LINES"
}

precmd() {
  echo
}

PROMPT_COMMAND="precmd"

bold="\[$(tput bold)\]"
cyan="\[$(tput setaf 2)\]"
reset="\[$(tput sgr0)\]"

separator="${reset} :: "
space=" "

export PS1="\
${reset}${bold}\u\
${separator}${reset}${bold}${cyan}\h\
${separator}${reset}${bold}\w\
\n${reset}${bold}>>- ${reset}\
"
export PS2="\
${reset}${bold}\
${space}${space}${space}${space}\
${reset}\
"

alias gco="git checkout"
alias gdd="git diff --cached"
alias ga="git add"
alias gaa="git add -A"
alias gd="git diff"
alias gm="git commit -m"
alias g="git status"
alias gl="git log"
alias gg="git commit"

case $(uname) in
Darwin)
  alias ls="ls -G" ;;
*)
  alias ls="ls --color=auto" ;;
esac

alias l="ls"
alias ll="ls -hl"
alias la="ll -a"

alias serve="python -m SimpleHTTPServer"

export LANG="en_US.UTF-8"
export LSCOLORS="ExfxcxdxBxegedabagacad"

export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
export LESS="-R"

export PATH="~/.local/bin:$PATH"
export PATH="~/.rbenv/bin:$PATH"
