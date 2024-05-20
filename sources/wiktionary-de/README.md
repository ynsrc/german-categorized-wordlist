# DE Wiktionary

This folder contains parsed words from 
[DE Wiktionary](https://de.wiktionary.org)
data dumps.

You can found used pages_articles.xml dump file in
[Wikimedia Dumps](https://dumps.wikimedia.org/).

In the [mirrors](https://dumps.wikimedia.org/mirrors.html)
page you can choose a mirror and download related dumps.

# Parsing

## Raw Format

Recommended way to parsing words is downloading pages_articles.xml dump
from a mirror. We have a tool for extracting pages from xml to a single
text file [wk-extract](../../tools/wk-extract) to process it with
our [wkt-word-parser](../../tools/wkt-wordparser) tool.

To understanding de-wiktionary formatting, you can view raw text source
for a page with visiting `action=raw` parameter added URL. `title` parameter 
is the title of page, soit is the word of interest in this context.

If you want to get raw de-wiktionary text for word "Welt" (it means world in German),
then visit this URL;

```
https://de.wiktionary.org/w/index.php?action=raw&title=Welt
```

```
$ curl "https://de.wiktionary.org/w/index.php?action=raw&title=Welt"

{{Wort der Woche|20|2008}}
== Welt ({{Sprache|Deutsch}}) ==
=== {{Wortart|Substantiv|Deutsch}}, {{f}} ===

{{Deutsch Substantiv Übersicht
|Genus=f
|Nominativ Singular=Welt
|Nominativ Plural=Welten
|Genitiv Singular=Welt
|Genitiv Plural=Welten
|Dativ Singular=Welt
|Dativ Plural=Welten
|Akkusativ Singular=Welt
|Akkusativ Plural=Welten
|Bild=The Earth seen from Apollo 17.jpg|mini|1|die ''Welt'' aus dem Weltraum betrachtet
}}

(... there are more lines after this line)
```

Colon (:) character is special character for wiki pages. For example titles starting with
`Category:`, `Help:`, etc. are special pages and you probably want to omit parsing this files
and our [wk-extract](../../tools/wk-extract) tool does this by default.

## Sections

### Title and Language Information
In the second line (most of pages in first line) `== Welt ({{Sprache|Deutsch}}) ==` part contains
page title and language information. Our [wkt-word-parser](../../tools/wkt-wordparser) tool filters
pages by containing `({{Sprache|Deutsch}})` text.


### Word Type List
Next line begins with `=== ` and ends with `` ===` contains comma seperated word type informations.

In general, this area contains `{{Wortart|Substantiv|Deutsch}}` like word type tags `Wortart|` and
`|Deutsch` parts are same for all pages in our interest. `Substantiv` part is word type (noun, substantive).
And the second word type tag {{f}} means this word has die (feminine) Genus (article).


#### Genus (Artikel) Information for Substantives
| Letter | Meaning   | Artikel |
| ------ | --------- | ------- |
| f      | feminine  | die     |
| m      | masculine | der     |
| n      | neutral   | das     |

Some substantive (noun) word pages has {{nm}}, {{mn}}, {{fm}}, {{mf}} or {{mn.}} like for example 
[Monat](https://de.wiktionary.org/w/index.php?action=raw&title=Monat), 
[Kilometer](https://de.wiktionary.org/w/index.php?action=raw&title=Kilometer) and 
[Tsunami](https://de.wiktionary.org/w/index.php?action=raw&title=Tsunami).

That means this substantives may have different gender in different regions or contexts.


#### Plural Nouns
In general lines between `{{Deutsch Substantiv Übersicht` and next `}}` lists the "Kasus-Ergänzungen"
(declensions of the definite articles) without declensed articles. Please note that the nouns may have
multiple articles also have multiple plural forms in this list with appended number starting with 1.

With single article;

```
{{Siehe auch|[[ingénieur]]}}
== Ingenieur ({{Sprache|Deutsch}}) ==
=== {{Wortart|Substantiv|Deutsch}}, {{m}} ===

{{Deutsch Substantiv Übersicht
|Genus=m
|Nominativ Singular=Ingenieur
|Nominativ Plural=Ingenieure
|Genitiv Singular=Ingenieurs
|Genitiv Plural=Ingenieure
|Dativ Singular=Ingenieur
|Dativ Plural=Ingenieuren
|Akkusativ Singular=Ingenieur
|Akkusativ Plural=Ingenieure
}}

...
```

Or with multiple articles;

```
{{Wort der Woche|16|2022}}
== Spargel ({{Sprache|Deutsch}}) ==
=== {{Wortart|Substantiv|Deutsch}}, {{mf}} ===

{{Deutsch Substantiv Übersicht
|Genus=m
|Nominativ Singular=Spargel
|Nominativ Plural 1=Spargel
|Nominativ Plural 2=Spargeln
|Genitiv Singular=Spargels
|Genitiv Plural 1=Spargel
|Genitiv Plural 2=Spargeln
|Dativ Singular=Spargel
|Dativ Plural 1=Spargeln
|Dativ Plural 2=Spargeln
|Akkusativ Singular=Spargel
|Akkusativ Plural 1=Spargel
|Akkusativ Plural 2=Spargeln
}}

...
```

#### Plural Word Type Warning
Some nouns have multiple forms also in the word types list. For example in `Wort` 
page `Wörter` plural form also located in word types list.

```
{{Siehe auch|[[wort]]}}
{{Wort der Woche|23|2006}}
== Wort ({{Sprache|Deutsch}}) ==
=== {{Wortart|Substantiv|Deutsch}}, {{n}}, Wörter ===

{{Deutsch Substantiv Übersicht
|Genus=n
|Nominativ Singular=Wort
|Nominativ Plural=Wörter
|Genitiv Singular=Worts
|Genitiv Singular*=Wortes
|Genitiv Plural=Wörter
|Dativ Singular=Wort
|Dativ Singular*=Worte
|Dativ Plural=Wörtern
|Akkusativ Singular=Wort
|Akkusativ Plural=Wörter
}}

...
```

#### Verbs (regular, irregular, seperable, inseperable etc.)
Some example verb word types definitions are below;

```
=== {{Wortart|Verb|Deutsch}} ===
=== {{Wortart|Verb|Deutsch}}, ''unregelmäßig'' ===
=== {{Wortart|Verb|Deutsch}}, {{unreg.}} ===
=== {{Wortart|Verb|Deutsch}}, trennbar ===
=== {{Wortart|Verb|Deutsch}}, untrennbar ===
=== {{Wortart|Verb|Deutsch}}, {{trans.}} ===
=== {{Wortart|Verb|Deutsch}}, ''unregelmäßig, regelmäßig'' ===
=== {{Wortart|Verb|Deutsch}}, regelmäßig ===
=== {{Wortart|Verb|Deutsch}}, ''regelmäßig'' oder ''unregelmäßig'' ===
```

#### Some Other Word Types
Wiktionary pages are unfortunately not following a regular format by
describing word types so it is not an easy task to parse each word.

Our approach is taking each part tagged with `{{` and `}}` symbols or wrapped with double
single quotes `''` and removing this symbols, `{{Wortart|` and `|Deutsch}}` parts. Then
building a plus `+` seperated word type list with this informations.

```
=== {{Wortart|Adjektiv|Deutsch}} ===
=== {{Wortart|Adjektiv|Deutsch}}, ''indeklinabel'' ===
=== {{Wortart|Adjektiv|Deutsch}}, {{Wortart|Indefinitpronomen|Deutsch}} ===
=== {{Wortart|Adjektiv|Deutsch}}, {{indekl.}} ===
=== {{Wortart|Adjektiv|Deutsch}}, {{Wortart|Numerale|Deutsch}}, ''indeklinabel'' ===
=== {{Wortart|Adjektiv|Deutsch}}, {{Wortart|Adverb|Deutsch}} ===
=== {{Wortart|Wortverbindung|Deutsch}}, {{Wortart|Adjektiv|Deutsch}} ===
=== {{Wortart|Wortverbindung|Deutsch}}, {{Wortart|Adjektiv|Deutsch}}, ''indeklinabel'' ===
```


# Attributions
* https://de.wiktionary.org
* https://dumps.wikimedia.org


# License
Attribution-ShareAlike 4.0 International
