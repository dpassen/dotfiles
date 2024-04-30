path=(
    ~/.bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    ${path}
)

eval "$(mise activate zsh)"

alias mg='mg -n'
alias tmux='tmux -2'
alias tree='tree --gitignore -I ".git"'
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

tmux-select() {
    tmux attach -t $(tmux ls "-F#{session_name}" 2> /dev/null | sk)
}

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt interactivecomments
setopt no_auto_remove_slash
setopt share_history

bindkey -e

zstyle :compinstall filename "$HOME/.zshrc"
zstyle ':completion:*' menu select

FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"

autoload -Uz compinit
compinit

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats " (%b)"

precmd() {
    vcs_info
    precmd() {
        vcs_info
        print ""
    }
}

setopt prompt_subst
NEWLINE=$'\n'
PROMPT='[%n@%m] %2d${vcs_info_msg_0_}${NEWLINE}$ '

if [[ "$INSIDE_EMACS" = 'vterm' ]] \
    && [[ -n ${EMACS_VTERM_PATH} ]] \
    && [[ -f ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh ]]; then
	source ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh
fi
