typeset -U -g PATH path
typeset -U -g FPATH fpath

export EDITOR="${EDITOR:-mg}"
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export SKIM_DEFAULT_COMMAND='rg --files'
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
