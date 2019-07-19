def install():
    from subprocess import run, PIPE
    from .path import root

    configpath = root().joinpath("config", "mas.json")
    with open(configpath) as f:
        from json import load

        apps = load(f)

    result = run(["mas", "list"], stdout=PIPE)

    for info in result.stdout.decode("utf-8").split("\n"):
        if info:
            id, *_ = info.split()
            if id in apps:
                apps.pop(id)

    ids = list(apps.keys())
    if ids:
        run(["mas", "install"] + ids)
