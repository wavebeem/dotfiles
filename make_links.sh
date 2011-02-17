#!/bin/bash

files=(
config/roxterm.sourceforge.net
config/wmfs/wmfsrc
conkyrc
vim
vimrc
Xresources
Xdefaults
xinitrc
zshrc
bashrc
bash_profile
fonts.conf
ncmpcpp/config
tmux.conf
gitconfig
gitignore_global
hgrc
inputrc
xbindkeysrc
)

SetupLink() {
    file="$1"

    yes_dot="$HOME/.$file"
    not_dot="$HOME/dotfiles/$file"

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
        y|Y) rm "$yes_dot"  ;;
        n|N) return         ;;
        esac
    fi

    echo "Linking $yes_dot -> $not_dot"
    MakeDirThenLink "$not_dot" "$yes_dot"
}

MakeDirThenLink() {
    file="$1"

    the_dir="$(dirname "$file")"

    if [ ! -d "$the_dir" ]; then
        mkdir -p "$the_dir"
    fi
}

for file in "${files[@]}"; do
    SetupLink "$file"
done
