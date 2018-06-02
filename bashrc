dim() {
  echo "$COLUMNS by $LINES"
}

precmd() {
  echo
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
cyan=$(_ansi 32)
purple=$(_ansi 35)
blue=$(_ansi 34)
reset=$(_ansi 0)

separator="${reset}${blue} | "
space=" "

export PS1="\
${reset}${bold}${purple}\u\
${separator}${reset}${bold}${cyan}\h\
${separator}${reset}${bold}${purple}\w\
\n${reset}${blue}\$ ${reset}\
"
export PS2="${reset}${purple}\$ ${reset}"

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

# If stdin and stdout are connected to the tty (interactive mode)
if type rbenv >/dev/null 2>&1; then
  source <(rbenv init -)
fi

if [[ -f ~/.welcome ]]; then
  cat ~/.welcome
else
  uptime
fi
