#!/bin/bash
                    # local_path---remote_git_path
ESSENTIAL_FUNCTIONS=(
"bash_logging.sh---https://raw.githubusercontent.com/NadavOps/technologies/main/bash/bash_logging.sh"
"bash_general_functions.sh---https://raw.githubusercontent.com/NadavOps/technologies/main/bash/bash_general_functions.sh"
"bash_install_packages.sh---https://raw.githubusercontent.com/NadavOps/technologies/main/bash/bash_install_packages.sh"
)

functions_counter=0
for item in "${ESSENTIAL_FUNCTIONS[@]}" ; do
    functions_file_path=$(echo "$item" | awk -F "---" '{print $1}')
    functions_git_url=$(echo "$item" | awk -F "---" '{print $2}')
    if [[ -f $functions_file_path ]]; then
        set -a
        source $functions_file_path
        set +a
    else
        echo "WARN: \"$functions_file_path\" was not found. Trying to export from git: $functions_git_url"
        set -a
        source /dev/stdin <<< "$(curl -s --insecure $functions_git_url)"
        set +a
    fi

    functions_amount=$(declare -F | wc -l)

    if [[ $functions_amount -le $functions_counter ]]; then
        echo """ERROR: Something went wrong. functions were not exported from: \"$functions_file_path\".
       Managed to export $functions_amount function/s overall.
       Terminating.""" >&2
    exit 1
    fi

    functions_counter=$(( $functions_counter+$functions_amount ))
done