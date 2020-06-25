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
bg_cyan=$(_ansi 42)
bg_purple=$(_ansi 45)
fg_white=$(_ansi 37)
fg_blue=$(_ansi 34)
reset=$(_ansi 0)

separator="${reset} "
space=" "

export PS1="\n${reset}${bold}${bg_purple}${fg_white}  \W  ${reset} "
export PS2="${reset}${bold}${bg_purple}${fg_white}  \W  ${reset} "

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

export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
export LESS="-R"

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
