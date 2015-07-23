function dim
    echo "$COLUMNS by $LINES"
end

function '$'
    eval $argv
end

abbr -a gdc 'git diff --cached'
abbr -a gd 'git diff'
abbr -a g 'git status'
abbr -a gl 'git lg'

switch (uname)
case Darwin
    alias ls 'ls -G'
case '*'
    alias ls 'ls --color=auto'
end

alias l 'ls'
alias ll 'ls -hl'
alias la 'll -a'

alias serve 'python -m SimpleHTTPServer'

set -x LANG 'en_US.UTF-8'
set -x LSCOLORS 'ExfxcxdxBxegedabagacad'

set -x EDITOR 'vim'
set -x VISUAL 'vim'
set -x PAGER 'less'
set -x LESS '-R'

set -x PATH ~/.local/bin $PATH

set fish_greeting

set -l main_color green
set fish_color_normal $main_color
set fish_color_command $main_color
set fish_color_quote $main_color
set fish_color_redirection $main_color
set fish_color_end $main_color
set fish_color_error red
set fish_color_param $main_color
set fish_color_comment $main_color
set fish_color_match $main_color
set fish_color_search_match $main_color
set fish_color_operator $main_color
set fish_color_escape $main_color
set fish_color_cwd $main_color

if [ -f $HOME/.welcome ]
    cat $HOME/.welcome
else
    uptime
end
