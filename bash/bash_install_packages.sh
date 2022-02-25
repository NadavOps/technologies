#!/bin/bash
logging_enabled() {
    if [[ $(type -t bash_logging) == function ]]; then
        return 0
    else
        echo "\"bash_logging\" function was not found. export the function and re-try" >&2
        return 1 ## CHANGE to exit 1
    fi
}

main() {
    logging_enabled
    local os_type
    os_type=$(uname | sed 's/[[:alnum:]]/\L&/g')
    if [[ $os_type == *linux* ]]; then
        bash_logging "we in linux"
    elif [[ $os_type == *darwin* ]]; then
        bash_logging "we in mac"
    else
        bash_logging "what is this OS? (os_type is $os_type)" ERROR
    fi
}

main