#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Backup
PATH_BAK="${PATH}"

# For list
alias ls='ls --color=auto'
alias lls='ls -ls --color=auto'
alias llsa='ls -lsa --color=auto'

# For pacman
alias pacclean='sudo pacman -Scc'
alias pacupgrade='sudo pacman -Syyu'
alias pacman='sudo pacman'
alias pacautoremove='pacman -Rs $(pacman -Qdtq)'

# Git
alias gpick='git cherry-pick'

# Useful short name for some programs
alias cls='clear'
alias df='df -h'
alias hx='helix'
alias supxc='sudo proxychains'
alias pxc='proxychains'
alias python='python3'

alias linklib='sudo ldconfig /usr/local/lib'

# For tmux
alias tma='tmux_auto_session'

# Global constants
true=0
false=1

function load_script() {
    if [[ -f "$1" ]]; then
        chmod +x "$1"
        . "$1"
    else
        # If forcing load
        if [[ $2 = $false ]]; then
            echo "loading script: $1 failed!"
            return $false
        fi
    fi
}

# Prepare logging
load_script ~/.zshrc.d/logging.sh 1
if [[ $? = $false ]]; then
    return
fi

# Prepare utils
load_script ~/.zshrc.d/utils.sh 1
if [[ $? = $false ]]; then
    return
fi

# python userspace bin
path_append "$HOME/.local/bin"

PATH_BAK=$PATH

# Execute other scripts
# load_script ~/.zshrc.d/mount_smb.sh

load_script ~/.zshrc.d/proxy.sh

load_script ~/.zshrc.d/network.sh

load_script ~/.zshrc.d/tmux.sh

load_script ~/.zshrc.d/hack.sh

# For WSL
if [[ -n "$WSL_DISTRO_NAME" ]]; then
    load_script ~/.zshrc.d/wsl/static_ip.sh
fi
