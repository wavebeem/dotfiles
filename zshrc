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

__Install_zsh_autosuggestions() {
  git clone --depth 1 \
    https://github.com/zsh-users/zsh-autosuggestions \
    ~/.zsh-autosuggestions
}

preexec() {
  echo
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

if ! __Has_cmd serve; then
  alias serve="python -m SimpleHTTPServer"
fi

if __Has_cmd rbenv; then
  eval "$(rbenv init -)"
fi

if __Has_cmd pyenv; then
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

__Set_prompt() {
  local nl=$'\n'
  local p="%B%F{cyan}zsh:%f%b "
  PROMPT="${nl}${p}"
  PROMPT2="${p}"
}

__Set_prompt

__Maybe_source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh
__Maybe_source ~/.travis/travis.sh
__Maybe_source ~/.nvm/nvm.sh
__Maybe_source ~/google-cloud-sdk/path.zsh.inc
__Maybe_source ~/google-cloud-sdk/completion.zsh.inc

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

__Maybe_source ~/.after.zshrc.zsh
