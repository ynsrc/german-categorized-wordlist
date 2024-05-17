# German Categorized Wordlist

This project contains categorized German words in seperated text files with new line delimiter.

This first version (v1) generated from [grimm1](https://www.koeblergerhard.de/grimm1.htm) and [grimm2](https://www.koeblergerhard.de/grimm2.htm) **huge** files. And some words added from Wiktionary pages.

Planned to expanding wordlist files and improving quality by cleaning mismatches or fixing mistyped words.


## Notes
* Lines are sorted and unique in each file.
* Files are categoriez by word types.

| Type             | File                                          |
| ---------------- | --------------------------------------------- |
| Adjectives       | [adjective.txt](v1/adjective.txt)             |
| Adverbs          | [adverb.txt](v1/adverb.txt)                   |
| Affixes/Prefixes | [affix-prefix.txt](v1/affix-prefix.txt)       |
| Affixes/Suffixes | [affix-suffix.txt](v1/affix-suffix.txt)       |
| Articles         | [article.txt](v1/article.txt)                 |
| Conjunctions     | [conjunction.txt](v1/conjunction.txt)         |
| Interjections    | [interjection.txt](v1/interjection.txt)       |
| Noun (der)       | [noun-der.txt](v1/noun-der.txt)               |
| Noun (die)       | [noun-die.txt](v1/noun-die.txt)               |
| Noun (das)       | [noun-das.txt](v1/noun-das.txt)               |
| Noun (die pl.)   | [noun-plural.txt](v1/noun-plural.txt)         |
| Cardinal Numbers | [number-cardinal.txt](v1/number-cardinal.txt) |
| Ordinal Numbers  | [number-ordinal.txt](v1/number-ordinal.txt)   |
| Particles        | [particle.txt](v1/particle.txt)               |
| Prepositions     | [preposition.txt](v1/preposition.txt)         |
| Pronouns         | [pronoun.txt](v1/pronoun.txt)                 |
| Verbs            | [verb.txt](v1/verb.txt)                       |


# Using Tools
Recreational number generator script added now, and other tools may be
added in tools folder and they may be in any convenient programmin or
scripting language.


## gennum.sh (Not Recommended)
You can use [gennum.sh](tools/gennum.sh) script to convert number or
number ranges to text in German language.
<details>
<summary>Cardinal Numbers (click to expand)</summary>

```
$ bash tools/gennum.sh -s912330 -e912340
Generating 'cardinal' numbers from 912330 to 912350
912330 = neunhundertzwölftausenddreihundertdreißig
912331 = neunhundertzwölftausenddreihunderteinunddreißig
912332 = neunhundertzwölftausenddreihundertzweiunddreißig
912333 = neunhundertzwölftausenddreihundertdreiunddreißig
912334 = neunhundertzwölftausenddreihundertvierunddreißig
912335 = neunhundertzwölftausenddreihundertfünfunddreißig
912336 = neunhundertzwölftausenddreihundertsechsunddreißig
912337 = neunhundertzwölftausenddreihundertsiebenunddreißig
912338 = neunhundertzwölftausenddreihundertachtunddreißig
912339 = neunhundertzwölftausenddreihundertneununddreißig
912340 = neunhundertzwölftausenddreihundertvierzig
```
</details>

<br/>

<details>
<summary>Ordinal Numbers  (click to expand)</summary>

```
$ bash tools/gennum.sh -s912330 -e912340 -o
Generating 'ordinal' numbers from 912330 to 912340
912330 = neunhundertzwölftausenddreihundertdreißigste
912331 = neunhundertzwölftausenddreihunderteinunddreißigste
912332 = neunhundertzwölftausenddreihundertzweiunddreißigste
912333 = neunhundertzwölftausenddreihundertdreiunddreißigste
912334 = neunhundertzwölftausenddreihundertvierunddreißigste
912335 = neunhundertzwölftausenddreihundertfünfunddreißigste
912336 = neunhundertzwölftausenddreihundertsechsunddreißigste
912337 = neunhundertzwölftausenddreihundertsiebenunddreißigste
912338 = neunhundertzwölftausenddreihundertachtunddreißigste
912339 = neunhundertzwölftausenddreihundertneununddreißigste
912340 = neunhundertzwölftausenddreihundertvierzigste
```
</details>

<br/>

## gennum.go (Recommended)
You can use [gennum.go](tools/gennum.go) script to convert number or
number ranges to text in German language.

This script written in Go and you can run it in project root:
```
go run tools/gennum.go -h
```

or you can build it an executable (e.g. exe in Windows) and then run:
```
go build tools/gennum.go
```

Examples

<details>
<summary>Using Help (click to expand)</summary>

```
$ go run tools/gennum.go -h                          
Usage:
  -d    print number also in digits at the beginning of the line
  -e int
        count until value
  -ein
        verbose ein in einhundert, eintausend etc.
  -h    show usage help
  -o    print ordinal numbers instad of cardinals
  -p    use parentheses in (ein)hundert, tausend(und)zwei etc.
  -s int
        start number from
  -und
        verbose und in hundertundeins, tausendundzwei etc.
```
</details>

<br/>

<details>
<summary>Cardinal Numbers (click to expand)</summary>

```
$ go run tools/gennum.go -s 1000 -e 1010 -ein -und -p -d
Verbose on: (ein), (und)
Generating 'cardinal' numbers from 1000 to 1010
1000 = (ein)tausend
1001 = (ein)tausend(und)eins
1002 = (ein)tausend(und)zwei
1003 = (ein)tausend(und)drei
1004 = (ein)tausend(und)vier
1005 = (ein)tausend(und)fünf
1006 = (ein)tausend(und)sechs
1007 = (ein)tausend(und)sieben
1008 = (ein)tausend(und)acht
1009 = (ein)tausend(und)neun
1010 = (ein)tausend(und)zehn
```
</details>

<br/>

<details>
<summary>Ordinal Numbers (click to expand)</summary>

```
$ go run tools/gennum.go -s 1000 -e 1010 -ein -und -p -d -o
Verbose on: (ein), (und)
Generating 'ordinal' numbers from 1000 to 1010
1000 = (ein)tausendste
1001 = (ein)tausend(und)erste
1002 = (ein)tausend(und)zweite
1003 = (ein)tausend(und)dritte
1004 = (ein)tausend(und)vierte
1005 = (ein)tausend(und)fünfte
1006 = (ein)tausend(und)sechste
1007 = (ein)tausend(und)siebte
1008 = (ein)tausend(und)achte
1009 = (ein)tausend(und)neunte
1010 = (ein)tausend(und)zehnte
```
</details>

<br/>

<details>
<summary>Cardinal Numbers Without Verbosing (click to expand)</summary>

```
$ go run tools/gennum.go -s 111000 -e 111010
Generating 'cardinal' numbers from 111000 to 111010
hundertelftausend
hundertelftausendeins
hundertelftausendzwei
hundertelftausenddrei
hundertelftausendvier
hundertelftausendfünf
hundertelftausendsechs
hundertelftausendsieben
hundertelftausendacht
hundertelftausendneun
hundertelftausendzehn
```
</details>

<br/>

<details>
<summary>Ordinal Numbers Without Verbosing (click to expand)</summary>

```
$ go run tools/gennum.go -s 111000 -e 111010 -o
Generating 'ordinal' numbers from 111000 to 111010
hundertelftausendste
hundertelftausenderste
hundertelftausendzweite
hundertelftausenddritte
hundertelftausendvierte
hundertelftausendfünfte
hundertelftausendsechste
hundertelftausendsiebte
hundertelftausendachte
hundertelftausendneunte
hundertelftausendzehnte
```
</details>

<br/>

Warnings or information logs are redirected to stderr, so don't worry 
about them.  If you direct output a text file only numbers will go to 
the file, logs will shown on your terminal window only.

```
$ go run tools/gennum.go -s 111000 -e 111010 -o > temp_file.txt
Generating 'ordinal' numbers from 111000 to 111010
```

Content of temp_file.txt is now:
```
hundertelftausendste
hundertelftausenderste
hundertelftausendzweite
...
```

# Attributions
* https://www.koeblergerhard.de
* https://gist.github.com/MarvinJWendt/2f4f4154b8ae218600eb091a5706b5f4


# License
CC BY 4.0 LEGAL CODE
Attribution 4.0 International

Feel free to use this code in your personal, open-source or even 
commercial projects. Only attribution needed.