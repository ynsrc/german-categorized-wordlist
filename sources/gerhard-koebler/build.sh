#!/bin/bash

if ! [ -d build ]; then
    go run build.go
    if [ $? -ne 0 ]; then
        echo "Build failed!"
        exit 1
    fi
fi

if ! [ -f build/grimm1.txt ] || ! [ -f build/grimm2.txt ] || ! [ -f build/edel.txt ]; then
    echo "Required files not found, building..."
    go run build.go
    if [ $? -ne 0 ]; then
        echo "Build failed!"
        exit 1
    fi
fi

cd build

cat grimm1.txt grimm2.txt edel.txt | sort -u > ../merged-wordlist.txt
