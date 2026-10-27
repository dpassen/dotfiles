evaluate-commands %sh{ hop-kak --init }

map global user w ':hop-words<ret>' -docstring "hop to word"

define-command hop-words -hidden %{
  execute-keys 'gtGbxs\w+<ret>'
  evaluate-commands -no-hooks -- %sh{
    hop-kak --keyset 'fjdkslaghrueiwoqptyvmcxznb' --sels "$kak_selections_desc"
  }
}
