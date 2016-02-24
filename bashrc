export LANG="en_US.UTF-8"

export LSCOLORS="ExfxcxdxBxegedabagacad"

case "$(uname)" in
FreeBSD|Darwin)
    alias ls='ls -G'
    ;;
Linux)
    alias ls='ls --color=auto'
    ;;
esac

# Turn off ^S and ^Q flow control
if which stty >/dev/null 2>&1; then
  stty -ixon >/dev/null 2>&1
fi

alias dim='echo ${COLUMNS}x${LINES}'

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

alias gdc='git diff --cached'
alias gd='git diff'
alias gs='git status'
alias g='git status'
alias gl='git lg'
alias l='ls -hl'
alias la='l -a'
alias ..='cd ..'

alias serve='python -m SimpleHTTPServer'

# Tab size 4
# Allow ANSI color sequences
export LESS="-R"
