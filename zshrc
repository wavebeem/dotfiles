HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob nomatch notify
unsetopt beep
bindkey -v
zstyle :compinstall filename '/home/brian/.zshrc'

autoload -Uz compinit
compinit

precmd_functions=($precmd_functions update_title)
set_title() {
    case "$TERM" in
    xterm*)
        echo -ne "\033]0;$*\007"
        ;;
    esac
}
update_title() {
    user="$USER"
    host="$HOST"
    dir="${PWD/$HOME/~}"
    #dir="$(basename $PWD)"
    #dir="${dir/$HOME/~}"

    #set_title "$user@$host:$dir"
    set_title "$user@$host  **  $dir"
}

# aliases and such
alias ls='ls --color=auto'
alias l='ls -halF'
alias ..='cd ..'
alias vim='vim -p'

# {{{ Color vars
local dark="%B%F{black}"
local darki="%f%b"

local light="%B"
local lighti="%b"
# }}}

export PS1="
${light}>${lighti} "
export PS2="
${light}?${lighti} "

export RPROMPT=""

source ~/.bashrc
