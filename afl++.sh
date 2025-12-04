#!/bin/bash

sudo dnf install glibc.i686 glibc-devel.i686 capstone capstone-devel \
    python3 python3-devel automake cmake git flex bison python3-setuptools \
    glibc-static lld llvm llvm-devel clang \
    gcc-plugin-devel libstdc++-devel

# bandaid for nyx build
sudo cp /usr/lib64/libcapstone.so.5 /usr/lib64/libcapstone.so.4
sudo cp /usr/lib/libcapstone.so.5 /usr/lib/libcapstone.so.4
