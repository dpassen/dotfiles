colorscheme modus-operandi-tinted

set-option global autoreload true
set-option global grepcmd 'rg --smart-case --vimgrep --sort path'
set-option global indentwidth 2
set-option global startup_info_version 20260521
set-option global tabstop 4
set-option global ui_options terminal_assistant=none terminal_set_title=false

add-highlighter global/ number-lines -separator '  ' -min-digits 1 -hlcursor
add-highlighter global/ show-matching
add-highlighter global/highlight-todos regex \b(TODO|NOTE)\b 0:+rb

hook global BufNewFile .* editorconfig-load
hook global BufOpenFile .* editorconfig-load

define-command find -docstring "find files" %{
  prompt 'find: ' -shell-script-candidates %{ fd -tf } -menu %{
    edit %val{text}
  }
}

map global user f ":find<ret>" -docstring "find file"
map global user / ":grep<space>" -docstring "grep project directory"
