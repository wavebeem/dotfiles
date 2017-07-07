function fix_ssh
  set sock (tmux showenv SSH_AUTH_SOCK | cut -d= -f2)
  set -x SSH_AUTH_SOCK $sock
end
