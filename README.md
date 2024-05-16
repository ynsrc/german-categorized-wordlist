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


## gennum.sh - Example Usage
You can use [gennum.sh](tools/gennum.sh) script to convert number or
number ranges to text in German language.

```
$ bash tools/gennum.sh -s912330 -e912350  
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
912341 = neunhundertzwölftausenddreihunderteinundvierzig
912342 = neunhundertzwölftausenddreihundertzweiundvierzig
912343 = neunhundertzwölftausenddreihundertdreiundvierzig
912344 = neunhundertzwölftausenddreihundertvierundvierzig
912345 = neunhundertzwölftausenddreihundertfünfundvierzig
912346 = neunhundertzwölftausenddreihundertsechsundvierzig
912347 = neunhundertzwölftausenddreihundertsiebenundvierzig
912348 = neunhundertzwölftausenddreihundertachtundvierzig
912349 = neunhundertzwölftausenddreihundertneunundvierzig
912350 = neunhundertzwölftausenddreihundertfünfzig
```


# Attributions
* https://www.koeblergerhard.de
* https://gist.github.com/MarvinJWendt/2f4f4154b8ae218600eb091a5706b5f4


# License
CC BY 4.0 LEGAL CODE
Attribution 4.0 International

Feel free to use this code in your personal, open-source or even commercial projects. Only attribution needed.