map global user / ':grep<space>' -docstring "grep project directory"

declare-user-mode find
map global user f ':enter-user-mode find<ret>' -docstring "find"
map global find . ':enter-user-mode find-directory<ret>' -docstring "find in current directory"
map global find f ':find<ret>' -docstring "find file"
map global find s ':find-down find<ret>' -docstring "find file (down)"
map global find v ':find-right find<ret>' -docstring "find file (right)"

declare-user-mode find-directory
map global find-directory f ':find-sibling<ret>' -docstring "find file"
map global find-directory s ':find-down find-sibling<ret>' -docstring "find file (down)"
map global find-directory v ':find-right find-sibling<ret>' -docstring "find file (right)"

define-command find -docstring "find files" %{
  prompt 'find: ' -shell-script-candidates %{ fd --type file --hidden } -menu %{
    edit -existing %val{text}
  }
}

define-command find-sibling -docstring "find sibling files" %{
  prompt 'find: ' -shell-script-candidates %{
    fd --type file --hidden --no-ignore --max-depth 1 --base-directory "${kak_buffile%/*}"
  } -menu %{
    edit -existing %sh{ printf '%s/%s\n' "${kak_buffile%/*}" "$kak_text" }
  }
}

define-command -params 1 find-down -hidden %{
  set-option local windowing_placement horizontal
  new %arg{1}
}

define-command -params 1 find-right -hidden %{
  set-option local windowing_placement vertical
  new %arg{1}
}
