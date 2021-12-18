#!/usr/bin/env python3
"""
Format Brewfile. If Brewfile is not given as an argument, this script reads
stdin, format that, and output to stdout.
"""

from collections import OrderedDict
from pathlib import Path
import argparse
import sys


def main() -> int:
    # Parse args
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("file", type=str, nargs="?", help="Brewfile to format")
    parser.add_argument(
        "-w", "--write", action="store_true", help="overwrite the given Brewfile"
    )
    args = parser.parse_args()

    # Prepare input and output
    path_in = Path("/dev/stdin")
    path_out = Path("/dev/stdout")
    if args.file:
        path_file = Path(args.file)
        if path_file.is_file():
            path_in = path_file
            if args.write:
                path_out = path_file
        else:
            print("File {} does not exist.".format(args.file), file=sys.stderr)
            return 1

    # Execute
    format(path_in, path_out)
    return 0


def format(path_in: Path, path_out: Path):
    od = OrderedDict()

    # Read
    with path_in.open() as f:
        for line in f.readlines():
            key, *_ = line.split()
            if key in od:
                od[key].append(line)
            else:
                od[key] = [line]

    # Sort
    lines = []
    for val in od.values():
        lines += sorted(val)

    # Write
    with path_out.open(mode="w") as f:
        f.writelines(lines)


if __name__ == "__main__":
    exit(main())
