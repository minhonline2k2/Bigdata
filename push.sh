#!/bin/bash
# =====================================================================
# Script day toan bo repo len GitHub.
# Chay tren MAY BAN (hoac Codespace cua ban), KHONG chay o dau khac.
# An toan khi chay lai nhieu lan (moi buoc deu idempotent).
# GitHub se hoi username + Personal Access Token khi push.
# =====================================================================
set -e

REPO_URL="https://github.com/minhonline2k2/Bigdata.git"

# 1. Khoi tao git (chi lan dau)
if [ ! -d .git ]; then
    git init
    git branch -M main
fi

# 2. Danh tinh commit cho repo nay
git config user.name "minhonline2k2"
git config user.email "minhonline2k2@gmail.com"

# 3. Them file + commit (chi commit khi co thay doi)
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

# 5. Push. GitHub se hoi username + Personal Access Token (dan token vao o password).
git push -u origin main
