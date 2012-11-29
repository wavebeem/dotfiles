HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob nomatch notify
unsetopt beep
bindkey -v
bindkey '^R' history-incremental-search-backward
zstyle :compinstall filename '/home/brian/.zshrc'

autoload -Uz compinit
compinit

precmd_functions=($precmd_functions update_title)
set_title() {
    case "$TERM" in
    xterm*) echo -ne "\033]0;$*\007" ;;
    esac
}
update_title() {
    user="$USER"
    host="$HOST"
    dir="${PWD/$HOME/~}"

    set_title "$host ($dir)"
}

# aliases and such
alias ls='ls --color=auto'
alias l='ls -halF'
alias ..='cd ..'

# Use tabs by default in vim
alias vim='vim -p'

Git_Branch() {
    local branch
    branch=$(git symbolic-ref HEAD 2>/dev/null)
    branch=${branch:-<error>}
    branch=${branch##refs/heads/}
    echo "$branch"
}

Git_In_Repo() { git rev-parse --git-dir >/dev/null 2>&1; }

Git_Unpushed_Count()  { git log @{upstream}..                    2>/dev/null | wc -l; }
Git_Untracked_Count() { git ls-files --others --exclude-standard 2>/dev/null | wc -l; }
Git_Modified_Count()  { git ls-files --modified                  2>/dev/null | wc -l; }

Git_Has_Unpushed()  { test "$(Git_Unpushed_Count)"  -gt 0; }
Git_Has_Modified()  { test "$(Git_Modified_Count)"  -gt 0; }
Git_Has_Untracked() { test "$(Git_Untracked_Count)" -gt 0; }

Git_Has_Staged() {
    local count
    count=$(git diff --staged | head -n 1 | wc -l)

    test "$count" -gt 0
}

Join() {
    local sep=$1; shift
    local n=$#
    local result=""

    for ((i = 1; i < $n; i++)); do
        echo -n "${1}${sep}"
        shift
    done

    echo "${1}"
}

Prefix() {
    local pre=$1; shift

    for arg; do
        echo -n "${pre}${arg}"
    done
    echo
}

Prompt_Host() {
    bg="%B%F{black}"
    fg="%B%F{yellow}"
    er="%B%F{red}"
    e="%f%b"

    _host='%M'
    _name=$(hostname -f 2>/dev/null)
    case "$_name" in
    *.local) _host='%m' ;;
    esac
    _ps1="${bg}[${_host}]${e} "
    _ps2="${bg}[?]${e} "

    export RPROMPT=""

    nl=$'\n'

    # Code to run efore the prompt.
    precmd() {
        # If we're in a git repo, set up the prompt.
        if Git_In_Repo; then
            if Git_Has_Unpushed
            then _unpushed="unpushed"
            else _unpushed=""
            fi

            if Git_Has_Untracked
            then _untracked="untracked"
            else _untracked=""
            fi

            if Git_Has_Modified
            then _modified="modified"
            else _modified=""
            fi

            if Git_Has_Staged
            then _staging="staging"
            else _staging=""
            fi

            _prefix=" #"
            _items=(
                ${_unpushed}
                ${_untracked}
                ${_modified}
                ${_staging}
            )
            _flags=$(Prefix "$_prefix" "${_items[@]}")
            _branch=$(Git_Branch)

            _git="${bg}[git] ${fg}${_branch}${er}${_flags}${ue}"

            #export PS1="${bg}%m(${_git}${bg}):${e} "
            #export PS2="${bg}%m(${_git}${bg})?${e} "

            nl=$'\n'

            export PS1="${_git}${nl}${_ps1}"
            export PS2="${_ps2}"
        # Else use the regular prompt.
        else
            export PS1=$_ps1
            export PS2=$_ps2
        fi

        # Rehash to detect new commands.
        hash -r

        # Blank line for sanity.
        echo
    }

    # Code to run before executing the command.
    preexec() {
    }

    export PS1=$_ps1
    export PS2=$_ps2

    #export RPROMPT=""
}

Prompt_Host

source ~/.bashrc
