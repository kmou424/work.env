#!/usr/bin/zsh

# Custom Hack: for MyDockerFinder on Windows(WSL)
if [[ "$PWD" = *"steamapps/common/MyDockFinder" ]]; then
    cd $HOME
fi

# Custom Hack: for Windows Terminal on Startup
if [[ "$PWD" = *"Windows/System32" ]]; then
    cd $HOME
fi
