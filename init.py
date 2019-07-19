#!/usr/bin/env python3


def main():
    from app import dotfiles, brew, mas

    dotfiles.install()
    brew.install()
    mas.install()


if __name__ == "__main__":
    main()
