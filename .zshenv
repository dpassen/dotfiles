# shellcheck disable=all

typeset -U path
path+=(
    /opt/homebrew/bin
    /opt/homebrew/sbin
    ~/.bin
)

export EDITOR="${EDITOR:-mg}"
export SKIM_DEFAULT_COMMAND='rg --files'
export BAT_THEME=ansi
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
