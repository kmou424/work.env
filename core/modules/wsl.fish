#!/usr/bin/fish

if test -z "$WSL_DISTRO_NAME"
  exit 1
end

if _equal $WSL_STATIC_IP $true
  _check_command ip
  if test $status != $true
    exit 1
  end

  _request_sudo $false
  if test $status != $true
    exit 1
  end

  sudo ip addr show eth0 | grep -s "172.18.18.128/24" >/dev/null
  if test $status != $true
    sudo ip addr add 172.18.18.128/24 broadcast 172.18.18.255 dev eth0 label eth0:1
  end
end

if _equal $WSL_JUMP_HOME $true
  if string match -q "*steamapps/common/MyDockFinder" $PWD
    cd $HOME
  end

  if string match -q "*Windows/System32" $PWD
    cd $HOME
  end
end
