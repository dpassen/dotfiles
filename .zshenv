typeset -U path
path+=(
    /usr/local/sbin
    ~/.bin
)

export EDITOR="${EDITOR:-mg}"
export VISUAL="${VISUAL:-mg}"
export SKIM_DEFAULT_COMMAND='rg --files'
export BAT_THEME=ansi
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
