#!/usr/bin/zsh

function add_wlanap() {
    LABEL="add_wlanap"

    check_command "iw"
    if [[ $? != $true ]]; then
        return $false
    fi
    check_command "ip"
    if [[ $? != $true ]]; then
        return $false
    fi

    if [[ -z $1 ]]; then
        LOG_ERROR $LABEL "network Interface name can not be empty"
        return $false
    fi
    ip a show $1 >/dev/null 2>&1
    if [[ $? = $false ]]; then
        LOG_ERROR $LABEL "network Interface \"$1\" is not found"
        return $false
    fi
    request_sudo
    if [[ $? = $false ]]; then
        return $false
    fi
    sudo iw dev $1 interface add wlanap type __ap
    if [[ $? = $true ]]; then
        LOG_INFO $LABEL "network interface \"wlanap\" was created"
    fi
}

function del_wlanap() {
    LABEL="del_wlanap"

    check_command "iw"
    if [[ $? != $true ]]; then
        return $false
    fi
    check_command "ip"
    if [[ $? != $true ]]; then
        return $false
    fi

    ip a show wlanap >/dev/null 2>&1
    if [[ $? = $false ]]; then
        LOG_ERROR $LABEL "network interface \"wlanap\" was never created, use \"create_wlanap\" to create a ap network interface"
        return $false
    fi
    request_sudo
    if [[ $? = $false ]]; then
        return $false
    fi
    sudo iw dev wlanap del
    if [[ $? = $true ]]; then
        LOG_INFO $LABEL "network interface \"wlanap\" was deleted"
    fi
}
