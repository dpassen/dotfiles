hook global BufSetOption filetype=(css|html|javascript|json|typescript) %{
  set-option buffer formatcmd "prettier --stdin-filepath '%val{buffile}'"
  hook buffer BufWritePre .* format-buffer
}

lsp-filetype (ruby|yaml)

lsp-filetype (clojure|rust|toml|typst) %{
  hook buffer BufWritePre .* lsp-formatting-sync
}

lsp-filetype justfile %{
  lsp-servers just-lsp
}

lsp-filetype markdown %{
  lsp-servers rumdl
  hook buffer BufWritePre .* lsp-formatting-sync
}

lsp-filetype python %{
  lsp-servers basedpyright ruff
  hook buffer BufWritePre .* lsp-formatting-sync
}
