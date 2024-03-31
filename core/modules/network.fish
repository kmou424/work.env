#!/usr/bin/fish

function add_wlanap -a interface
  _check_command iw
  if test $status != $true
    return $false
  end

  _check_command ip
  if test $status != $true
    return $false
  end

  if test -z $interface
    _log_error (status current-function) "network interface name can not be empty"
    return $false
  end

  ip a show $interface >/dev/null 2>&1
  if test $status = $false
    _log_error (status current-function) "network interface \"$interface\" is not found"
    return $false
  end

  _request_sudo
  if test $status = $false
    return $false
  end

  sudo iw dev $interface interface add wlanap type __ap
  if test $status = $true
    _log_error (status current-function) "network interface \"wlanap\" was created"
  end
end

function del_wlanap
  _check_command iw
  if test $status = $false
    return $false
  end

  _check_command ip
  if test $status != $true
    return $false·1
  end

  ip a show wlanap >/dev/null 2>&1
  if test $status = $false
    _log_error (status current-function) "network interface \"wlanap\" was never created, use \"create_wlanap\" to create a ap network interface"
    return $false
  end

  _request_sudo
  if test $status = $false
    return $false
  end

  sudo iw dev wlanap del
  if test $status = $true
    _log_error (status current-function) "network interface \"wlanap\" was deleted"
  end
end
