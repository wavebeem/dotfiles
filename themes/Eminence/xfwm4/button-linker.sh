#!/bin/bash

L() {
    local this=$1

    rm "$this"
    ln -s "$that" "$this"
}

that="close-active.xpm"
things=(
{hide,menu}-{active,pressed}.xpm
{stick,shade,maximize}-{toggled-,}{active,pressed}.xpm
)

for thing in "${things[@]}"; do
    L "$thing"
done

that="close-inactive.xpm"
things=(
{hide,menu}-inactive.xpm
{stick,shade,maximize}-{toggled-,}inactive.xpm
)

for thing in "${things[@]}"; do
    L "$thing"
done
