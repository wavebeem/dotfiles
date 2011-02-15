#!/bin/bash

files=(
config/roxterm.sourceforge.net
config/wmfs
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
ncmpcpp
tmux.conf
gitconfig
gitignore_global
hgrc
)

SetupLink() {
    file="$1"

    ln -s "$file" "$HOME/.$file"
}

for file in "${files[@]}"; do
    SetupLink "$file"
done
