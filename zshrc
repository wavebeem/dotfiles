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
    #set_title "$user@$host  **  $dir"
    set_title "$host ($dir)"
}

# aliases and such
alias ls='ls --color=auto'
alias l='ls -halF'
alias ..='cd ..'
alias vim='vim -p'

Prompt_BW_Gradient() {
    local b1="%B"
    local e1="%b"

    local b2=""
    local e2=""

    local b3="%B%F{black}"
    local e3="%f%b"

    export PS1="
${b1}>${e1}${b2}>${e2}${b3}>${e3} "
    export PS2="${b1}?${e1}${b2}?${e2}${b3}?${e3} "

    export RPROMPT=""
}

Prompt_Host() {
    local b="%B%F{black}"
    local e="%f%b"

    precmd() {
        hash -r
        echo
    }

    preexec() {
    }

    export PS1="${b}%m:${e} "
    export PS2="${b}%m?${e} "

    export RPROMPT=""
}

Prompt_Rainbow() {
    local ender="%b%f"

    local     red="%B%F{red}"
    local  orange="%b%F{yellow}"
    local  yellow="%B%F{yellow}"
    local   green="%B%F{green}"
    local    cyan="%B%F{cyan}"
    local    blue="%B%F{blue}"
    local magenta="%B%F{magenta}"
    local   black="%B%F{black}"
    local   white="%f%B"
    local default="%f%b"
    local    grey="%b%F{gray}"
    local    gray="%b%F{gray}"

    local char1=">"
    local char2="?"
    local space=" "

    precmd() {
        hash -r
        echo
    }

    preexec() {
    }

    export PS1="\
${red}\
${char1}${orange}\
${char1}${yellow}\
${char1}${green}\
${char1}${cyan}\
${char1}${blue}\
${char1}${magenta}\
${char1}${ender} "

    export PS2="\
${black}\
${char2}${black}\
${char2}${black}\
${char2}${grey}\
${char2}${grey}\
${char2}${white}\
${char2}${white}\
${char2}${ender} "

    export RPROMPT=""
}

#Prompt_BW_Gradient
#Prompt_Rainbow
Prompt_Host

source ~/.bashrc
