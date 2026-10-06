declare-user-mode forgelink
map global user u ':enter-user-mode forgelink<ret>' -docstring "forgelink"
map global forgelink c ':forgelink copy<ret>' -docstring "copy link"
map global forgelink o ':forgelink open<ret>' -docstring "open link"

define-command forgelink -params 1 -hidden %{
  echo %sh{
    anchor=${kak_selection_desc%%.*}
    cursor=${kak_selection_desc#*,}
    cursor=${cursor%%.*}
    if [ "$anchor" -gt "$cursor" ]; then
      start=$cursor end=$anchor
    else
      start=$anchor end=$cursor
    fi
    forgelink "$1" "$kak_buffile:$start-$end" 2>&1
  }
}
