# Wiktionary Word Parser

## wkt-word-parser.go
Wiktionary Text Dump to Wordlist(s) Parser Tool

This tool process text dump output of [wk-extract.py](../wk-extract/wk-extract.py) 
and parses words with type informations to generate wordlist output files. 

Recommended usage
```
$ go run tools/wkt-word-parser/wkt-word-parser.go 2>parse_log.txt
```

If text dump file name is single_output.txt you can omit -i parameter, and default
-o parameter is parsed_words.csv. You can change file names with this parameters.

Results of this tool is added in [sources/dewiktionary](sources/dewiktionary) folder.
