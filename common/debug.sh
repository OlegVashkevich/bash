function _debug_for_bash() {
    _bash_debug_last_retcode="$?"

    # Skip prompt when starting script itself
    # shellcheck disable=SC2016
    if [ "$BASH_COMMAND" == 'source "$_bash_debug_script" "$@"' ]; then
        return
    fi
    # -r Do not interpret backslash escaped characters
    # -e Use readline in interactive shell
    # -p PROMPT
    while read -r -e -p "$(echo -e "\e[0;31m${_bash_debug_last_retcode//0/$(echo -e "\e[0;32m#\e[0m")}\e[0m \e[1m$BASH_COMMAND\e[0m") " _bash_debug_command; do
        if [ -n "$_bash_debug_command" ]; then
            eval "$_bash_debug_command";
        else
            break;
        fi;
    done
}

trap '_debug_for_bash' DEBUG