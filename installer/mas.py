from .command.run import run


def before():
    pass


def after():
    pass


def exec_installation(apps):
    result = run(["mas", "list"])

    for info in result.stdout.decode("utf-8").split("\n"):
        if info:
            id, *_ = info.split()
            if id in apps:
                apps.pop(id)

    ids = list(apps.keys())
    if ids:
        run(["mas", "install"] + ids)


def install(apps):
    before()
    exec_installation(apps)
    after()
