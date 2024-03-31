#!/usr/bin/fish

if _equal AUTO_MOUNT_SMB $true
	exit 0
end

if test (count $AUTO_MOUNT_SMB_LIST) -le 0
	exit 0
end

for smb_item_str in $AUTO_MOUNT_SMB_LIST
	set smb_item (string split ":" $smb_item_str)
	_mount_smb $smb_item[1] $smb_item[2]
end
