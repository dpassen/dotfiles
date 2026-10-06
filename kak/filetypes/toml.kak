hook global BufSetOption filetype=toml %{
  hook buffer BufWritePre .* lsp-formatting-sync
}

hook global WinSetOption filetype=toml %{
  lsp-enable-window
}
