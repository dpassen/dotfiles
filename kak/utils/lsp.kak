eval %sh{kak-lsp --kakoune -s $kak_session}
map global user l ':enter-user-mode lsp<ret>' -docstring "LSP mode"

set-option global lsp_code_lens_sign ' '
set-option global lsp_diagnostic_line_error_sign ' '
set-option global lsp_diagnostic_line_warning_sign ' '
set-option global lsp_hover_anchor true
set-option global lsp_snippet_support false

set-option global modelinefmt %sh{
  printf '%s' '{DiagnosticErrorCount}%sh{[ "$kak_opt_lsp_diagnostic_error_count" -gt 0 ] && printf "●"}{StatusLine}%sh{[ "$kak_opt_lsp_diagnostic_error_count" -gt 0 ] && printf " %s " "$kak_opt_lsp_diagnostic_error_count"}'
  printf '%s' '{DiagnosticWarningCount}%sh{[ "$kak_opt_lsp_diagnostic_warning_count" -gt 0 ] && printf "●"}{StatusLine}%sh{[ "$kak_opt_lsp_diagnostic_warning_count" -gt 0 ] && printf " %s " "$kak_opt_lsp_diagnostic_warning_count"}'
  printf '%s' '{StatusLine}%val{bufname} {{context_info}} {{mode_info}}'
}

define-command -params 1.. lsp-servers -docstring 'lsp-servers <name>...: set buffer lsp_servers by concatenating utils/lsp/<name>.toml files' %{
  set-option buffer lsp_servers %sh{
    names="$@"
    set --
    for name in $names; do
      set -- "$@" "$kak_config/utils/lsp/$name.toml"
    done
    cat "$@"
  }
}
