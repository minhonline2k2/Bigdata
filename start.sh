#!/bin/bash
# =====================================================================
# Chay tren MAY THAT (hoac Codespace). Yeu cau: da cai Docker.
# Lan dau se build image (can mang de tai Java + Hadoop),
# nhung nhung lan sau dung lai cache nen nhanh.
#
# Cach dung:
#   ./start.sh          -> build (neu can) roi mo terminal trong container
#   ./start.sh run      -> build (neu can) roi chay thang ca hai bai
# =====================================================================
set -e

IMAGE=hadoop-standalone

# Build image neu chua co
if ! docker image inspect $IMAGE > /dev/null 2>&1; then
    echo ">>> Chua co image, dang build (lan dau se hoi lau)..."
    docker build -t $IMAGE .
fi

# Mount toan bo thu muc hien tai vao /workspace trong container.
# Nho vay code, input, output deu nam ben ngoai - sua tren may thay ngay.
if [ "$1" == "run" ]; then
    docker run -it --rm -v "$(pwd):/workspace" $IMAGE bash run.sh
else
    docker run -it --rm -v "$(pwd):/workspace" $IMAGE
fi
