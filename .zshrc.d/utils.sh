#!/usr/bin/zsh

function requestSudo() {
    echo "Try to request root permission..."
    sudo echo "" > /dev/null 2>&1
    if [ $? = 0 ]; then
        echo "Succeed!"
        return 0
    else
        echo "Failed!"
        return 1
    fi
}

# Github proxy
ghProxyUrl=""
ghSSHUrl="git@git.zhlh6.cn"

function getGhProxyUrl() {
    ghProxyUrl="https://ghproxy.com/${1}"
}

function wgetgh() {
    getGhProxyUrl $1
    wget "${ghProxyUrl}"
}

function ghclone() {
    getGhProxyUrl $1
    git clone "${ghProxyUrl}"
}

function ghssh() {
    if [ "$1" = "add" ];then
        if [ -n "$2" ] && [ -n "$3" ];then
            git remote add ssh "${ghSSHUrl}:$2/$3.git"
        else
            echo "Please use give github username and name of repository"
        fi
    elif [ "$1" = "del" ];then
        if [ -n "$2" ];then
            git remote rm ssh
        fi
    else
        echo "Add"
    fi
}

# Other utils
function checkDirContainName() {
    echo -n "Checking $2..."
    if [ -z "$(cd $1 && ls -d *$2* 2> /dev/null)" ];then
        echo "not found"
        return 0
    else
        echo "found"
        return 1
    fi
}

# SMB utils
function mount_smb() {
    # $1 is mountpoint
    # $2 is target
    if [ ! -d $1 ];then
        mkdir -p $1
    fi
    mountpoint ${1} &> /dev/null
    if [ $? -ne 0 ];then
            sudo mount -t drvfs ${2} ${1}
    fi
}

# PATH utils
function pathreset() {
    export PATH="${PATH_BAK}"
}

function pathcat() {
    if [ -n "$1" ];then
        APPEND=""
        if [ "$1" = "pwd" ];then
            APPEND="${PWD}"
        elif [ -d "$1" ];then
            APPEND="$1"
        fi
        if [ -n "$2" ] && [ "$2" = "--back" ];then
            export PATH="${PATH}:${APPEND}"
        else
            export PATH="${APPEND}:${PATH}"
        fi
    fi
}

# Command Utils
function checkCommand() {
    command -v $1 > /dev/null 2>&1
    if [ $? = 1 ]; then
        echo "$1 is not installed. Please install $1 and try again."
        return 1
    fi
}
