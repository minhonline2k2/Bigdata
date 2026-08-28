#!/bin/bash
# =====================================================================
# Script chay ca hai bai tap ben TRONG container Hadoop.
# Khong chay truc tiep tren may - hay dung ./start.sh de vao container.
# =====================================================================
set -e

HADOOP_CP=$(hadoop classpath)
mkdir -p build/wordcount build/linecount

echo "========================================================"
echo " BAI 1: WordCount - dem so lan xuat hien cua moi tu"
echo "========================================================"
# Bien dich
javac -classpath "$HADOOP_CP" -d build/wordcount src/wordcount/WordCount.java
jar -cvf build/wordcount.jar -C build/wordcount/ . > /dev/null
# Xoa output cu neu co (Hadoop khong ghi de thu muc da ton tai)
rm -rf output/wordcount
# Chay job
hadoop jar build/wordcount.jar WordCount input/sample.txt output/wordcount
echo ""
echo ">>> KET QUA WordCount:"
cat output/wordcount/part-r-00000
echo ""

echo "========================================================"
echo " BAI 11: LineCount - dem tong so dong code trong thu muc"
echo "========================================================"
javac -classpath "$HADOOP_CP" -d build/linecount src/linecount/LineCount.java
jar -cvf build/linecount.jar -C build/linecount/ . > /dev/null
rm -rf output/linecount
# Truyen ca thu muc codebase lam input -> Hadoop doc tat ca file ben trong
hadoop jar build/linecount.jar LineCount input/codebase output/linecount
echo ""
echo ">>> KET QUA LineCount (tong so dong code, bo dong trong):"
cat output/linecount/part-r-00000
echo ""
echo "========================================================"
echo " HOAN TAT ca hai bai."
echo "========================================================"
