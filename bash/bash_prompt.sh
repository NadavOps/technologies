prompt_command() {
    local EXIT="$?"
    local default="\033[0m"; local cyan="\033[38;5;6m"; local lime='\033[38;5;118m';
    local green='\033[38;5;2m'; local red='\033[38;5;1m'; local purplish='\033[38;5;12m'
    # Choose colour for exit status code
    if [[ $EXIT != 0 ]]; then local exit_color=$red; else local exit_color=$cyan; fi
    # Prompt Line
    PS1="${cyan}[${exit_color}$EXIT${cyan}] ${purplish}($(get_current_time)) ${lime}\w\n${cyan}$(parse_git_branch)${default}%"
}

parse_git_branch() {
    git rev-parse --git-dir &> /dev/null && echo "($(git rev-parse --abbrev-ref HEAD)) "
}

get_current_time() {
    date +"%T"
}

export PROMPT_COMMAND=prompt_command