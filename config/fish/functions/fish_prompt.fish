function fish_prompt
  set_color reset

  # Apparently you actually have to quote for `test` with fish :/
  if test -n "$VIRTUAL_ENV"
    set_color aaa --bold
    echo -n "(venv) "
  end

  set_color green --bold
  echo -n (hostname -s)

  set_color aaa --bold
  echo -n " :::"

  set_color reset
  echo -n " "
end
