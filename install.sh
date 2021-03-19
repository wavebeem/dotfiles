#!/usr/bin/env bash
set -eu

Ansi() {
  echo $'\e['"$@m"
}
magenta=$(Ansi 35)
cyan=$(Ansi 36)
reset=$(Ansi 0)

# Find absolute path to current directory
dotfiles=$({ dir=$(dirname "$0"); cd "$dir"; pwd; })

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
  Install "gitconfig"
  # Run commands based on OS
  case "$(uname)" in
    Darwin) # Mac
      local app_support="$HOME/Library/Application Support"
      local vscode="$app_support/Code/User"
      local aseprite="$app_support/Aseprite"
      Install "hammerspoon"
      Install_as "vscode/keybindings.json" "$vscode/keybindings.json"
      Install_as "vscode/settings.json" "$vscode/settings.json"
      Install_as "vscode/snippets" "$vscode/snippets"
      Install_as "aseprite-scripts" "$aseprite/scripts"
      Install_as "Microsoft.PowerShell_profile.ps1" "$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1"
      ;;
  esac
}

# Shortcut since most of our dotfiles follow a predictable structure
Install() {
  local path="$1"
  Install_as "$path" "$HOME/.$path"
}

Install_as() {
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
  local short_dest="~${dest##$HOME}"
  echo -n "${magenta}${short_dest}${reset}"
  echo -n " => "
  echo -n "${cyan}${path}${reset}"
  echo
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
