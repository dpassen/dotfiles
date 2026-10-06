map global user y ':copy-to-osc<ret>' -docstring "copy selection"

define-command copy-to-osc -hidden %{
  nop %sh{
    tty=$(ps -p "$kak_client_pid" -o tty= | tr -d ' ')
    [ -w "/dev/$tty" ] || exit 0
    encoded=$(printf '%s' "$kak_selection" | base64 | tr -d '\n')
    printf '\033]52;c;%s\033\\' "$encoded" > "/dev/$tty"
  }
}
