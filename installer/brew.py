def install(formulae):
    from subprocess import run, PIPE

    result = run(["brew", "list"], stdout=PIPE)
    formulae -= set(result.stdout.decode("utf-8").split())
    formulae = list(formulae)
    if formulae:
        run(["brew", "install"] + formulae)
