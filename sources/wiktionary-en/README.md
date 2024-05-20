# EN Wiktionary

This folder contains parsed German words from 
[EN Wiktionary](https://en.wiktionary.org)
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

Note: EN-Wiktionary dump is very big for processing and most of words are 
out of our interest. So you can use uploaded, bzip2 compressed file 
[single_output.txt.bz2](single_output.txt.bz2) for working. This file
contains pages which has only `==German==` string in its text. So words
from other languages different from German are omitted.

To understanding en-wiktionary formatting, you can view raw text source
for a page with visiting `action=raw` parameter added URL. `title` parameter 
is the title of page, soit is the word of interest in this context.

If you want to get raw en-wiktionary text for word "Lastkraftwagen" (LKW)
(it is the German equivalent of the word truck), then visit this URL;

```
https://en.wiktionary.org/w/index.php?action=raw&title=Lastkraftwagen
```

```
$ curl "https://en.wiktionary.org/w/index.php?action=raw&title=Lastkraftwagen"

==German==

===Pronunciation===
* {{IPA|de|/ˈlastkʁaftvaːɡn/}}
* {{audio|de|De-Lastkraftwagen.ogg|audio}}

===Noun===
{{de-noun|m,,-:^}} (common abbreviation [[LKW]])

# [[truck]]

====Declension====
{{de-ndecl|m,,-:^}}

===Further reading===
* {{R:DWDS}}
* {{R:UniLeipzig}}
* {{R:Duden}}
* {{pedia|lang=de}}

{{C|de|Vehicles}}
```

Colon (:) character is special character for wiki pages. For example titles starting with
`Category:`, `Help:`, etc. are special pages and you probably want to omit parsing this files
and our [wk-extract](../../tools/wk-extract) tool does this by default.

## Sections

At first glance, it is clearly seen that en-wiktionary format is very different from 
de-wiktionary format. Informatios about a German word or a word's meanings in German
language located below `==German==` tag in every page.

In en-wiktionary pages word types shown in two lines consecutively.

<details>
<summary>Click here to expand and see some examples.</summary>

```
===Noun===
{{de-noun|m,(e)s,^e}}

===Adjective===
{{de-adj|comp}}

====Declension====
{{de-adecl|comp}}

===Verb===
{{de-verb}} (or as past participle: {{m|de|geraved}})

====Adjective====
{{de-adj|indecl.predonly}}

===Letter===
{{de-noun|n,-,-}}

===Adjective===
{{de-adj}}

====Declension====
{{de-adecl}}

===Noun===
{{de-noun|n,,^er|dim=^chen,^lein,^elein,^le,^el,^'l,^l,^li,^lin,^elin[rare],^erl,erl,^ken[also Ruhrdeutsch],^eken[also Berlinisch],^gen[esp. 18th ct.],^che}}

====Declension====
{{de-ndecl|n,,^er}}
```
</details>

<br/>

In that case, the rows starting with equal signs may be omitted securely. The lines starting with
`{{de-` and ending with `}}` shows related word type.

You can see a complete list of word types in [all_possible_word_types.txt](all_possible_word_types.txt) file.



# Attributions
* https://en.wiktionary.org
* https://dumps.wikimedia.org
* https://en.wiktionary.org/wiki/Category:German_modules


# License
Attribution-ShareAlike 4.0 International
