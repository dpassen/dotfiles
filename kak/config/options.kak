colorscheme alabaster-dark

set-option global autocomplete prompt
set-option global autoreload true
set-option global grepcmd 'rg --smart-case --vimgrep --sort path'
set-option global indentwidth 2
set-option global startup_info_version 20260521
set-option global tabstop 2
set-option global ui_options terminal_assistant=none terminal_set_title=false terminal_synchronized=true
set-option global windowing_placement vertical

add-highlighter global/ number-lines -separator '  ' -min-digits 1 -hlcursor
add-highlighter global/ show-matching
add-highlighter global/highlight-todos regex "%opt{comment_line}[ \t]*\b(TODO|FIXME|MAYBE):?\b" 1:default+b@comment

hook global BufNewFile .* editorconfig-load
hook global BufOpenFile .* editorconfig-load

define-command find -docstring "find files" %{
  prompt 'find: ' -shell-script-candidates %{ fd -tf } -menu %{
    edit %val{text}
  }
}

define-command find-down -docstring "find file, opening result below the current pane" %{
  set-option local windowing_placement vertical
  new execute-keys :find<ret>
}

define-command find-right -docstring "find file, opening result to the right of the current pane" %{
  set-option local windowing_placement horizontal
  new execute-keys :find<ret>
}

declare-user-mode find
map global user f ': enter-user-mode find<ret>' -docstring "find"
map global find f ':find<ret>' -docstring "find file"
map global find s ': find-down<ret>' -docstring "find file (down)"
map global find v ': find-right<ret>' -docstring "find file (right)"

map global user / ":grep<space>" -docstring "grep project directory"
