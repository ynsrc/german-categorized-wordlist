#!/bin/bash

if ! [ -f parsed_words.csv ]; then
    mkdir -p build
    rm -f build/*.txt

    cp single_output.txt.bz2 build

    cd build && bzip2 -d single_output.txt.bz2

    go run build.go
fi

if ! [ -f parsed_words.csv ]; then
    echo "parsed_words.csv file not found!"
    exit 1
fi

cat parsed_words.csv | cut -d';' -f2 | sort -u > build/word_types.txt

mkdir -p generated

while read word_type; do
    cat parsed_words.csv | grep ";$word_type$" | cut -d';' -f1 | sort -u > "generated/$word_type.txt"
done < build/word_types.txt

echo "Completed!"
