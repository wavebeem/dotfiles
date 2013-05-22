# Set up ls colors
if which dircolors 2>&1 >/dev/null
then eval $(dircolors)
fi

# Turn off ^S and ^Q flow control
if which stty 2>&1 >/dev/null
then stty -ixon 2>&1 >/dev/null
fi

# Make the shell line editor behave like vi!
set -o vi

# Add my programs to the path
export PATH="$HOME/.local/bin:$HOME/.gem/ruby/1.9.1/bin:$HOME/bin:/usr/local/share/npm/bin:$PATH"

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
alias sl='sl -l'
alias rb='exec "$(readlink /proc/$$/exe)"'

alias t="tmux"
alias T="tmux attach -d"

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

case "$(uname)" in
Darwin)
    if which gls 2>&1 >/dev/null;
    then alias ls='gls --color=auto'
    else alias ls='ls -G'
    fi
    ;;
*)
    alias ls='ls --color=auto'
    ;;
esac

alias l='ls -hl'
alias la='l -a'
alias ..='cd ..'
alias vim='vim -p'

if which ncdu 2>&1 >/dev/null
then alias du='ncdu'
else alias du='du -csh'
fi

if which pydf 2>&1 >/dev/null
then alias df='pydf'
else alias df='df -h'
fi

# Quicker job control
alias k='kill %%'
alias kk='kill -9 %%'
alias j='jobs'

alias irb='irb --readline -r irb/completion'

alias a='aptitude'
alias sa='sudo aptitude'
alias sag='sudo apt-get'
alias ai='sudo aptitude install'
alias ar='sudo aptitude remove'
alias as='aptitude search'

alias http='python -m SimpleHTTPServer'

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

# Execute Dropbox daemon if it's not running
if which dropbox >/dev/null 2>/dev/null; then
    dropbox running >/dev/null
    if [ $? = 0 ]; then
        dropbox start >/dev/null
    fi
fi

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

case "$HOST" in
truffle) [ -z "$SSH_AGENT_PID" ] && eval "$(ssh-agent)" ;;
esac
