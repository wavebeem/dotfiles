# Fix the value of $SHELL if it's broken
switch $SHELL
case "*fish"
case "*"
  set -x SHELL (which fish)
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

abbr -a st 'ssh-agent tmux'
abbr -a t tmux
abbr -a T 'tmux attach'

alias serve "python -m SimpleHTTPServer"

set -x VIRTUAL_ENV_DISABLE_PROMPT "yup"

set -x LANG "en_US.UTF-8"
set -x LSCOLORS "ExfxcxdxBxegedabagacad"

set -x EDITOR "vim"
set -x VISUAL "vim"
set -x PAGER "less"
set -x LESS "-R"

path_pre /sbin
path_pre /usr/sbin
path_pre /usr/local/bin
path_pre /usr/local/sbin
path_pre ~/Library/Python/2.7/bin
path_pre ~/.local/bin
path_pre ~/.rbenv/bin

set -g fish_prompt_pwd_dir_length 0

set fish_greeting

set -l primary_color cyan --bold
set -l secondary_color yellow --bold
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
  if which rbenv >/dev/null ^/dev/null
    rbenv init - | source
  end

  if test -f $HOME/.welcome
    cat $HOME/.welcome
  else
    uptime
  end
end
