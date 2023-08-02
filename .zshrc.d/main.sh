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
alias tma='tmuxAuto'

# External root (for personal build program)
export EXTERNAL_ROOT=~/external_root
export EXTERNAL_ROOT_BIN=$EXTERNAL_ROOT/bin
export EXTERNAL_ROOT_LIB=$EXTERNAL_ROOT/lib
export EXTRA_LD_LIBRARY_PATH=/usr/local/lib

# Make sure external root is available
if [ ! -d $EXTERNAL_ROOT_BIN ];then
    mkdir -p $EXTERNAL_ROOT_BIN
fi

if [ ! -d $EXTERNAL_ROOT_LIB ];then
    mkdir -p $EXTERNAL_ROOT_LIB
fi

function load_script() {
    if [ -f "$1" ];then
            chmod +x "$1"
            . "$1"
    else
        # If forcing load
        if [ $2 = 1 ];then
            echo "loading script: $1 failed!"
            return 1
        fi
    fi
}

# Prepare utils
load_script ~/.zshrc.d/utils.sh 1
if [ $? = 1 ];
then
    return
fi

# Add external root into PATH
if [ "$(echo $PATH | grep ${EXTERNAL_ROOT_BIN} 2> /dev/null)" = "" ];then
    pathcat $EXTERNAL_ROOT_BIN
fi

# Add user-build programs lib to ld library path
if [ "$(echo $LD_LIBRARY_PATH | grep ${EXTRA_LD_LIBRARY_PATH} 2> /dev/null)" = "" ];then
    if [ "${LD_LIBRARY_PATH}" = "" ];then
        export LD_LIBRARY_PATH="${EXTRA_LD_LIBRARY_PATH}"
    else
        export LD_LIBRARY_PATH="${EXTRA_LD_LIBRARY_PATH}:${LD_LIBRARY_PATH}"
    fi
fi

# Add external root user-build programs lib to ld library path
if [ "$(echo $LD_LIBRARY_PATH | grep ${EXTERNAL_ROOT_LIB} 2> /dev/null)" = "" ];then
    if [ "${LD_LIBRARY_PATH}" = "" ];then
        export LD_LIBRARY_PATH="${EXTERNAL_ROOT_LIB}"
    else
        export LD_LIBRARY_PATH="${EXTERNAL_ROOT_LIB}:${LD_LIBRARY_PATH}"
    fi
fi

# python userspace bin
pathcat "$HOME/.local/bin"

PATH_BAK=$PATH

# Execute other scripts
# load_script ~/.zshrc.d/mount_smb.sh

load_script ~/.zshrc.d/static_ip.sh

load_script ~/.zshrc.d/proxy.sh

load_script ~/.zshrc.d/network.sh

load_script ~/.zshrc.d/tmux.sh

load_script ~/.zshrc.d/hack.sh