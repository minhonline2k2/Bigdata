#!/bin/bash
rm -rf output/wordcount
hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
    -files src/wordcount/mapper.py,src/wordcount/reducer.py \
    -input input/sample.txt \
    -output output/wordcount \
    -mapper "python3 mapper.py" \
    -reducer "python3 reducer.py"

echo "done, ket qua trong output"
