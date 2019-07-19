def root():
    from pathlib import Path
    from sys import argv

    cwd = Path.cwd()
    init, *_ = argv
    return cwd.joinpath(init).parent
