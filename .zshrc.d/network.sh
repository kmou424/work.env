#!/usr/bin/zsh

function add_wlanap() {
    if [ -z $1 ]; then
        echo "error: Network Interface name can not be empty"
        return 1
    fi
    ip a show $1 > /dev/null 2>&1
    if [ $? = 1 ]; then
        echo "error: Network Interface: \"$1\" is not found"
        return 1
    fi
    iw > /dev/null 2>&1
    if [ $? != 0 ]; then
        echo "error: Package: \"iw\" is not installed"
        return 1
    fi
    requestSudo
    if [ $? != 0 ]; then
        echo "error: requestSudo: Can not continue because request root permission failed"
        return 1
    fi
    sudo iw dev $1 interface add wlanap type __ap
    if [ $? = 0 ]; then
        echo "Network Interface: \"wlanap\" was created"
    fi
}

function del_wlanap() {
    ip a show wlanap > /dev/null 2>&1
    if [ $? = 1 ]; then
        echo "error: Network Interface: \"wlanap\" was never created, use \"create_wlanap\" to create a ap network interface"
        return 1
    fi
    iw > /dev/null 2>&1
    if [ $? != 0 ]; then
        echo "error: Package: \"iw\" is not installed"
        return 1
    fi
    requestSudo
    if [ $? != 0 ]; then
        echo "error: requestSudo: Can not continue because request root permission failed"
        return 1
    fi
    sudo iw dev wlanap del
    if [ $? = 0 ]; then
        echo "Network Interface: \"wlanap\" was deleted"
    fi
}
