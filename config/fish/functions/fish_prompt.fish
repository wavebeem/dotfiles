function fish_prompt
  set last_status $status
  set_color reset
  echo
  set light aaa
  set_color $light --bold
  echo -n "::: "
  set_color cyan --bold
  set user (whoami)
  set host (hostname -s)
  echo -n $user
  set_color $light --bold
  echo -n " ::: "
  set_color magenta --bold
  echo -n $host
  set_color $light --bold
  echo -n " :::"
  set_color reset
  echo -n " "
end
