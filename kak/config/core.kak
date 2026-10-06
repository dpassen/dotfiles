colorscheme catppuccin-mocha

set-option global autocomplete prompt
set-option global autoreload true
set-option global grepcmd 'rg --smart-case --vimgrep --sort path'
set-option global indentwidth 2
set-option global startup_info_version 20260521
set-option global tabstop 2
set-option global ui_options terminal_assistant=none terminal_set_title=false terminal_synchronized=true
set-option global windowing_placement horizontal

add-highlighter global/ number-lines -separator '  ' -min-digits 1 -hlcursor
add-highlighter global/ show-matching
add-highlighter global/highlight-todos regex "%opt{comment_line}[ \t]*\b(TODO|FIXME|MAYBE):?\b" 1:default+b@comment

hook global BufNewFile .* editorconfig-load
hook global BufOpenFile .* editorconfig-load
