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

Set_Title() {
    case "$TERM" in
    xterm*) echo -ne "\033]0;$*\007" ;;
    esac
}
Update_Title() {
    local user="$USER"
    local host="$HOST"
    local dir="${PWD/$HOME/~}"

    Set_Title "zsh: $dir"
}

Git_Branch() {
    local branch
    local sha1
    # Try to use branch name and fall back to SHA1
    sha1=$(git rev-parse HEAD 2>/dev/null)
    branch=$(git symbolic-ref HEAD 2>/dev/null)
    branch=${branch:-$sha1}
    branch=${branch##refs/heads/}
    echo "$branch"
}

Git_In_Repo() { git rev-parse --git-dir >/dev/null 2>&1; }
Git_Root()    { git rev-parse --show-toplevel 2>/dev/null; }

Git_Has() {
    local count
    count=$(git "$@" 2>/dev/null | wc -l)
    test "$count" -gt 0
}

Git_Has_Unpushed()  { Git_Has log @{upstream}..; }
Git_Has_Untracked() { Git_Has ls-files --others --exclude-standard "$(Git_Root)"; }
Git_Has_Modified()  { Git_Has ls-files --modified "$(Git_Root)"; }

Git_Has_Stash() {
    git stash show >/dev/null 2>&1
}

Git_Has_Staged() {
    local count
    count=$(git diff --staged | head -n 1 | wc -l)
    test "$count" -gt 0
}

precmd() {
    Update_Title

    local _flags _branch _git nl

    local c1="%B%F{cyan}"
    local c2="%B%F{yellow}"
    local c3="%B%F{magenta}"
    local cr="%f%b"

    export RPROMPT=""
    local _pwd="%B%F{green}%~%f%b"

    local _user='%n'
    local _host='%M'
    local _name=$(hostname -f 2>/dev/null)
    case "$_name" in
    *.local) _host='%m' ;;
    esac

    local _info="${c1}${_host}[${_pwd}${c1}]"

    nl=$'\n'

    local _ps1 _ps2

    _ps1="${c1}>${cr} "
    _ps2="${c1}?${cr} "

    if Git_In_Repo; then
        _flags=$(
            Git_Has_Unpushed    && echo -n '>'
            Git_Has_Untracked   && echo -n '+'
            Git_Has_Modified    && echo -n '*'
            Git_Has_Staged      && echo -n '<'
            Git_Has_Stash       && echo -n '_'
        )

        _branch=$(Git_Branch)
        _git="${c1}: ${c2}${_branch}${c3}${_flags}${ue}${c1}${cr}"

        export PS1="${_info}${_git}${nl}${_ps1}${cr}"
        export PS2="${_info}${_git}${nl}${_ps2}${cr}"
    else
        export PS1="${_info}${nl}${_ps1}${cr}"
        export PS2="${_info}${nl}${_ps2}${cr}"
    fi

    # Rehash to detect new commands
    hash -r

    # Blank line for sanity
    echo
}

preexec() {
    Set_Title "$1"
}

[ -f ~/.local-zshrc ] && source ~/.local-zshrc
source ~/.bashrc
