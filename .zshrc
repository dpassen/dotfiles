path=(
    ~/.bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    ${path}
)

fpath=(
    /opt/homebrew/share/zsh/site-functions
    ${fpath}
)

alias mg='mg -n'
alias ls='eza --group-directories-first --sort=Name'
alias tree='ls -T --git-ignore --no-quotes'
alias view='mg -R'

edit() {
    eval "$EDITOR" "$@"
}

emacs() {
    /usr/bin/env emacs "$@" &!
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

eval "$(mise activate zsh)"
eval "$(starship init zsh)"

if [[ -f "$EAT_SHELL_INTEGRATION_DIR/zsh" ]]; then
    source "$EAT_SHELL_INTEGRATION_DIR/zsh"
fi
