export VOLTA_HOME="$HOME/.volta"

typeset -U path
path+=(
    /usr/local/sbin
    ~/.bin
    $VOLTA_HOME/bin
)

export EDITOR=mg
export SKIM_DEFAULT_COMMAND='rg --files'
export BAT_THEME=ansi
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
