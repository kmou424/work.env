#!/usr/bin/zsh

PROXY_URL="http://127.0.0.1:7890"

alias setproxy="export HTTP_PROXY=$PROXY_URL; export HTTPS_PROXY=$PROXY_URL; export ALL_PROXY=$PROXY_URL; echo 'Set proxy successfully'"
alias unsetproxy="unset HTTP_PROXY; unset HTTPS_PROXY; unset ALL_PROXY; echo 'Unset proxy successfully'"
