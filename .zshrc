path=(
    ~/.bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    ${path}
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

setopt interactivecomments
setopt no_auto_remove_slash
setopt share_history

zstyle :compinstall filename "$HOME/.zshrc"
zstyle ':completion:*' menu select

FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"

autoload -Uz compinit
compinit

eval "$(mise activate zsh)"
eval "$(starship init zsh)"

if [[ -f "$EAT_SHELL_INTEGRATION_DIR/zsh" ]]; then
    source "$EAT_SHELL_INTEGRATION_DIR/zsh"
fi
