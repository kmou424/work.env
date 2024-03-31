#!/usr/bin/fish

set _backup_path ""

function _path_bak
  set _backup_path $PATH
end

function _path_append -a path_seg
  set --path PATH "$PATH:$path_seg"
end

function _path_restore
  set --path PATH $_backup_path
end
