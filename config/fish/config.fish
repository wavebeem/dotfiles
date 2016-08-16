function dim
  echo "$COLUMNS by $LINES"
end

function '$'
  eval $argv
end

abbr -a gco "git checkout"
abbr -a gdd "git diff --cached"
abbr -a ga "git add"
abbr -a gaa "git add -A"
abbr -a gd "git diff"
abbr -a gm "git commit -m"
abbr -a g "git status"
abbr -a gl "git log"
abbr -a gg "git commit"

switch (uname)
case Darwin
  alias ls "ls -G"
case "*"
  alias ls "ls --color=auto"
end

alias l "ls"
alias ll "ls -hl"
alias la "ll -a"

alias serve "python -m SimpleHTTPServer"

set -x LANG "en_US.UTF-8"
set -x LSCOLORS "ExfxcxdxBxegedabagacad"

set -x EDITOR "vim"
set -x VISUAL "vim"
set -x PAGER "less"
set -x LESS "-R"

set -x PATH ~/.local/bin $PATH

set fish_greeting

set -l primary_color cyan --bold
set -l secondary_color magenta --bold
set -l error_color red

set fish_color_normal $secondary_color
set fish_color_command $primary_color
set fish_color_quote $secondary_color
set fish_color_redirection $secondary_color
set fish_color_end $secondary_color
set fish_color_error $error_color
set fish_color_param $secondary_color
set fish_color_comment $secondary_color
set fish_color_match $secondary_color
set fish_color_search_match $secondary_color
set fish_color_operator $secondary_color
set fish_color_escape $secondary_color
set fish_color_cwd $secondary_color

if status --is-interactive
  if which rbenv >/dev/null
    rbenv init - | source
  end

  if [ -f $HOME/.welcome ]
    cat $HOME/.welcome
  else
    uptime
  end
end
