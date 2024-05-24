#!/bin/bash

# make build dir
mkdir -p build

# copy original file to build dir
cp parsed_words.csv build/step-00.txt

# go to build dir
cd build

# target directory
TARGET="../generated"
mkdir -p ${TARGET}

# clean target
rm ${TARGET}/*.txt

cat step-00.txt | cut -d";" -f2 | sed -r 's/^\s+//' | tr '+' '\n' | sort -u > step-00-types.txt

grep -E '.*?; .*?Abkürzung' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/abbreviation.txt"
grep -E '.*?; .*?Adjektiv' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/adjective.txt"
grep -E '.*?; .*?Adverb' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/adverb.txt"
grep -E '.*?; .*?Antwortpartikel' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/particle-antwort.txt"
grep -E '.*?; .*?Artikel' step-00.txt | grep -v 'ohne' | cut -d";" -f1 | sort -u > "${TARGET}/article.txt"
grep -E '.*?; .*?Demonstrativpronomen' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/pronoun-demonstrative.txt"
grep -E '.*?; .*?Eigenname' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/noun-proper.txt"
grep -E '.*?; .*?Substantiv\+[^+]*?f' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/noun-die.txt"
grep -E '.*?; .*?Substantiv\+[^+]*?m' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/noun-der.txt"
grep -E '.*?; .*?Substantiv\+[^+]*?n' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/noun-das.txt"

grep -E '.*?; .*?Gebundenes Lexem' step-00.txt | cut -d";" -f1 | sort -u > step-01-lexeme.txt
grep -E '.*?; .*?Präfix' step-00.txt | cut -d";" -f1 | sort -u >> step-01-lexeme.txt
grep -E '.*?; .*?Suffix' step-00.txt | cut -d";" -f1 | sort -u >> step-01-lexeme.txt
grep -E '^-' step-01-lexeme.txt | cut -d";" -f1 | sort -u > "${TARGET}/affix-prefix.txt"
grep -E '.*-$' step-01-lexeme.txt | cut -d";" -f1 | sort -u > "${TARGET}/affix-suffix.txt"

grep -E '.*?; .*?Geflügeltes Wort' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/expression-multi-word.txt"
grep -E '.*?; .*?Indefinitpronomen' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/pronoun-indefinite.txt"
grep -E '.*?; .*?Interjektion' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/interjection.txt"
grep -E '.*?; .*?Komparativ' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/comparative.txt"
grep -E '.*?; .*?Konjunktion' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/conjunction.txt"
grep -E '.*?; .*?Konjunktionaladverb' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/adverb-conjunctional.txt"
grep -E '.*?; .*?Kontraktion' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/contraction.txt"
grep -E '.*?; .*?Lokaladverb' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/adverb-local.txt"
grep -E '.*?; .*?Modaladverb' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/adverb-modal.txt"
grep -E '.*?; .*?Nachname' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/noun-proper-surname.txt"
grep -E '.*?; .*?Ortsnamengrundwort' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/affix-suffix-place-name.txt"
grep -E '.*?; .*?[Pa]article' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/particle.txt"
grep -E '.*?; .*?Partizip I[^I]?' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/verb-participle-1.txt"
grep -E '.*?; .*?Partizip II' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/verb-participle-2.txt"
grep -E '.*?; .*?Personalpronomen' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/pronoun-personal.txt"
grep -E '.*?; .*?Postposition' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/postposition.txt"
grep -E '.*?; .*?Präposition' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/preposition.txt"
grep -E '.*?; .*?Pronomen' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/pronoun.txt"
grep -E '.*?; .*?Pronominaladverb' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/adverb-pronominal.txt"
grep -E '.*?; .*?Redewendung' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/expression-idiom.txt"
grep -E '.*?; .*?Reflexivpronomen' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/pronoun-reflexive.txt"
grep -E '.*?; .*?[^n]regelmäßig' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/verb-regular.txt"
grep -E '.*?; .*?unregelmäßig' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/verb-irregular.txt"
grep -E '.*?; .*?Relativpronomen' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/pronoun-relative.txt"
grep -E '.*?; .*?Sprichwort' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/expression-proverb.txt"
grep -E '.*?; .*?Subjunktion' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/subjunction.txt"
grep -E '.*?; .*?Superlativ' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/superlative.txt"
grep -E '.*?; .*?Temporaladverb' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/adverb-temporal.txt"
grep -E '.*?; .*?Verb.*?untrennbar' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/verb-inseperable.txt"
grep -E '.*?; .*?Verb.*?[^n]trennbar' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/verb-seperable.txt"
grep -E '.*?; .*?Verb[^\w]?' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/verb.txt"
grep -E '.*?; .*?Vorname' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/noun-proper-first-name.txt"
grep -E '.*?; .*?Wortverbindung' step-00.txt | cut -d";" -f1 | sort -u > "${TARGET}/word-combination.txt"
