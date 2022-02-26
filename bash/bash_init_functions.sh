#!/bin/bash
                    # function_name---local_path---remote_git_path
ESSENTIAL_FUNCTIONS=( "bash_logging---bash_logging.sh---https://raw.githubusercontent.com/NadavOps/technologies/main/bash/bash_logging.sh" )

for item in "${ESSENTIAL_FUNCTIONS[@]}" ; do
    function_name=$(echo "$item" | awk -F "---" '{print $1}')
    function_file_path=$(echo "$item" | awk -F "---" '{print $2}')
    function_git_url=$(echo "$item" | awk -F "---" '{print $3}')
    if [[ -f $function_file_path ]]; then
        source $function_file_path
        export -f $function_name
    else
        source /dev/stdin <<< "$(curl --insecure $function_git_url)"
        export -f $function_name
    fi

    if [[ $(type -t $function_name) == function ]]; then
        continue
    else
        echo "\"$function_name\" function was not found. export the function and re-try" >&2
        exit 1
    fi
done