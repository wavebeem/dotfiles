function fish_prompt
  set last_status $status
  set_color reset
  set light aaa
  set_color green --bold
  set user (whoami)
  set host (hostname -s)
  set_color green --bold
  echo -n $host
  set_color $light --bold
  echo -n " :::"
  set_color reset
  echo -n " "
end
