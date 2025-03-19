typeset -U -g PATH path
typeset -U -g FPATH fpath

export EDITOR="${EDITOR:-hx}"
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export SKIM_DEFAULT_COMMAND='rg --files'
