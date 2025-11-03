hook global BufSetOption filetype=go %{
  hook buffer BufWritePre .* %{
    try %{ lsp-code-actions-sync source.organizeImports } catch %{ nop }
    lsp-formatting-sync
  }
}

hook global WinSetOption filetype=go %{
  lsp-enable-window
}
