hook global BufSetOption filetype=rust %{
  hook buffer BufWritePre .* lsp-formatting-sync
}

hook global WinSetOption filetype=rust %{
  lsp-enable-window
}
