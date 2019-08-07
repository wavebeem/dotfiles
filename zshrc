HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt APPEND_HISTORY
setopt EXTENDED_GLOB
setopt NO_MATCH
# zsh 5.1 doesn't have this option...
setopt GLOB_STAR_SHORT 2>/dev/null
setopt INTERACTIVE_COMMENTS
bindkey -e
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit && compinit

:dim() {
  echo "$COLUMNS by $LINES"
}

:install-zsh-autosuggestions() {
  git clone --depth 1 \
    https://github.com/zsh-users/zsh-autosuggestions \
    ~/.zsh-autosuggestions
}

:install-fzf() {
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
}

# precmd() {
#   echo
# }

preexec() {
  echo
}

:notify() {
  local text="$*"
  if [[ $text = "" ]]; then
    text="Done"
  fi
  local title="$(date)"
  env text="$text" title="$title" osascript <<EOF
    display notification \
      (system attribute "text") \
      with title (system attribute "title") \
      sound name "Sosumi"
EOF
}

# Fix the value of $SHELL if it's broken
if [[ $SHELL != *zsh ]]; then
  export SHELL="$(which zsh)"
fi

if [[ $(uname -r) = *Microsoft ]]; then
  alias o='explorer.exe'
  alias e='explorer.exe'
else
  alias o='open'
  alias e='open'
fi

# Allow pasting commands with "$" from the internet
alias '$'=""

alias gco="git checkout"
alias gdd="git diff --cached"
alias ga="git add"
alias gaa="git add --all"
alias gd="git diff"
alias gm="git commit --message"
alias g="git status"
alias gl="git log"
alias gg="git commit --verbose"
alias gp="git push origin HEAD"

if [[ $(uname) = Darwin ]]; then
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi

alias l="ls"
alias ll="ls -hl"
alias la="ll -a"

alias t="tmux"
alias T="tmux attach -d"

alias ..="cd .."

export FZF_DEFAULT_OPTS="--color=light --bind ctrl-j:accept"

:slack-font() {
  local x="${1:-⬛️}"
  local o="${2:-⬜️}"
  toilet -f bigmono9 |
    sed "s/[xX#0\"m█▓]/$x/g" |
    sed "s/[ .▒]/$o/g" |
    pbcopy
}

:load-nvm() {
  . ~/.nvm/nvm.sh
}

if ! which serve >/dev/null 2>&1; then
  alias serve="python -m SimpleHTTPServer"
fi

if which rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

if which pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [[ $__already_welcome != "yes" ]]; then
  if [[ -f ~/.welcome ]]; then
    cat ~/.welcome
  else
    uptime
  fi
fi
__already_welcome="yes"

:set-prompt() {
  local pad="  "
  local glyph="%%"
  local username="%n"
  local hostname="%m"
  local cwd="%1~"
  local reset="%b%f%k%u%s"
  local c1="%B%F{white}%K{green}"
  local end="${c2}${glyph}${reset} "
  local nl=$'\n'
  local p="${reset}${c1}  ${cwd}  ${reset} "
  PROMPT="${nl}${p}"
  PROMPT2="${p}"
}

:set-prompt

:maybe-source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh
:maybe-source ~/.travis/travis.sh
:maybe-source ~/google-cloud-sdk/path.zsh.inc
:maybe-source ~/google-cloud-sdk/completion.zsh.inc
:maybe-source ~/.fzf.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

:maybe-source ~/.after.zshrc.zsh
