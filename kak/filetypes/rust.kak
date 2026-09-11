hook global WinSetOption filetype=rust %{
    lsp-enable-window
    hook window BufWritePre .* lsp-formatting-sync
}
