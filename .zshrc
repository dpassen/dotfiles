alias tmux='tmux -2'

tmux-select() {
    tmux attach -t $(tmux ls "-F#{session_name}" 2> /dev/null | sk)
}

alias mg='mg -n'
alias view='mg -R'

edit() {
  eval "$EDITOR" "$@"
}

emacs() {
  /usr/bin/env emacs "$@" &!
}

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
setopt share_history

setopt interactivecomments
setopt no_auto_remove_slash

bindkey -e
bindkey '^R' history-incremental-search-backward
bindkey '^[[3~' delete-char

zstyle :compinstall filename "$HOME/.zshrc"
zstyle ':completion:*' menu select

autoload -Uz compinit
compinit

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:git*' formats " (%b)"
zstyle ':vcs_info:hg*' formats " (%b)"

precmd() {
  vcs_info
  print ""
}

setopt prompt_subst
NEWLINE=$'\n'
PROMPT='[%n@%m] %2d${vcs_info_msg_0_}${NEWLINE}$ '

if [ $ITERM_SESSION_ID ]; then
  iterm_tab_title() {
    echo -ne "\e]0;${PWD##*/}\a"
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd iterm_tab_title
fi

nfocat() {
  iconv -f cp437 "$@"
}

if [[ "$INSIDE_EMACS" = 'vterm' ]] \
    && [[ -n ${EMACS_VTERM_PATH} ]] \
    && [[ -f ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh ]]; then
	source ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh
fi
