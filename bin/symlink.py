#!/usr/bin/env python3
"""Symlink dotfiles."""

from pathlib import Path
import argparse
import os
import sys


def _main() -> int:
    # Parse args
    argparse.ArgumentParser(description=__doc__).parse_args()

    # Execute
    dotfiles = Path(os.getenv("DOTFILES_HOME", "~/.dotfiles")).expanduser()
    virtualhome = dotfiles.joinpath("__home__")
    _traverse(virtualhome, Path.home())
    return 0


def _traverse(src: Path, dest: Path):
    if src.is_file():
        if dest.exists():
            if dest.is_symlink() and dest.samefile(src):
                pass
            else:
                print(f"{dest} already exists.", file=sys.stderr)
        else:
            dest.parent.mkdir(parents=True, exist_ok=True)
            dest.symlink_to(src)
    elif src.is_dir():
        for item in src.iterdir():
            _traverse(item, dest.joinpath(item.name))
    else:
        print(f"{src} is not a file nor a directory.", file=sys.stderr)


if __name__ == "__main__":
    exit(_main())
