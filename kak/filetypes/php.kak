hook global BufSetOption filetype=php %{
  lsp-servers phpantom
  hook buffer BufWritePre .* lsp-formatting-sync
}

hook global WinSetOption filetype=php %{
  lsp-enable-window
}
