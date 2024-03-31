#!/usr/bin/fish

alias setproxy="set -gx HTTP_PROXY $PROXY_URL; set -gx HTTPS_PROXY $PROXY_URL; set -gx ALL_PROXY $PROXY_URL; _log_info '' 'set proxy successfully'"
alias unsetproxy="set -gu HTTP_PROXY; set -gu HTTPS_PROXY; set -gu ALL_PROXY; _log_info '' 'unset proxy successfully'"
