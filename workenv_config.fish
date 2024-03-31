set -g DEBUG $true

set -g PROXY_URL "http://127.0.0.1:7890"

set -g AUTO_MOUNT_SMB $false
# set -g AUTO_MOUNT_SMB_LIST '/home/$USER/smb/drv:\\127.0.0.1\drv'

set -g WSL_STATIC_IP $true
set -g WSL_JUMP_HOME $true