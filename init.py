#!/usr/bin/env python3


def main():
    from config import config
    from app import dotfiles, brew, mas

    dotfiles.install()
    brew.install(config["brew"])
    mas.install(config["mas"])


if __name__ == "__main__":
    main()
