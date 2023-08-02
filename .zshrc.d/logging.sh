function LOG_BASE() {
    echo "work.dir => [$1] $2: $3 "
}

function LOG_DEBUG() {
    LOG_BASE "DEBUG" $1 $2
}

function LOG_INFO() {
    LOG_BASE "INFO" $1 $2
}

function LOG_WARN() {
    LOG_BASE "WARN" $1 $2
}

function LOG_ERROR() {
    LOG_BASE "ERROR" $1 $2
}

function LOG_FATAL() {
    LOG_BASE "FATAL" $1 $2
}
