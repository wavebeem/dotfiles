#!/usr/bin/env bash
set -eu

# Hard coded path to dotfiles; change this if you put the repo somewhere else
dotfiles="$HOME/dotfiles"

# Edit the files in here depending on what files you have in your repo
Main() {
  Install "hushlogin"
  Install "welcome"
  Install "ackrc"
  Install "dircolors"
  Install "zshenv"
  Install "zshrc"
  Install "vimrc"
  Install "bashrc"
  Install "tmux.conf"
  Install "inputrc"
  Install "gitignore"
  # Run commands based on OS
  case "$(uname)" in
    Darwin) # Mac
      local app_support="$HOME/Library/Application Support"
      local vscode="$app_support/Code/User"
      local aseprite="$app_support/Aseprite"
      Install "hammerspoon"
      InstallAs "vscode/keybindings.json" "$vscode/keybindings.json"
      InstallAs "vscode/settings.json" "$vscode/settings.json"
      InstallAs "vscode/snippets" "$vscode/snippets"
      InstallAs "aseprite-scripts" "$aseprite/scripts"
      ;;
  esac
}

# Shortcut since most of our dotfiles follow a predictable structure
Install() {
  local path="$1"
  local dest="$HOME/.$path"
  InstallAs "$path" "$dest"
}

InstallAs() {
  local path="$1"
  local dest="$2"
  # Remove existing symbol link
  if [[ -L "$dest" ]]; then
    rm "$dest"
  # If a regular file/directory exists, ask to delete it
  elif [[ -e "$dest" ]]; then
    if ! Confirm "Delete $dest?"; then
      return
    fi
    rm -rf "$dest"
  fi
  # If the directory path doesn't exist, make it before installing the file
  local dir="$(dirname "$dest")"
  if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
  fi
  local src="$dotfiles/$path"
  echo "$dest"
  # Install the symbolic link
  ln -s "$src" "$dest"
}

# Ask a question and return true if the user says yes
Confirm() {
  local prompt="$@ [y/N] "
  local ans=""
  read -p "$prompt" ans
  [[ "$ans" = y* || "$ans" = Y* ]]
}

Main
