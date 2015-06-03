HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Wait minimum amount of time for multi-key bindings. This makes hitting Escape
# with vi line editing nearly instant instead of quite slow. Note that a value
# of 0 does *NOT* work unfortunately. That makes it wait infinitely for more
# key presses. And for some reason this is in centiseconds instead of
# miliseconds.
KEYTIMEOUT=1

setopt appendhistory extendedglob notify
unsetopt beep nomatch
bindkey -v
bindkey '^R' history-incremental-search-backward
zstyle :compinstall filename ~/.zshrc

autoload -Uz compinit
compinit

# Let me lazily paste commands from the internet that have dollar in front...
alias '$'=''

Set_Title() {
    case "$TERM" in
    xterm*) echo -ne "\033]0;$*\007" ;;
    esac
}
Update_Title() {
    local dir="${PWD/$HOME/~}"
    Set_Title "zsh $dir"
}

precmd() {
    Update_Title
    hash -r
    echo
}

poo=$(echo "\U0001f4a9")
export PROMPT="$poo  "
export RPROMPT=""

preexec() {
    Set_Title "$1"
}

[ -f ~/.local-zshrc ] && source ~/.local-zshrc
source ~/.bashrc
