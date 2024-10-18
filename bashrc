# shellcheck shell=bash
export PS1="bash: "
export PS2="$PS1"
export LANG="en_US.UTF-8"
# Load asdf
if [[ -e "$HOME/.asdf/asdf.sh" ]]; then
  source "$HOME/.asdf/asdf.sh"
  # append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)
  # initialize completions with zsh's compinit
  autoload -Uz compinit && compinit
fi
