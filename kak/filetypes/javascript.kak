hook global BufSetOption filetype=(javascript|typescript) %{
  lsp-servers vtsls oxlint-language-server
  set-option buffer formatcmd 'prettier --parser typescript --stdin-filepath %val{buffile}'
  hook buffer BufWritePre .* format-buffer
}

hook global WinSetOption filetype=(javascript|typescript) %{
  lsp-enable-window
}
