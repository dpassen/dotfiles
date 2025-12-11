if status is-interactive
    set fish_greeting

    set -q EDITOR; or set -gx EDITOR hx

    atuin init fish | source
    starship init fish | source
    zoxide init fish --cmd cd | source
end

set -q XDG_CACHE_HOME; or set -gx XDG_CACHE_HOME $HOME/.cache
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -gx XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -gx XDG_STATE_HOME $HOME/.local/state

set -gx JAVA_HOME $(/usr/libexec/java_home -v 21)

fish_add_path -a /opt/homebrew/bin /opt/homebrew/sbin
