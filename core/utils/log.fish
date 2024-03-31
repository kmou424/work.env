function _log_base -a level label msg
  set level_color normal
  switch $level
    case "DEBUG"
      set level_color green
    case "INFO"
      set level_color normal
    case "WARN"
      set level_color yellow
    case "ERROR"
      set level_color red
  end

  echo -n "[workenv] ["
  set_color $level_color; echo -n $level; set_color normal; echo -n "] "
  set_color brblue; echo -n $label
  set_color normal; echo -n ": "
  echo $msg; set_color normal
end

function _log_debug -a label msg
  _log_base "DEBUG" $label $msg
end

function _log_info -a label msg
  _log_base "INFO" $label $msg
end

function _log_warn -a label msg
  _log_base "WARN" $label $msg
end

function _log_error -a label msg
  _log_base "ERROR" $label $msg
end