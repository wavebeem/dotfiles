function fish_prompt
  set cr (set_color normal)
  set c1 $cr(set_color --bold)
  set c2 $cr(set_color green --bold)
  set c3 $cr
  set separator " :: "

  printf "%s%s" $c1 (whoami)
  printf "%s%s" $c3 $separator
  printf "%s%s" $c2 (hostname -s)
  printf "%s%s" $c3 $separator
  printf "%s%s" $c1 (prompt_pwd)

  if not set -q $VIRTUAL_ENV
    printf "%s%s" $c3 $separator
    printf "%s%s" $c1 "venv"
  end

  echo

  printf "%s%s%s " $c1 ">>-" $cr
end

# I would totally put this in a separate file, but because functions are
# lazy-loaded, the prompt won't actually register this handler until it's
# defined. But fish *knows* to load `fish_prompt` so we're ok if it's over here.
function postexec --on-event fish_postexec
  echo
end
