#!/usr/bin/env python3

import subprocess


def brew_formulae():
    result = subprocess.run(["brew", "list"], capture_output=True)
    formulae = {fml: False for fml in result.stdout.decode().split()}
    for fml in formulae:
        result = subprocess.run(["brew", "deps", fml], capture_output=True)
        for dep in result.stdout.decode().split():
            if dep in formulae:
                formulae[dep] = True
    formulae = [fml for fml, depended in formulae.items() if not depended]
    formulae.sort()
    for fml in formulae:
        yield fml


def cask_formulae():
    result = subprocess.run(["brew", "cask", "list"], capture_output=True)
    formulae = result.stdout.decode().split()
    formulae.sort()
    for fml in formulae:
        yield fml


def mas_apps():
    result = subprocess.run(["mas", "list"], capture_output=True)
    apps = result.stdout.decode().split("\n")
    i = 0
    while i < len(apps):
        app = apps[i]
        if not app:
            apps.pop(i)
            continue
        app = app.split()
        identifier = int(app.pop(0))
        _version = app.pop()
        name = " ".join(app)
        apps[i] = (identifier, name)
        i += 1
    apps.sort(key=lambda pair: pair[0])
    for app in apps:
        yield app


def main():
    for fml in brew_formulae():
        print("brew '{}'".format(fml))
    print()
    for fml in cask_formulae():
        print("cask '{}'".format(fml))
    print()
    for identifier, name in mas_apps():
        print("mas '{}', id: {}".format(name, identifier))


if __name__ == "__main__":
    main()
