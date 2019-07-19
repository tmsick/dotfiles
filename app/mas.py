def install(apps):
    from subprocess import run, PIPE

    result = run(["mas", "list"], stdout=PIPE)

    for info in result.stdout.decode("utf-8").split("\n"):
        if info:
            id, *_ = info.split()
            if id in apps:
                apps.pop(id)

    ids = list(apps.keys())
    if ids:
        run(["mas", "install"] + ids)
