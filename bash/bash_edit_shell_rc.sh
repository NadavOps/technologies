#!/bin/bash
update_rc_file() {
    local current_rc_file archive_directory input_shell_rc_file
    current_rc_file="$1"
    archive_directory="$2"
    input_shell_rc_file="$3"
    touch "$current_rc_file" && bash_logging WARN "Editing \"$current_rc_file\". (os_type: \"$os_type\")"
    archive_file "$current_rc_file" "$archive_directory" || return 1
    cp "$input_shell_rc_file" "$current_rc_file" && \
    bash_logging INFO "Copied \"$input_shell_rc_file\" into the running rc file: \"$current_rc_file\"" || \
    bash_logging ERROR "Failed to copy \"$input_shell_rc_file\" into the running rc file: \"$current_rc_file\""
}

bash_edit_shell_rc() {
    set -e
    verify_imported_functions_exists "bash_logging" "verify_array" "archive_file"
    set +e
    bash_logging DEBUG "Running from $0"
    local input_shell_rc_file input_scripts_directories os_type archive_directory current_rc_file
    input_shell_rc_file="$1"
    verify_file "$input_shell_rc_file" || return 1
    shift 1
    input_scripts_directories=("$@")
    archive_directory="$HOME/archive"
    mkdir -p "$archive_directory"
    os_type=$(uname | tr "[[:upper:]]" "[[:lower:]]")
    if [[ $os_type == *linux* || $os_type == *darwin* ]]; then
        current_rc_file="$HOME/.bashrc"
        update_rc_file "$current_rc_file" "$archive_directory" "$input_shell_rc_file" || exit 1
    fi
    if [[ $os_type == *darwin* ]]; then
        current_rc_file="$HOME/.zshrc"
        update_rc_file "$current_rc_file" "$archive_directory" "$input_shell_rc_file" || exit 1
    fi
    if [[ $os_type != *linux* && $os_type != *darwin* ]]; then
        bash_logging ERROR "what is this OS? (os_type is $os_type)"
        exit 1
    fi
}

bash_edit_shell_rc "$1"
## add bash_prompt_source