dim() {
  echo "$COLUMNS by $LINES"
}

precmd() {
  echo
}

fix_ssh() {
  var="$(tmux showenv -g | grep 'SSH_AUTH_SOCK=')"
  eval "export $var"
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

export PS1="\n${reset}${bold}${bg_cyan}${fg_white}  \$  ${reset} "
export PS2="${reset}${bold}${bg_cyan}${fg_white}  \$  ${reset} "

alias gco="git checkout"
alias gdd="git diff --cached"
alias ga="git add"
alias gaa="git add -A"
alias gd="git diff"
alias gm="git commit -m"
alias g="git status"
alias gl="git log"
alias gg="git commit"

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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
