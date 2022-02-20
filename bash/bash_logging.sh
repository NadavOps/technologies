#!/bin/bash
bash_logging() {
    local default_color msg_severity msg_severity_color msg_content msg_content_color
    default_color='\033[0m'
    msg_severity=$(echo "$1" | sed 's/[a-z]/\U&/g')
    case $msg_severity in
    DEBUG)
        msg_severity_color="\033[0;36m"
        msg_content_color="\033[1;36m"
        ;;
    INFO)
        msg_severity_color="\033[0;32m"
        msg_content_color="\033[1;32m"
        ;;
    WARN)
        msg_severity_color="\033[0;33m"
        msg_content_color="\033[1;33m"
        ;;
    ERROR)
        msg_severity_color="\033[0;31m"
        msg_content_color="\033[1;31m"
        ;;
    *)
        echo "Logging failed. Parameter #1: "$msg_severity" needs to be one of: \"${msg_severity_options[*]}\""
        return 1
        ;;
    esac
    msg_content="$2"
    printf "${msg_severity_color} $(date -u "+%d.%m.%Y %H:%M:%S") "$msg_severity": ${msg_content_color} "$msg_content" ${default_color}"
}