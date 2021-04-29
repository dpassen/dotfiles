#!/usr/bin/env zsh

set -o nounset
set -o errexit

declare -A dotfiles

dotfiles=(
    ["bin/all-git.sh"]="$HOME/.bin/all-git"
    ["clojure/deps.edn"]="$HOME/.clojure/deps.edn"
    ["emacs.d/early-init.el"]="$HOME/.emacs.d/early-init.el"
    ["emacs.d/init.el"]="$HOME/.emacs.d/init.el"
    # ["gitconfig"]="$HOME/.gitconfig"
    ["lein/profiles.clj"]="$HOME/.lein/profiles.clj"
    ["tmux.conf"]="$HOME/.tmux.conf"
    ["vimrc"]="$HOME/.vimrc"
    ["zprint.edn"]="$HOME/.zprint.edn"
    # ["zshenv"]="$HOME/.zshenv"
    # ["zshrc"]="$HOME/.zshrc"
)

function ensure_destination_exists {
    local dest="$1"
    if [[ $dest != "$HOME" ]]; then
        echo "  Creating destination directory: $dest"
        mkdir -p "$dest"
    fi
}

function link_dotfiles {
    for source destination in ${(kv)dotfiles}; do
        echo "Linking $source to $destination"

        local dir=${destination:h}
        ensure_destination_exists "$dir"

        ln -fs "${source:a}" "$destination"
    done
}

link_dotfiles
