lsp-filetype '(rust|toml|typst)' %{
  hook buffer BufWritePre .* lsp-formatting-sync
}

lsp-filetype go %{
  hook buffer BufWritePre .* %{
    try %{ lsp-code-actions-sync source.organizeImports }
    lsp-formatting-sync
  }
}

lsp-filetype '(javascript|typescript)' %{
  lsp-servers vtsls oxlint-language-server
  set-option buffer formatcmd "prettier --stdin-filepath '%val{buffile}'"
  hook buffer BufWritePre .* format-buffer
}

lsp-filetype justfile %{
  lsp-servers just-lsp
}

lsp-filetype markdown %{
  lsp-servers rumdl
  hook buffer BufWritePre .* lsp-formatting-sync
}

lsp-filetype php %{
  lsp-servers phpantom
  hook buffer BufWritePre .* lsp-formatting-sync
}

lsp-filetype python %{
  lsp-servers basedpyright ruff
  hook buffer BufWritePre .* lsp-formatting-sync
}

lsp-filetype yaml
