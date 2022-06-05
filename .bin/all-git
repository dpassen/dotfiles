#!/usr/bin/env sh

set -o nounset
set -o errexit

fd -td -d1 | sort -f | while read -r dir; do
    if [ -d "$dir/.git" ]; then
        basename "${dir%/}"
        (cd "$dir" && git "$@")
        echo
    fi
done
