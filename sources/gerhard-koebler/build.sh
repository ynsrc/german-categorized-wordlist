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

if ! [ -f merged-wordlist.txt ]; then
    cat grimm1.txt grimm2.txt edel.txt | sort -u > ../merged-wordlist.txt
fi

cd ..

TARGET=generated
mkdir -p ${TARGET}
rm -f ${TARGET}/*.txt

grep '; Adj.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/adjective.txt
grep '; Adv.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/adverb.txt
grep '; Art.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/article.txt
grep '; F.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/noun-die.txt
grep '; Interj.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/interjection.txt
grep '; Konj.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/conjunction.txt
grep '; M.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/noun-der.txt
grep '; N.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/noun-das.txt
grep '; Num. Kard.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/number-cardinal.txt
grep '; Num. Ord.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/number-ordinal.txt
grep '; Partikel' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/particle.txt
grep '; Pl.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/noun-plural.txt
grep '; [Pp]räf.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/affix-prefix.txt
grep '; Präp.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/preposition.txt
grep '; Pron.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/pronoun.txt
# grep '; Sb.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/substantive.txt
grep '; Suff.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/affix-suffix.txt
grep '; V.' merged-wordlist.txt | cut -d';' -f1 > ${TARGET}/verb.txt
