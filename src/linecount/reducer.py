#!/usr/bin/env python3
import sys
current_key = None
current_count = 0
for line in sys.stdin:
    try:
        key, count = line.strip().split("\t", 1)
        count = int(count)
    except ValueError:
        continue
    if current_key == key:
        current_count += count
    else:
        if current_key is not None:
            if current_key == "~TOTAL_LINES~":
                print("tong cong:\t%d" % current_count)
            else:
                print("File %s:\t%d" % (current_key, current_count))
        current_key = key
        current_count = count
if current_key is not None:
    if current_key == "~TOTAL_LINES~":
        print("tong cong:\t%d" % current_count)
    else:
        print("File %s:\t%d" % (current_key, current_count))

