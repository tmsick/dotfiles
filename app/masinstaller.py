class MasInstaller:
    def __init__(self, configpath="config/mas.json"):
        from .path import root
        from .commandrunner import CommandRunner

        self.__configpath = root().joinpath(configpath)
        if not self.__configpath.exists():
            raise FileNotFoundError("file {} was not found".format(self.__configpath))
        self.__cr = CommandRunner()

    def install(self):
        from yaspin import yaspin

        with yaspin() as sp:
            sp.text = "Resolving apps..."
            apps = self.__resolve_apps()
            sp.write("\N{HEAVY CHECK MARK} Done resolving apps")

            sp.text = "Installing apps..."
            sp.write("\N{HEAVY CHECK MARK} Done installing apps")

            sp.color = "green"
            sp.text = "Done installing Mac App Store apps"
            sp.ok("\N{HEAVY CHECK MARK}")

    def __resolve_apps(self) -> list:
        required = self.__load_required_apps()
        installed = self.__load_installed_apps()
        return list(required - installed)

    def __load_required_apps(self) -> set:
        with open(self.__configpath) as f:
            from json import load

            apps: dict = load(f)

        if type(apps) is not dict:
            msg = """
{} have to be a dict of string:string representing <app id>:<app name>
got {}
            """.format(
                self.__configpath, type(formulae)
            )
            raise TypeError(msg)

        return {id.strip() for id in apps}

    def __load_installed_apps(self) -> set:
        result = self.__cr.run(["mas", "list"])
        if result.returncode != 0:
            msg = result.stderr.decode("utf-8")
            raise RuntimeError(msg)

        stdout = result.stdout.decode("utf-8")
        apps = set()
        for line in stdout.split("\n"):
            if line:
                app, *_ = line.split()
                apps.add(app)
        return apps

    def __install_apps(self, apps: list):
        result = self.__cr.run(["mas", "install"] + apps)
        if result.returncode != 0:
            msg = result.stderr.decode("utf-8")
            raise RuntimeError(msg)
