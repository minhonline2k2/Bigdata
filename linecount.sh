#!/bin/bash
rm -rf output/linecount
hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -files src/linecount/mapper.py,src/linecount/reducer.py \
    -input input/codebase \
    -output output/linecount \
    -mapper "python3 mapper.py" \
    -reducer "python3 reducer.py"

echo "done, ket qua trong output/lintcount"
