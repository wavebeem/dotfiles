#!/usr/bin/env bash
set -eu

dotfiles="$HOME/dotfiles"
app_support="$HOME/Library/Application Support"
vscode="$app_support/Code/User"
aseprite="$app_support/Aseprite"

Install() {
  local path="$1"
  local dest="$HOME/.$path"
  Install_as "$path" "$dest"
}

Install_as() {
  local path="$1"
  local dest="$2"
  if [[ -L "$dest" ]]; then
    rm "$dest"
  elif [[ -e "$dest" ]]; then
    if ! Confirm "Delete $dest?"; then
      return
    fi
    rm -rf "$dest"
  fi
  local dir="$(dirname "$dest")"
  if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
  fi
  local src="$dotfiles/$path"
  echo "$dest"
  ln -s "$src" "$dest"
}

Confirm() {
  local prompt="$@ [y/N] "
  local ans=""
  read -p "$prompt" ans
  [[ "$ans" = y* || "$ans" = Y* ]]
}

files=(
  "hushlogin"
  "welcome"
  "ackrc"
  "dircolors"
  "zshenv"
  "zshrc"
  "vimrc"
  "bashrc"
  "tmux.conf"
  "inputrc"
  "gitignore"
)

for file in "${files[@]}"; do
  Install "$file"
done

case "$(uname)" in
  Darwin)
    Install "hammerspoon"
    Install_as "vscode/keybindings.json" "$vscode/keybindings.json"
    Install_as "vscode/settings.json" "$vscode/settings.json"
    Install_as "vscode/snippets" "$vscode/snippets"
    Install_as "aseprite-scripts" "$aseprite/scripts"
    ;;
esac
