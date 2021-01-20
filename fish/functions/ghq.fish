function ghq
    set -l fuzzy_finder fzf
    set -l len_argv (count $argv)
    set -l first_arg $argv[1]

    if ! which -s ghq
        echo "'ghq' not found in \$PATH" >&2
        return 1
    end

    if ! which -s $fuzzy_finder
        command ghq $argv
        return
    end

    if begin
            test $len_argv -eq 0
            or test $first_arg = -h
            or test $first_arg = --h
            or test $first_arg = -help
            or test $first_arg = --help
            or begin
                test $len_argv -eq 1
                and begin
                    test $first_arg = h
                    or test $first_arg = help
                end
            end
        end
        command ghq $argv
        echo ""
        echo "ADDITIONAL COMMAND:"
        echo "   cd  Go to repositories' directory using $fuzzy_finder"
        return
    end

    if test $first_arg = cd
        set -l path (command ghq list | $fuzzy_finder)
        or return $status
        cd (command ghq root)/$path
        return
    end

    command ghq $argv
end
