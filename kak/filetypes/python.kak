hook global BufSetOption filetype=python %{
  lsp-servers basedpyright ruff
  hook buffer BufWritePre .* lsp-formatting-sync
}

hook global WinSetOption filetype=python %{
  lsp-enable-window
}
