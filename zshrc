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
local bmain="%B%F{red}"
local emain="%f%b"

local bsec="%B%F{white}"
local esec="%f%b"

local betc="%B%F{green}"
local eetc="%f%b"

local brp="%B%F{black}"
local erp="%f%b"
# }}}

# Ruby
export PS1="${betc}{ ${eetc}${bmain}:%n${emain} ${betc}=>${eetc} ${bsec}@%m${esec}${betc} }${eetc} "
export PS2="${betc}{ ${eetc}${bmain}:%n${emain} ${betc}=>${eetc} ${bsec}@%m${esec}${betc} |${eetc} "

export RPROMPT="${brp}%D{%H:%M:%S}${erp}"

source ~/.bashrc
