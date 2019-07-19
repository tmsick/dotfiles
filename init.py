#!/usr/bin/env python3


def main():
    from config import config
    from installer import brew, mas

    brew.install(config["brew"])
    mas.install(config["mas"])


if __name__ == "__main__":
    main()
