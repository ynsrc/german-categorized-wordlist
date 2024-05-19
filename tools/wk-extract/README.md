# Wiktionary Dump Converter

## wk-extract.py
Wiktionary XML to Text Dump Converter with Filtering.

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

With [wkt-word-parser.go](../wkt-wordparser/wkt-word-parser.go) script you can
parse words with correct types to adding them into wordlist files.
