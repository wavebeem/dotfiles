dim() {
  echo "$COLUMNS by $LINES"
}

precmd() {
  echo
}

_ansi() {
  printf "\[%s%s\]" $'\e' "[$@m"
}

PROMPT_COMMAND="precmd"

bold=$(_ansi 1)
cyan=$(_ansi 36)
reset=$(_ansi 0)

export PS1="${reset}${bold}${cyan}bash:${reset} "
export PS2="${PS1}"

case $(uname) in
Darwin)
  alias ls="ls -G" ;;
*)
  alias ls="ls --color=auto" ;;
esac

alias l="ls"
alias ll="ls -hl"
alias la="ll -a"

alias ..='cd ..'

alias z="exec zsh"

alias t="tmux"
alias T="tmux attach -d"

alias serve="python -m SimpleHTTPServer"

export LANG="en_US.UTF-8"
export LSCOLORS="ExfxcxdxBxegedabagacad"

export PATH="~/.local/bin:$PATH"
export PATH="~/.rbenv/bin:$PATH"

if type rbenv >/dev/null 2>&1; then
  source <(rbenv init -)
fi

if [[ -f ~/.welcome ]]; then
  cat ~/.welcome
else
  uptime
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
