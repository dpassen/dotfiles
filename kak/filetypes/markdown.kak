hook global BufSetOption filetype=markdown %{
  lsp-servers rumdl
  hook buffer BufWritePre .* lsp-formatting-sync
}

hook global WinSetOption filetype=markdown %{
  lsp-enable-window
}
