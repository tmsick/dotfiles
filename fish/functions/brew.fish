function brew
    if ! which -s brew
        echo "'brew' not found in \$PATH" >&2
        return 1
    end

    if ! which -s pyenv
        command brew $argv
        return
    end

    set -lx PATH (printenv PATH | sed s!(pyenv root)/shims:!!)
    command brew $argv
end
