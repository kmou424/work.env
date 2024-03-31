#!/usr/bin/fish

# Global constants
set -g true 0
set -g false 1

set -g DISTRO (grep -oP '^ID=\K\w+' /etc/os-release)

# load other script
function fishing -a fish_path must
  if test -f $fish_path
    if _equal $DEBUG $true; \
      _log_info (status current-function) "loading $fish_path"; \
    end; \
    source $fish_path || true
  else if test -d $fish_path
    set fish_files (find $fish_path -type f -name "*.fish")
    for fish_file in $fish_files
      if _equal $DEBUG $true
        _log_info (status current-function) "loading $fish_file"
      end
      source $fish_file || true
    end
  else
    if _equal $must $true
      _log_error (status current-function) "load script(s) $fish_path failed!"
      return $false
    end
    return $false
  end
  return $true
end

# ensure load in non-interactive mode
function _must_non_interactive
  if not status is-interactive
    _log_error (status current-function) "scripts must load in non-interactive mode"
    exit 101
  end
end

function _assert_equal -a expect value
  if $value != $expect
    _log_error (status current-function) "failed! expect $expect, but actual $value"
    exit 102
  end
end

# convert to plain value then compare them
function _equal -a value expect
  if test (echo $value) = (echo $expect)
    return $true
  else
    return $false
  end
end

# check command whether exists
function _check_command -a target must
  command -v $target >/dev/null 2>&1
  if test $status -ne $true
    _log_error (status current-function) "$target is not installed. Please install $target and try again."
    if _equal $must $true
      exit 103
    end
    return $false
  end
  return $true
end

# test sudo
function _request_sudo -a must
  sudo -v > /dev/null 2>&1
  if test $status = $true
    return $true
  else
    if _equal $must $true
      _log_error (status current-function) "failed!"
      exit 104
    end
    return $false
  end
end

function _mount_smb -a mountpoint target
  if not test -d $mountpoint
    mkdir -p $mountpoint
  end

  mountpoint $mountpoint &>/dev/null
  if test $status != $true
    # try to mount smb
    sudo mount -t drvfs $target $mountpoint
  end
end
