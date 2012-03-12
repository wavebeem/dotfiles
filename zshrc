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
    branch=$(git symbolic-ref HEAD)
    branch=${branch##*/}
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

Prompt_Host() {
    bb="%B%F{black}"
    be="%f%b"

    fb="%B%F{cyan}"
    fe="%f%b"

    ub="%B%F{green}"
    ue="%f%b"

    _ps1="${bb}%m:${be} "
    _ps2="${bb}%m?${be} "

    # Code to run before the prompt.
    precmd() {
        # Rehash to detect new commands.
        hash -r

        # Blank line for sanity.
        echo

        # If we're in a git repo, set up the prompt.
        if Git_In_Repo; then
            if Git_Has_Unpushed
            then _unpushed="unpushed-"
            else _unpushed=""
            fi

            if Git_Has_Untracked
            then _untracked="untracked-"
            else _untracked=""
            fi

            if Git_Has_Modified
            then _modified="modified-"
            else _modified=""
            fi

            if Git_Has_Staged
            then _staging="staging"
            else _staging=""
            fi

            _flags="${bb}[${ub}${_unpushed}${_untracked}${_modified}${_staging}${ue}${bb}]"
            _branch="${fb}$(Git_Branch)${_flags}${fe}"

            export PS1="${bb}%m(${_branch}${bb}):${be} "
            export PS2="${bb}%m(${_branch}${bb})?${be} "
        # Else use the regular prompt.
        else
            export PS1=$_ps1
            export PS2=$_ps2
        fi
    }

    # Code to run before executing the command.
    preexec() {
    }

    export PS1=$_ps1
    export PS2=$_ps2

    export RPROMPT=""
}

Prompt_Host

source ~/.bashrc
