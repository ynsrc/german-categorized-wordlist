#!/bin/bash

# make build dir
mkdir -p build

# copy original file to build dir
cp de-en.txt build/step-00.txt

# go to build dir
cd build

# target directory
TARGET="../generated"
mkdir -p ${TARGET}

# take only part before '::' characters
sed -r 's/^(.*?) ::.*$/\1/' step-00.txt > step-01.txt

# transform ';' and '|' to '\n'
tr ';|' '\n' < step-01.txt > step-02.txt

# filter lines by containing {type} info
grep -E '{\w.*?}' step-02.txt > step-03.txt

# trim leading space
sed -r 's/^\s+//' step-03.txt > step-04.txt

# drop after '}'
sed -r 's/^([^\}]+?\}).*$/\1/' step-04.txt > step-05.txt

# remove (...) at the beginning of line
sed -r 's/^\(.*?\) //' step-05.txt > step-06.txt

# remove parts with started but closed parentheses until '{'
sed -r 's/ \([^\)]+\{/ {/' step-06.txt > step-07.txt

# remove lines which have no starting but closing parentheses 
grep -vE '^[^\(]+\)' step-07.txt > step-08.txt

# export ignoring words with including space to another file
grep -E '.*? .*? \{' step-08.txt > step-08-ignore.txt

# ignore words with including space
grep -vE '.*? .*? \{' step-08.txt > step-09.txt

# convert words with two types to two lines
sed -r 's/^(.*?) \{(\w+),(\w+)\}/\1 {\2}\n\1 {\3}/' step-09.txt > step-10.txt

# convert words with three types to three lines
sed -r 's/^(.*?) \{(\w+),(\w+),(\w+)\}/\1 {\2}\n\1 {\3}\n\1 {\4}/' step-10.txt > step-11.txt

# extract all possible types from step-11.txt file
sed -r 's/^.*?\{(.*?)\}/\1/' step-11.txt | sort -u > step-11-types.txt

# drop words with types are invalid or just a few in group
grep -vE '\{(\+.*?)|(Quantifikator)|(Partikel)|(Dat\.)\}' step-11.txt > step-12.txt

# extract all possible types from step-12.txt file
sed -r 's/^.*?\{(.*?)\}/\1/' step-12.txt | sort -u > step-12-types.txt

# build wordlist files
grep " {adj}" step-12.txt | cut -d' ' -f1 | sort -u > "${TARGET}/adjective.txt"
grep " {adv}" step-12.txt | cut -d' ' -f1 | sort -u > "${TARGET}/adverb.txt"
grep " {art}" step-12.txt | cut -d' ' -f1 | sort -u > "${TARGET}/article.txt"
grep " {conj}" step-12.txt | cut -d' ' -f1 | sort -u > "${TARGET}/conjunction.txt"
grep " {f}" step-12.txt | cut -d' ' -f1 | sort -u > "${TARGET}/noun-die.txt"
grep " {interj}" step-12.txt | cut -d' ' -f1 | sort -u > "${TARGET}/interjection.txt"
grep " {m}" step-12.txt | cut -d' ' -f1 | sort -u > "${TARGET}/noun-der.txt"
grep " {num}" step-12.txt | cut -d' ' -f1 | sort -u > "${TARGET}/number.txt"
grep " {pl}" step-12.txt | cut -d' ' -f1 | sort -u > "${TARGET}/noun-plural.txt"
grep " {ppron}" step-12.txt | cut -d' ' -f1 | sort -u > "${TARGET}/pronoun-personal.txt"
grep " {pron interrog}" step-12.txt | cut -d' ' -f1 | sort -u > "${TARGET}/pronoun-interrogative.txt"
grep " {pron}" step-12.txt | cut -d' ' -f1 | sort -u > "${TARGET}/pronoun.txt"
grep " {prp}" step-12.txt | cut -d' ' -f1 | sort -u > "${TARGET}/preposition.txt"
grep " {v.}" step-12.txt | cut -d' ' -f1 | sort -u > "${TARGET}/verb.txt"

echo "Wordlists generated!"
