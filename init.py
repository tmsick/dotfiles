#!/usr/bin/env python3


def main():
    from app.dotfilesinstaller import DotfilesInstaller
    from app.brewinstaller import BrewInstaller
    from app.masinstaller import MasInstaller

    DotfilesInstaller().install()
    BrewInstaller().install()
    MasInstaller().install()


if __name__ == "__main__":
    main()
