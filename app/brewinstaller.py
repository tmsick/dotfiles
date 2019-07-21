class BrewInstaller:
    def __init__(self, configpath="config/brew.json"):
        from .path import root
        from .commandrunner import CommandRunner

        self.__configpath = root().joinpath(configpath)
        if not self.__configpath.exists():
            raise FileNotFoundError("file {} was not found".format(self.__configpath))
        self.__cr = CommandRunner()

    def install(self):
        from yaspin import yaspin

        with yaspin() as sp:
            sp.text = "Updating Homebrew..."
            self.__update()
            sp.write("\N{HEAVY CHECK MARK} Done updating Homebrew")

            sp.text = "Resolving formulae..."
            formulae = self.__resolve_formulae()
            sp.write("\N{HEAVY CHECK MARK} Done resolving formulae")

            sp.text = "Installing formulae..."
            self.__install_formulae(formulae)
            sp.write("\N{HEAVY CHECK MARK} Done installing formulae")

            sp.text = "Cleaning up..."
            self.__cleanup()
            sp.write("\N{HEAVY CHECK MARK} Done cleaning up")

            sp.text = "Doctoring..."
            self.__doctor()
            sp.write("\N{HEAVY CHECK MARK} Done doctoring")

            sp.color = "green"
            sp.text = "Done installing Homebrew formulae"
            sp.ok("\N{HEAVY CHECK MARK}")

    def __update(self):
        result = self.__cr.run(["brew", "update"])
        if result.returncode != 0:
            msg = result.stderr.decode("utf-8")
            raise RuntimeError(msg)

    def __resolve_formulae(self) -> list:
        required = self.__load_required_formulae()
        installed = self.__load_installed_formulae()
        # formula `mas` have to be installed even if not included in config file
        return list(required - installed | {"mas"})

    def __load_required_formulae(self) -> set:
        with open(self.__configpath) as f:
            from json import load

            formulae: list = load(f)

        if type(formulae) is not list:
            msg = """
{} have to be a list of strings representing formulae name
got {}
            """.format(
                self.__configpath, type(formulae)
            )
            raise TypeError(msg)

        return {f.strip() for f in formulae}

    def __load_installed_formulae(self) -> set:
        result = self.__cr.run(["brew", "list"])
        if result.returncode != 0:
            msg = result.stderr.decode("utf-8")
            raise RuntimeError(msg)

        stdout = result.stdout.decode("utf-8")
        return {f.strip() for f in stdout.split("\n") if f.strip()}

    def __install_formulae(self, formulae: list):
        if formulae == []:
            return

        result = self.__cr.run(["brew", "install"] + formulae)
        if result.returncode != 0:
            msg = result.stderr.decode("utf-8")
            raise RuntimeError(msg)

    def __cleanup(self):
        result = self.__cr.run(["brew", "cleanup"])
        if result.returncode != 0:
            msg = result.stderr.decode("utf-8")
            raise RuntimeError(msg)

    def __doctor(self):
        result = self.__cr.run(["brew", "doctor"])
        if result.returncode != 0:
            msg = result.stderr.decode("utf-8")
            raise RuntimeError(msg)
