function currentDirectory {
    # echo -ne "\030${PWD##*/}\007"
    echo -ne ${PWD##*/}
}

function iterm2_print_user_vars() {
      [[ "$(currentDirectory)" =~ .*"$USER".* ]] && iterm2_set_user_var currentDirectory "~" || iterm2_set_user_var currentDirectory "$(currentDirectory)"
}