function fish_prompt
  set c_reset (set_color normal)
  set c_normal (set_color normal)(set_color --bold)
  set c_light (set_color aaa --bold)
  set c_green (set_color green --bold)

  printf "%s" $c_reset

  set separator "$c_light :: "

  printf "%s%s" $c_light (whoami)
  printf "%s" $separator
  printf "%s%s" $c_green (prompt_hostname)
  printf "%s" $separator
  printf "%s%s" $c_normal (prompt_pwd)

  if not set -q $VIRTUAL_ENV
    printf "%s" $separator
    printf "%s%s" $c_light "venv"
  end

  __fish_git_prompt $separator"%s"

  echo

  printf "%s%s%s " $c_light ">>-" $c_reset
end

# I would totally put this in a separate file, but because functions are
# lazy-loaded, the prompt won't actually register this handler until it's
# defined. But fish *knows* to load `fish_prompt` so we're ok if it's over here.
function postexec --on-event fish_postexec
  echo
end
