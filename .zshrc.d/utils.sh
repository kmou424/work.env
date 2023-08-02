#!/usr/bin/zsh

function request_sudo() {
    LABEL="request_sudo"
    if [[ $1 != $false ]]; then
        LOG_INFO $LABEL "requesting root permission"
    fi
    sudo echo "" >/dev/null 2>&1
    if [[ $? = $true ]]; then
        return $true
    else
        LOG_ERROR $LABEL "failed!"
        return $false
    fi
}

# Github proxy
ghSSHUrl="git@git.zhlh6.cn"

function GHProxy() {
    echo "https://ghproxy.com/${1}"
}

function GHSSH() {
    LABEL="GHSSH"
    if [[ "$1" = "add" ]]; then
        if [[ -n "$2" ]] && [[ -n "$3" ]]; then
            git remote add ssh "${ghSSHUrl}:$2/$3.git"
        else
            LOG_ERROR $LABEL "Please use give github username and name of repository"
        fi
    elif [[ "$1" = "del" ]]; then
        if [[ -n "$2" ]]; then
            git remote rm ssh
        fi
    else
        echo "Add"
    fi
}

# SMB utils
function mount_smb() {
    # $1 is mountpoint
    # $2 is target
    if [[ ! -d $1 ]]; then
        mkdir -p $1
    fi
    mountpoint ${1} &>/dev/null
    if [[ $? != $true ]]; then
        sudo mount -t drvfs ${2} ${1}
    fi
}

# PATH utils
function path_reset() {
    export PATH="${PATH_BAK}"
}

function path_append() {
    if [[ -n "$1" ]]; then
        APPEND=""
        if [[ "$1" = "pwd" ]]; then
            APPEND="${PWD}"
        elif [[ -d "$1" ]]; then
            APPEND="$1"
        fi
        if [[ -n "$2" ]] && [[ "$2" = "--back" ]]; then
            export PATH="${PATH}:${APPEND}"
        else
            export PATH="${APPEND}:${PATH}"
        fi
    fi
}

# Command Utils
function check_command() {
    LABEL="check_command"
    command -v $1 >/dev/null 2>&1
    if [[ $? = $false ]]; then
        LOG_ERROR $LABEL "$1 is not installed. Please install $1 and try again."
        return $false
    fi
}
