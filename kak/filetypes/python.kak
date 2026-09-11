hook global WinSetOption filetype=python %{
  lsp-servers basedpyright ruff
  lsp-enable-window
  hook window BufWritePre .* lsp-formatting-sync
}
