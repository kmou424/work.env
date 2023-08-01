#!/usr/bin/zsh

function tmuxAuto() {
    checkCommand tmux
    tmux ls > /dev/null 2>&1
    if [ $? = 0 ]; then
        tmux attach -t 0
    else
        tmux new-session
    fi
}
