export PROMPT_COMMAND=prompt_command

prompt_command() {
    local EXIT="$?"
    # Colours
    local NC="\033[0m"; local cyan="\033[38;5;6m"; local lime='\033[38;5;118m'; local green='\033[38;5;2m'; local red='\033[38;5;1m'; local purplish='\033[38;5;12m'
    # Choose colour for ret code
    if [[ $EXIT != 0 ]]; then local ret_color=$red; else local ret_color=$cyan; fi
    ### VOptional variables to use in PS1
    # local USED_SHELL=$(ps -o comm= -p $$ | rev | cut -d "/" -f1 | rev)
    # local username_and_machine="$USER@$(echo $HOSTNAME | cut -d "." -f1)"
    # Define PS1
    PS1="\[$cyan\][\[$ret_color\]${EXIT}\[$cyan\]]\[$cyan\] \[$purplish\]($(get_cur_time))\[$cyan\]$(parse_git_branch) \[$lime\]\w\[$NC\]$"
}

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

get_cur_time() {
    date +"%T"
}