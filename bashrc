# shellcheck shell=bash
export LANG="en_US.UTF-8"

bold='\[\e[1m\]'
edge='\[\e[90m\]'
blue='\[\e[94m\]'
reset='\[\e[0m\]'

export PS1="\n${bold}${blue}\w ${edge}\\\$${reset} "
export PS2="\n${bold}${blue}\w ${edge}?${reset} "
