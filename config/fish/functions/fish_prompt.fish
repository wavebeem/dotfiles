function fish_prompt
  set last_status $status
  set_color reset
  if test $last_status -eq 0
    set_color green
    set char "=>"
  else
    set_color red
    set char "!!"
  end
  echo
  echo -n $char
  set_color reset
  echo -n " "
end
