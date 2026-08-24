function fish_prompt
    if not contains -- --final-rendering $argv
        printf '%s ' (prompt_pwd)
    end
    echo -n '❯ '
end
