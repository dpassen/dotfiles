path=(
    /opt/homebrew/bin
    /opt/homebrew/sbin
    $path
)

fpath=(
    /opt/homebrew/share/zsh/site-functions
    $fpath
)

alias ls='ls --color=auto'

emacs() {
    command emacs "$@" &!
}

setopt interactivecomments
setopt no_auto_remove_slash

autoload -Uz compinit
compinit

eval "$(atuin init zsh)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"
