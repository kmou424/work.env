#!/usr/bin/fish

_path_bak

_path_append "$HOME/.local/bin"

_check_command go
if test $status = $true
  _path_append "(go env GOPATH)/bin"
end
