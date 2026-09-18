#!/usr/bin/env python3
import sys
import re
for line in sys.stdin:
    line = line.strip()
    line = re.sub(r'[^\w\s]', ' ', line)
    for word in line.split():
        print("%s\t%s" % (word.lower(), 1))


