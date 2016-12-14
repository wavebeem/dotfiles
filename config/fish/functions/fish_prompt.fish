function fish_prompt
  set poo \U1F4A9
  set lollipop \U1F36D

  if test $status -eq 0
    set emoji $lollipop
  else
    set emoji $poo
  end

  set_color reset
  echo
  echo -n "$emoji  "
end
