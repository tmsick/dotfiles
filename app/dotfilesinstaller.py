from pathlib import Path


class DotfilesInstaller:
    def install(self):
        from yaspin import yaspin
        from .path import root

        with yaspin(text="Installing dotfiles...") as sp:
            srcdir = root().joinpath("home")
            distdir = Path.home()

            self.__traverse(srcdir, distdir)

            sp.color = "green"
            sp.text = "Done installing dotfiles"
            sp.ok("\N{HEAVY CHECK MARK}")

    def __traverse(self, srcdir, distdir):
        if not srcdir.is_dir():
            return

        for srcfile in srcdir.iterdir():
            if srcfile.is_file():
                distfile = distdir.joinpath(srcfile.name)
                Path.mkdir(distfile.parent, parents=True, exist_ok=True)

                if distfile.exists():
                    distfile.unlink()

                distfile.symlink_to(srcfile)

            if srcfile.is_dir():
                self.__traverse(srcfile, distdir.joinpath(srcfile.name))
