map global user / ':grep<space>' -docstring "grep project directory"

declare-user-mode find
map global user f ':enter-user-mode find<ret>' -docstring "find"
map global find f ':find<ret>' -docstring "find file"
map global find s ':find-down<ret>' -docstring "find file (down)"
map global find v ':find-right<ret>' -docstring "find file (right)"

define-command find -docstring "find files" %{
  prompt 'find: ' -shell-script-candidates %{ fd -tf } -menu %{
    edit -existing %val{text}
  }
}

define-command find-down -hidden %{
  set-option local windowing_placement horizontal
  new execute-keys :find<ret>
}

define-command find-right -hidden %{
  set-option local windowing_placement vertical
  new execute-keys :find<ret>
}
