#!/usr/bin/env python3

from collections import OrderedDict
from sys import stdin

concerns = OrderedDict()
for line in stdin:
    line = line.rstrip()
    concern = line.split()
    if concern:
        concern = concern[0]
    else:
        continue
    if concern in concerns:
        concerns[concern].append(line)
    else:
        concerns[concern] = [line]
for lines in concerns.values():
    print(*sorted(lines), sep="\n")
