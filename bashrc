export LANG="en_US.UTF-8"

export LSCOLORS="ExfxcxdxBxegedabagacad"

case "$(uname)" in
FreeBSD|Darwin)
    if which gls 2>&1 >/dev/null;
    then alias ls='gls --color=auto'
    else alias ls='ls -G'
    fi

    if which gdircolors 2>&1 >/dev/null;
    then alias dircolors=gdircolors
    fi
    ;;
*)
    alias ls='ls --color=auto'
    ;;
esac

# Set up ls colors
if type dircolors 2>&1 >/dev/null
then eval $(dircolors ~/.dircolors)
fi

# Turn off ^S and ^Q flow control
if which stty 2>&1 >/dev/null
then stty -ixon 2>&1 >/dev/null
fi

# Make the shell line editor behave like vi!
set -o vi

export LD_LIBRARY_PATH="$HOME/.local/lib"

if which setterm 2>&1 >/dev/null; then
    # No more \a
    setterm -blength 0 >/dev/null 2>&1

    # Stop blanking the terminal
    setterm -blank 0 >/dev/null 2>&1
fi

# ANSI formatting for pretty-ness
export RI="-f ansi"

alias dim='echo ${COLUMNS}x${LINES}'
alias sl='sl -l'

alias t="tmux"
alias T="tmux attach -d"

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

if which ncdu 2>&1 >/dev/null
then alias du='ncdu'
else alias du='du -csh'
fi

if which pydf 2>&1 >/dev/null
then alias df='pydf'
else alias df='df -h'
fi

alias mount='mount | column -t'

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

# Tab size 4
# Allow ANSI color sequences
export LESS="-R"

# Greet me with ASCII/ANSI art,
if [ -z "$SSH_CLIENT" -o -n "$TMUX" ] && [ -f "$HOME/.welcome" ]
then cat "$HOME/.welcome"
else uptime
fi

path() {
    echo "$PATH" | tr ':' '\n'
}

case "$HOST" in
truffle|croissant|beignet)
    [ -z "$SSH_AGENT_PID" ] && eval "$(ssh-agent)"

    # Execute Dropbox daemon if it's not running
    if which dropbox >/dev/null 2>/dev/null; then
        dropbox running >/dev/null
        if [ $? = 0 ]; then
            dropbox start >/dev/null
        fi
    fi
    ;;
esac
