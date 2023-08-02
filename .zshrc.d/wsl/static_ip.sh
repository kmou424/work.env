#!/usr/bin/zsh

check_command "ip"
if [[ $? != $true ]]; then
    return $false
fi

request_sudo $false
if [[ $? = $false ]]; then
    return $false
fi

sudo ip addr show eth0 | grep -s "172.18.18.128/24" >/dev/null
if [[ $? != $true ]]; then
    sudo ip addr add 172.18.18.128/24 broadcast 172.18.18.255 dev eth0 label eth0:1
fi
