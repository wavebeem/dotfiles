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

dim() {
  echo "$COLUMNS by $LINES"
}

__install_zsh_autosuggestions() {
  git clone --depth 1 \
    https://github.com/zsh-users/zsh-autosuggestions \
    ~/.zsh-autosuggestions
}

__install_fzf() {
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
}

# precmd() {
#   echo
# }

preexec() {
  echo
}

notify() {
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
else
  alias o='open'
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

if ! which serve >/dev/null 2>&1; then
  alias serve="python -m SimpleHTTPServer"
fi

if which rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

if [[ $__already_welcome != "yes" ]]; then
  if [[ -f ~/.welcome ]]; then
    cat ~/.welcome
  else
    uptime
  fi
fi
__already_welcome="yes"

__set_prompt() {
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

__set_prompt

__maybe_source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh
__maybe_source ~/.travis/travis.sh
__maybe_source ~/google-cloud-sdk/path.zsh.inc
__maybe_source ~/google-cloud-sdk/completion.zsh.inc
__maybe_source ~/.fzf.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

__maybe_source ~/.after.zshrc.zsh
