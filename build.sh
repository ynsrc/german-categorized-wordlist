#!/bin/bash

# Generating Wordlists

mkdir -p build
rm -f build/*.txt

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

	case $filename in
		adjective.txt | adverb.txt | article.txt)
			cat $wlfile | grep -vE '[…’\.\(]' | sort -u > "${TARGET}/$filename"
		;;

		affix-prefix.txt)
			cat $wlfile | grep -E '^.*-$' | sort -u > "${TARGET}/$filename"
		;;

		affix-suffix.txt)
			cat $wlfile | grep -E '^-' | tr '.…' '-' | tr -s '-' | grep '^-' | sort -u > "${TARGET}/$filename"
		;;

		comparative.txt)
			cat $wlfile | grep -vE '^-' | sort -u > "${TARGET}/$filename"
		;;

		expression-multi-word.txt)
			cat $wlfile | grep -v 'à' | sort -u > "${TARGET}/$filename"
		;;

		interjection.txt)
			cat $wlfile | grep -vE '[à’,]' | tr -d '!' | sort -u > "${TARGET}/$filename"
		;;

		noun-das.txt | noun-der.txt | noun-die.txt)
			cat $wlfile | grep -vE '^\.|[…\*\+\ǃ’„“§]' | sort -u > "${TARGET}/$filename"
		;;

		noun-plural.txt)
			cat $wlfile | grep -vE '…|\(' | sort -u > "${TARGET}/$filename"
		;;

		number-cardinal.txt | number-ordinal.txt)
			cat $wlfile | grep -vE '^\.|…' | sort -u > "${TARGET}/$filename"
		;;

		particle.txt)
			cat $wlfile | grep -vE '^\.|[\.-]$|[…à]' | sort -u > "${TARGET}/$filename"
		;;

		verb.txt)
			cat $wlfile | grep -vE '^\.|…' | tr -d '()' | sort -u > "${TARGET}/$filename"
		;;

		*)
			cat $wlfile | sort -u > "${TARGET}/$filename"
		;;
	esac 
done

tar cvzf build/wordlists.tar.gz v1/*.txt README.md LICENSE 
