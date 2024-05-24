#!/bin/bash

# Generating Wordlists

mkdir -p build

TARGET=v1
mkdir -p ${TARGET}
rm -f ${TARGET}/*

for wlfile in $(echo sources/**/generated/*.txt);
do
	filename=$(basename $wlfile)
	cat $wlfile >> "build/$filename"
done

for wlfile in $(echo build/*.txt);
do
	filename=$(basename $wlfile)
	cat $wlfile | sort -u > "${TARGET}/$filename"
done

