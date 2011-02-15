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
ncmpcpp/config
tmux.conf
gitconfig
gitignore_global
hgrc
)

SetupLink() {
    file="$1"

    if [ -L "$HOME/.$file" ]; then
        rm "$HOME/.$file"
    fi
    ln -s "$HOME/dotfiles/$file" "$HOME/.$file"
}

for file in "${files[@]}"; do
    SetupLink "$file"
done
