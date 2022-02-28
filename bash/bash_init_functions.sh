#!/bin/bash
                    # local_path---remote_git_path
ESSENTIAL_FUNCTIONS=( "bash_logging.sh---https://raw.githubusercontent.com/NadavOps/technologies/main/bash/bash_logging.sh" )

functions_counter=0
for item in "${ESSENTIAL_FUNCTIONS[@]}" ; do
    function_file_path=$(echo "$item" | awk -F "---" '{print $1}')
    function_git_url=$(echo "$item" | awk -F "---" '{print $2}')
    if [[ -f $function_file_path ]]; then
        set -a
        source $function_file_path
        set +a
    else
        echo "WARN: \"$function_file_path\" was not found. Trying to export from git: $function_git_url"
        set -a
        source /dev/stdin <<< "$(curl -s --insecure $function_git_url)"
        set +a
    fi

    functions_amount=$(declare -F | wc -l)

    if [[ $functions_amount -le $functions_counter ]]; then
        echo """ERROR: Something went wrong. functions were not exported from: \"$function_file_path\".
       Managed to export $functions_amount function/s overall.
       Terminating.""" >&2
    exit 1
    fi

    functions_counter=$(( ++$functions_amount ))
done