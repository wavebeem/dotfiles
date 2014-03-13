#!/bin/bash

files=(
# mpd/mpd.conf
ackrc
irbrc
dircolors
zshenv
vim
vimrc
zshrc
bashrc
bash_profile
tmux.conf
# gitconfig
# gitignore_global
# hgrc
inputrc
# welcome
)

SetupLink() {
    local file="$1"

    local yes_dot="$HOME/.$file"
    local not_dot="$HOME/dotfiles/$file"

    # Delete possibly old, stale links
    if [ -L "$yes_dot" ]; then
        rm "$yes_dot"
    fi

    # Possibly delete currently installed config files
    if [ -f "$yes_dot" ] || [ -d "$yes_dot" ]; then
        [ -f "$yes_dot" ] && the_type=file
        [ -d "$yes_dot" ] && the_type=dir

        echo -n "Do you wish to delete the $the_type $yes_dot? [y/N] "
        read -r reply

        case "$reply" in
        y|Y) rm -r "$yes_dot"  ;;
        n|N) return            ;;
        esac
    fi

    echo "Linking $yes_dot -> $not_dot"
    MakeDirThenLink "$not_dot" "$yes_dot"
}

MakeDirThenLink() {
    local dot="$1"
    local file="$2"

    the_dir="$(dirname "$file")"

    if [ ! -d "$the_dir" ]; then
        mkdir -p "$the_dir"
    fi

    ln -s  "$dot" "$file"
}

for file in "${files[@]}"; do
    SetupLink "$file"
done
