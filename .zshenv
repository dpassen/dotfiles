# shellcheck disable=all

typeset -U -g PATH path

export EDITOR="${EDITOR:-mg}"
export SKIM_DEFAULT_COMMAND='rg --files'
export BAT_THEME=ansi
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
