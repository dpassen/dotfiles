eval %sh{kak-lsp}
map global user l ':enter-user-mode lsp<ret>' -docstring "LSP mode"

set-option global lsp_code_lens_sign ''
set-option global lsp_hover_anchor true
set-option global lsp_snippet_support false

set-option global modelinefmt %sh{
  printf '%s' '{DiagnosticErrorCount}%sh{[ "$kak_opt_lsp_diagnostic_error_count" -gt 0 ] && printf "●"}{StatusLine}%sh{[ "$kak_opt_lsp_diagnostic_error_count" -gt 0 ] && printf " %s " "$kak_opt_lsp_diagnostic_error_count"}'
  printf '%s' '{DiagnosticWarningCount}%sh{[ "$kak_opt_lsp_diagnostic_warning_count" -gt 0 ] && printf "●"}{StatusLine}%sh{[ "$kak_opt_lsp_diagnostic_warning_count" -gt 0 ] && printf " %s " "$kak_opt_lsp_diagnostic_warning_count"}'
  printf '%s' '{StatusLine}%val{bufname} {' '{context_info}} {' '{mode_info}}'
}

define-command -params 1.. lsp-servers -docstring 'lsp-servers <name>...: set buffer lsp_servers by concatenating lsp/<name>.toml files' %{
  set-option buffer lsp_servers %sh{
    for name; do
      cat "$kak_config/lsp/$name.toml" || exit 1
    done
  }
}

define-command -params 1..2 lsp-filetype -docstring 'lsp-filetype <filetype-regex> [setup]: enable LSP and run setup commands for matching filetypes' %{
  hook global BufSetOption "filetype=%arg{1}" "%arg{2}"
  hook global WinSetOption "filetype=%arg{1}" %{
    lsp-enable-window
    lsp-diagnostic-lines-disable window
  }
}
