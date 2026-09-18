#!/usr/bin/env python3
import sys
import os
filepath = os.environ.get('mapreduce_map_input_file', 'unknown_file')
filename = os.path.basename(filepath)
for line in sys.stdin:
    if line.strip():  
        print("%s\t1" % filename)
        print("~TOTAL_LINES~\t1")

