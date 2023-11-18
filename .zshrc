# shellcheck disable=all

path=(
    ~/.bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    ${path}
)

if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
    source "$HOME/.asdf/asdf.sh"
fi

if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc" ]]; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
fi

alias tmux='tmux -2'

tmux-select() {
    tmux attach -t $(tmux ls "-F#{session_name}" 2> /dev/null | sk)
}

alias mg='mg -n'
alias view='mg -R'

alias tree='tree --gitignore -I ".git"'

edit() {
  eval "$EDITOR" "$@"
}

emacs() {
  /usr/bin/env emacs "$@" &!
}

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt share_history

setopt interactivecomments
setopt no_auto_remove_slash

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

nfocat() {
  iconv -f cp437 "$@"
}

[ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
  source "$EAT_SHELL_INTEGRATION_DIR/zsh"
