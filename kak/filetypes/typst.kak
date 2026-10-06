hook global BufSetOption filetype=typst %{
  hook buffer BufWritePre .* lsp-formatting-sync
}

hook global WinSetOption filetype=typst %{
  lsp-enable-window
}
