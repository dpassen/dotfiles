path=(
    ~/.bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    $path
)

fpath=(
    /opt/homebrew/share/zsh/site-functions
    $fpath
)

alias ls='ls --color=auto'
alias mg='mg -n'
alias tree='tree --gitignore -I ".git"'
alias view='mg -R'

emacs() {
    /usr/bin/env emacs "$@" &!
}

jj() {
    cd $(/usr/bin/env jj "$@")
}

nfocat() {
    iconv -f cp437 "$@"
}

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt inc_append_history
setopt interactivecomments
setopt no_auto_remove_slash
setopt share_history

autoload -Uz compinit
compinit

eval "$(fasder --init auto)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"
