#!/usr/bin/zsh

# Custom Hack: for MyDockerFinder on Windows(WSL)
if [[ "$PWD" = *"steamapps/common/MyDockFinder" ]]; then
    cd $HOME
fi
