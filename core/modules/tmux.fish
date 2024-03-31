#!/usr/bin/fish

function tmux_auto_session
  _check_command tmux
  if test $status = $false
    return $false
  end

  tmux ls >/dev/null 2>&1
  if test $status = $true
    tmux attach -t 0
  else
    tmux new-session
  end
end

alias tma='tmux_auto_session'
