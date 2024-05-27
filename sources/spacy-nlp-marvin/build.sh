#!/bin/bash

if ! [ -f build/spacy-nlp-marvin.txt ]; then
    mkdir -p build
    cp spacy-nlp-marvin.txt.bz2 build
    bzip2 -d build/spacy-nlp-marvin.txt.bz2
fi

mkdir -p generated
rm -f generated/*.txt

grep '; ADV; Degree=Pos' build/spacy-nlp-marvin.txt | cut -d';' -f1 > generated/adverb-positive.txt
grep '; ADV; Degree=Cmp' build/spacy-nlp-marvin.txt | cut -d';' -f1 > generated/comparative.txt
grep '; ADV; Degree=Sup' build/spacy-nlp-marvin.txt | cut -d';' -f1 > generated/superlative.txt
grep '; NOUN; Case=Nom|Gender=Neut|Number=Sing' build/spacy-nlp-marvin.txt | cut -d';' -f1 > generated/noun-das.txt
grep '; NOUN; Case=Nom|Gender=Masc|Number=Sing' build/spacy-nlp-marvin.txt | cut -d';' -f1 > generated/noun-der.txt
grep '; NOUN; Case=Nom|Gender=Fem|Number=Sing' build/spacy-nlp-marvin.txt | cut -d';' -f1 > generated/noun-die.txt
grep -E '; NOUN; .*?Number=Plur' build/spacy-nlp-marvin.txt | cut -d';' -f1 > generated/noun-plural.txt
grep '; VERB; VerbForm=Inf' build/spacy-nlp-marvin.txt | cut -d';' -f1 > generated/verb.txt
