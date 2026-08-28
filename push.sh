#!/bin/bash
set -e

REPO_URL="https://github.com/minhonline2k2/Bigdata.git"

if [ ! -d .git ]; then
    git init
    git branch -M main
fi

git config user.name "minhonline2k2"
git config user.email "minhonline2k2@gmail.com"

git add -A
if git diff --cached --quiet; then
    echo ">>> Khong co thay doi moi de commit."
else
    git commit -m "Hadoop Standalone: Bai 1 WordCount + Bai 11 LineCount, dong goi Docker"
fi

# 4. Khai bao remote origin (idempotent)
if git remote get-url origin >/dev/null 2>&1; then
    git remote set-url origin "$REPO_URL"
else
    git remote add origin "$REPO_URL"
fi

git push -u origin main
