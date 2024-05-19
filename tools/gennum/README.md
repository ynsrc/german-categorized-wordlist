# Generating German Numbers Tools

This scripts generates German numbers as text from 0 to 999999.

## gennum.sh
This is a recreational bash script not recommended to use because of slow speed.


## gennum.go
German Number as Text Generator

You can use [gennum.go](gennum.go) script to convert number or
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
