# Set up ls colors
if which dircolors 2>&1 >/dev/null
then eval $(dircolors)
fi

# Make the shell line editor behave like vi!
set -o vi

[ -z "$SSH_AGENT_PID" ] && eval "$(ssh-agent)"

# Add my programs to the path
export PATH="$HOME/.local/bin:$HOME/.gem/ruby/1.9.1/bin:$HOME/bin:$PATH"

export LD_LIBRARY_PATH="$HOME/.local/lib"

if which setterm 2>&1 >/dev/null; then
    # No more \a
    setterm -blength 0 >/dev/null 2>&1

    # Stop blanking the terminal
    setterm -blank 0 >/dev/null 2>&1
fi

# Colors for man/less
#export LESS_TERMCAP_mb=$'\E[01;31m'
#export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01m'
export LESS_TERMCAP_md=$'\E[01m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;41;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'

# ANSI formatting for pretty-ness
export RI="-f ansi"

alias wu='ssh bmock@shell.willamette.edu'

alias dim='echo ${COLUMNS}x${LINES}'
alias sl='sl -alF'
alias rb='exec "$(readlink /proc/$$/exe)"'

alias t="tmux"
alias T="tmux attach"

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

alias ls='ls --color=auto'
alias l='ls -hl'
alias la='l -a'
alias ..='cd ..'
alias vim='vim -p'
alias du='ncdu'
alias df='pydf'

# Quicker job control
alias k='kill %%'
alias kk='kill -9 %%'

alias irb='irb --readline -r irb/completion'

alias a='aptitude'
alias sa='sudo aptitude'
alias sag='sudo apt-get'
alias ai='sudo aptitude install'
alias ar='sudo aptitude remove'
alias as='aptitude search'

# Move around the fs tree faster
alias go='cd "$_"'
alias gou='cd "$(dirname "$_")"'

# Tab size 4
# Allow ANSI color sequences
export LESS="-R"

# Greet me with ASCII/ANSI art,
if [ -z "$SSH_CLIENT" -o -n "$TMUX" ] && [ -f "$HOME/.welcome" ]
then cat "$HOME/.welcome"
else uptime
fi

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

[ -z "$SSH_AGENT_PID" ] && eval "$(ssh-agent)"
