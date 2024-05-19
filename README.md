# German Categorized Wordlist

This project contains categorized German words in seperated text files with new line delimiter.

This first version (v1) generated from [grimm1](https://www.koeblergerhard.de/grimm1.htm) 
and [grimm2](https://www.koeblergerhard.de/grimm2.htm) **huge** files. And some words added 
from Wiktionary pages.

Planned to expanding wordlist files and improving quality by cleaning mismatches or fixing mistyped words.


## Notes
* Lines are sorted and unique in each file.
* Files are categoriez by word types.

| Type             | File                                                |
| ---------------- | --------------------------------------------------- |
| Adjectives       | [adjective.txt](v1/adjective.txt)                   |
| Adverbs          | [adverb.txt](v1/adverb.txt)                         |
| Affixes/Prefixes | [affix-prefix.txt](v1/affix-prefix.txt)             |
| Affixes/Suffixes | [affix-suffix.txt](v1/affix-suffix.txt)             |
| Articles         | [article.txt](v1/article.txt)                       |
| Conjunctions     | [conjunction.txt](v1/conjunction.txt)               |
| Interjections    | [interjection.txt](v1/interjection.txt)             |
| Noun (der)       | [noun-der.txt](v1/noun-der.txt)                     |
| Noun (die)       | [noun-die.txt](v1/noun-die.txt)                     |
| Noun (das)       | [noun-das.txt](v1/noun-das.txt)                     |
| Noun (die pl.)   | [noun-plural.txt](v1/noun-plural.txt)               |
| Cardinal Numbers | [number-cardinal.txt.gz](v1/number-cardinal.txt.gz) |
| Ordinal Numbers  | [number-ordinal.txt.gz](v1/number-ordinal.txt.gz)   |
| Particles        | [particle.txt](v1/particle.txt)                     |
| Prepositions     | [preposition.txt](v1/preposition.txt)               |
| Pronouns         | [pronoun.txt](v1/pronoun.txt)                       |
| Verbs            | [verb.txt](v1/verb.txt)                             |


# Using Tools
Tools are located in [tools](tools/) folder in this repository.

## gennum.go
German Number as Text Generator

You can use [gennum.go](tools/gennum/gennum.go) script to convert number or
number ranges to text in German language.

This script written in Go and you can run it in project root:
```
go run tools/gennum/gennum.go -h
```

or you can build it an executable (e.g. exe in Windows) and then run:
```
go build tools/gennum/gennum.go
```

Examples

<details>
<summary>Using Help (click to expand)</summary>

```
$ go run tools/gennum/gennum.go -h                          
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
$ go run tools/gennum/gennum.go -s 1000 -e 1010 -ein -und -p -d
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
$ go run tools/gennum/gennum.go -s 1000 -e 1010 -ein -und -p -d -o
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
$ go run tools/gennum/gennum.go -s 111000 -e 111010
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
$ go run tools/gennum/gennum.go -s 111000 -e 111010 -o
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
$ go run tools/gennum/gennum.go -s 111000 -e 111010 -o > temp_file.txt
Generating 'ordinal' numbers from 111000 to 111010
```

Content of temp_file.txt is now:
```
hundertelftausendste
hundertelftausenderste
hundertelftausendzweite
...
```

## wk-extract.py
Wiktionary XML Dumped Pages to Single Text File Extractor

This tool extracts xml pages to a single text file to parsing pages line by line.

Note: This tool filters pages by containing text `({{Sprache|Deutsch}})` in the 
`<text>` tag of `<page>` tag and ignores pages that has title starts with `Wiktionary:`.

Downloading pages_articles.xml file from a [mirror](https://dumps.wikimedia.org/mirrors.html);

```bash
MIRROR=https://mirror.accum.se/mirror/wikimedia.org/dumps/dewiktionary
XML_URL=${MIRROR}/20240501/dewiktionary-20240501-pages-articles.xml.bz2
wget -O pages_articles.xml.bz2 ${XML_URL}
bzip2 -d pages_articles.xml.bz2
```

Now you can use [wk-extract.py](tools/wk-extract/wk-extract.py) script to extract xml pages to a singe text file.

```
python tools/wk-extract/wk-extract.py -i pages_articles.xml -o single_output.txt
```

In a few minutes single_output.txt will be generated.

<details>
<summary>Generated single_output.txt content looks like this now (click to expand)</summary>

```
/*---------- title: Hallo, id: 555, parent_id: 9730726 ----------*/

{{Siehe auch|[[hallo]], [[halló]]}}
== Hallo ({{Sprache|Deutsch}}) ==
=== {{Wortart|Substantiv|Deutsch}}, {{n}} ===

{{Deutsch Substantiv Übersicht
|Genus=n
|Nominativ Singular=Hallo
|Nominativ Plural=Hallos
|Genitiv Singular=Hallos
|Genitiv Plural=Hallos
(... there are more lines after this line)

{{Referenzen}}
:[1] {{Ref-Duden}}
:[1] {{Ref-DWDS}}
:[1] {{Ref-UniLeipzig}}

{{Quellen}}

{{Ähnlichkeiten 1|[[Hall]], [[halle]], [[Halle]], [[Halo]], [[Holle]]|Anagramme=[[holla]]}}

/*---------- title: Subfamilia, id: 674, parent_id: 9304491 ----------*/

== Subfamilia ({{Sprache|Deutsch}}) ==
=== {{Wortart|Substantiv|Deutsch}}, {{f}} ===

(... there are too many lines after this line)
```
</details>

<br/>

Now, the real problem with Wiktionary pages is page texts are not easy for
[Parsing](https://en.wiktionary.org/wiki/Wiktionary:Parsing). Some text mining 
processes are required such as cleaning, formatting and omitting some sections.

With [wkt-word-parser.go](tools/wkt-wordparser/wkt-word-parser.go) script you can
parse words with correct types to adding them into wordlist files.


## wkt-word-parser.go
Wiktionary Text Dump to Wordlist(s) Parser Tool

This tool process text dump output of [wk-extract.py](tools/wk-extract/wk-extract.py) 
and parses words with type informations to generate wordlist output files. 

Recommended usage
```
$ go run tools/wkt-word-parser/wkt-word-parser.go 2>parse_log.txt
```

If text dump file name is single_output.txt you can omit -i parameter, and default
-o parameter is parsed_words.csv. You can change file names with this parameters.

Results of this tool is added in [dewiktionary](dewiktionary/) folder.


# Attributions
* https://www.koeblergerhard.de
* https://gist.github.com/MarvinJWendt/2f4f4154b8ae218600eb091a5706b5f4
* https://dumps.wikimedia.org/mirrors.html
* https://extensions.libreoffice.org/en/extensions/show/german-de-de-frami-dictionaries
* https://www-user.tu-chemnitz.de/~fri/ding/


# License
CC BY 4.0 LEGAL CODE
Attribution 4.0 International

Feel free to use this code in your personal, open-source or even 
commercial projects. Only attribution needed.