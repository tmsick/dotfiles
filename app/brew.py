def install():
    from subprocess import run, PIPE
    from .path import root

    configpath = root().joinpath("config", "brew.json")
    with open(configpath) as f:
        from json import load

        formulae = set(load(f))

    result = run(["brew", "list"], stdout=PIPE)
    formulae -= set(result.stdout.decode("utf-8").split())
    formulae = list(formulae)

    if formulae:
        run(["brew", "install"] + formulae)
