#!/usr/bin/zsh

function tmux_auto_session() {
    check_command tmux
    if [[ $? = $false ]]; then
        return
    fi
    tmux ls >/dev/null 2>&1
    if [[ $? = $true ]]; then
        tmux attach -t 0
    else
        tmux new-session
    fi
}
