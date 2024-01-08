#!/usr/bin/env python3
"""
Format Brewfile. If Brewfile is not given as an argument, this script reads
stdin, format that, and output to stdout.
"""

from pathlib import Path
from typing import List, Tuple
import argparse
import sys


def _main() -> int:
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
            print(f"File {args.file} does not exist.", file=sys.stderr)
            return 1

    # Execute
    _format(path_in, path_out)
    return 0


def _format(path_in: Path, path_out: Path):
    sections: List[Tuple[str, List[str]]] = []

    with path_in.open() as f:
        for line in f:
            key, *_ = line.split()
            for name, entries in sections:
                if name == key:
                    entries.append(line)
                    break
            else:
                sections.append((key, [line]))

    with path_out.open(mode="w") as f:
        for _, entries in sections:
            entries.sort()
            for line in entries:
                print(line, end="", file=f)


if __name__ == "__main__":
    exit(_main())
