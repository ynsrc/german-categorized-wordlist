# Wiktionary Dump Converter

## wk-extract.py
Wiktionary XML to Text Dump Converter with Filtering.

This tool extracts xml pages to a single text file to parsing pages line by line.

Note: This tool filters pages by containing text `({{Sprache|Deutsch}})` for de-wiktionary
and `==German==` for en-wiktionary in the `<text>` tag of `<page>` tag and 
ignores pages that has title starts with `Wiktionary:`.

Downloading pages_articles.xml file from a [mirror](https://dumps.wikimedia.org/mirrors.html);

```bash
MIRROR=https://mirror.accum.se/mirror/wikimedia.org/dumps/dewiktionary
XML_URL=${MIRROR}/20240501/dewiktionary-20240501-pages-articles.xml.bz2
wget -O pages_articles.xml.bz2 ${XML_URL}
bzip2 -d pages_articles.xml.bz2
```

Now you can use [wk-extract.py](tools/wk-extract/wk-extract.py) script to extract xml pages to a singe text file.

## DE-Wiktionary:
The wk-extract tool defaults -w de parameter you don't need to add it.

```
python tools/wk-extract/wk-extract.py -i pages_articles.xml -o single_output.txt
```

or

```
python tools/wk-extract/wk-extract.py -w de -i pages_articles.xml -o single_output.txt
```

In a few minutes (depending on xml file size) single_output.txt will be generated.

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

...
```
</details>

<br/>

## EN-Wiktionary
The wk-extract tool defaults -w de parameter you have to set `-w en` parameter for
en-wiktionary xml dumps.

```
python tools/wk-extract/wk-extract.py -w en -i pages_articles.xml -o single_output.txt
```

<details>
<summary>Generated single_output.txt content looks like this now (click to expand)</summary>

```
/*---------- title: frei, id: 35, parent_id: 71689182 ----------*/

{{also|-frei|Frei|fre├¡|fr├®i}}
==German==

===Alternative forms===
* {{alter|de|frey||obsolete}}

===Etymology===
{{dercat|de|gem-pro|ine-pro|inh=1}}
From {{inh|de|gmh|vr├«}}, {{inh|de|goh|fr├«}}, from {{inh|de|gmw-pro|*fr─½}}. Compare {{cog|nl|vrij}}, {{cog|en|free}}, {{cog|da|fri}}.

===Pronunciation===
* {{IPA|de|/f╩üa╔¬╠»/}}
* {{audio|de|De-frei.ogg|Audio}}
* {{rhymes|de|a╔¬╠»|s=1}}

===Adjective===
{{de-adj|comp}}

# [[free]]; [[unenslaved]]; [[unimprisoned]]
#: {{ant|de|unfrei}}
# [[free]]; [[unrestricted]]; ''more negative also:'' [[unrestrained]]; [[licentious]]
#: {{syn|de|ungezwungen|ungebunden}}
# [[unblocked]]; free for passage
# [[independent]]; [[unaffiliated]]

...
```
</details>

<br/>

Now, the real problem with Wiktionary pages is page texts are not easy for
[Parsing](https://en.wiktionary.org/wiki/Wiktionary:Parsing). Some text mining 
processes are required such as cleaning, formatting and omitting some sections.

With [wkt-word-parser.go](../wkt-wordparser/wkt-word-parser.go) script you can
parse words with correct types to adding them into wordlist files.
