lsp-filetype '(rust|toml|typst)' %{
  hook buffer BufWritePre .* lsp-formatting-sync
}

lsp-filetype markdown %{
  lsp-servers rumdl
  hook buffer BufWritePre .* lsp-formatting-sync
}

lsp-filetype python %{
  lsp-servers basedpyright ruff
  hook buffer BufWritePre .* lsp-formatting-sync
}
