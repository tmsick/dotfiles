from .command.run import run


def before():
    run(["brew", "update"])


def after():
    run(["brew", "doctor"])


def exec_installation(formulae):
    result = run(["brew", "list"])
    formulae -= set(result.stdout.decode("utf-8").split())
    formulae = list(formulae)
    if formulae:
        run(["brew", "install"] + formulae)


def install(formulae):
    before()
    exec_installation(formulae)
    after()
