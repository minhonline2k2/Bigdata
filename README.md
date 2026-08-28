# Big Data - BTL Nhom (Hadoop Standalone)

Hai bai tap:
- **Bai 1 - WordCount**: dem so lan xuat hien cua moi tu. (`src/wordcount/`)
- **Bai 11 - LineCount**: dem tong so dong code trong thu muc nhieu file ma nguon. (`src/linecount/`)

Moi truong duoc dong goi bang Docker: Ubuntu 22.04 + Java 8 + Hadoop 3.3.6.
Code, du lieu, ket qua deu nam ngoai image (mount vao container), nen sua code
khong can build lai image.

## Yeu cau duy nhat tren may
Chi can cai **Docker**:
- Windows / macOS: cai **Docker Desktop**
- Linux: cai `docker` (vd `sudo apt install docker.io`)

Khong can tu cai Java hay Hadoop tren may - tat ca nam trong image.

## Chay (chi 1 lenh)

```bash
# Cap quyen chay script (lan dau, tren Linux/macOS)
chmod +x start.sh run.sh

# Cach 1: chay thang ca hai bai, in ket qua ra man hinh
./start.sh run

# Cach 2: mo terminal trong container roi tu go lenh
./start.sh
# ... khi da o trong container:
bash run.sh
```

Lan **dau tien** se build image (tai Java + Hadoop, can mang, hoi lau).
Nhung lan sau dung lai cache nen nhanh. Sau khi build xong co the chay OFFLINE.

## Cau truc thu muc

```
Bigdata/
├─ Dockerfile              # dinh nghia moi truong Ubuntu+Java+Hadoop
├─ start.sh               # build image + vao container (chay tren may that)
├─ run.sh                 # build .jar + chay 2 bai (chay trong container)
├─ README.md
├─ src/
│  ├─ wordcount/WordCount.java     # Bai 1
│  └─ linecount/LineCount.java     # Bai 11
├─ input/
│  ├─ sample.txt                   # du lieu cho Bai 1
│  └─ codebase/                    # thu muc ma nguon cho Bai 11
│     ├─ Foo.java
│     ├─ bar.py
│     └─ util.c
├─ output/                # ket qua sinh ra khi chay (tu dong)
└─ build/                 # file .class + .jar (tu dong)
```

## Ket qua ky vong (de doi chieu)

**Bai 1 - WordCount:**
```
big 3
count 1
data 3
hadoop 2
hello 3
mapreduce 2
word 1
world 2
```

**Bai 11 - LineCount:** (bo cac dong trong)
```
total_lines 22
```

## Mang image sang may khac (khong co mang)

```bash
docker save hadoop-standalone -o hadoop.tar   # xuat ra file
# chep hadoop.tar sang may khac roi:
docker load -i hadoop.tar                       # nap lai, khoi build
```
