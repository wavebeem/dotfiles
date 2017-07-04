function fish_prompt
  set_color reset

  set home ~
  set cwd (pwd | sed "s|$home|~|")

  set_color green --bold
  echo -n (hostname -s)

  set_color aaa --bold
  echo -n " :: "

  set_color black --bold
  echo -n $cwd

  # Apparently you actually have to quote for `test` with fish :/
  if test -n "$VIRTUAL_ENV"
    set_color aaa --bold
    echo -n " :: "
    set_color aaa --bold
    echo -n "venv"
  end

  echo

  set_color aaa --bold
  echo -n "=>>"

  set_color reset
  echo -n " "
end
