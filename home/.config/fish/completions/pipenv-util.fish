# options
complete -f -c pipenv-util -s h -l help -d "print help"

# subcommands
complete -f -c pipenv-util -n "__fish_use_subcommand" -a ls -d "list pipenvs"
complete -f -c pipenv-util -n "__fish_use_subcommand" -a rm -d "remove pipenvs"

# rm
complete -f -c pipenv-util -n "__fish_seen_subcommand_from rm" \
  -a "(ls $PIPENV_DIR)"

