#!/usr/bin/fish

set SCRIPT_DIR (dirname (status --current-filename))
source "$SCRIPT_DIR/load_core.fish"

set LABEL "rclone_webdav"

_check_command rclone
if test $status = $false
  _request_sudo
  if test $status = $false
    _log_error $LABEL "request root permission failed"
    return $false
  end
  sudo -v ; curl https://rclone.org/install.sh | sudo bash
end

echo "Config Name: $argv[1]"
echo "URL: $argv[2]"
echo "User: $argv[3]"
echo "Password: $argv[4]"
confirm "n"
if test $status = $false
  return $false
end

rclone config show | grep "\[$argv[1]\]" > /dev/null 2>&1
if test $status = $true
  _log_error $LABEL "config $argv[1] already exists"
  return $false
end

rclone config create $argv[1] webdav vendor=other url=$argv[2] user=$argv[3] pass=$argv[4]
