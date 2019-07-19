import sys
from pathlib import Path


def traverse(srcdir, distdir):
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
            traverse(srcfile, distdir.joinpath(srcfile.name))


def install():
    cwd = Path.cwd()
    thisfile, *_ = sys.argv
    thispath = cwd.joinpath(thisfile)
    thisdir = thispath.parent

    srcdir = thisdir.joinpath("home")
    distdir = Path.home()

    traverse(srcdir, distdir)
