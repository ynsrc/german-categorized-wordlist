# Generating Wordlists

all: number-cardinal.txt number-ordinal.txt

number-cardinal.txt:
	@echo "Generating number-cardinal.txt"
	go run tools/gennum.go -s 0 -e 999999 | gzip -c9 > v1/number-cardinal.txt.gz

number-ordinal.txt:
	@echo "Generating number-ordinal.txt"
	go run tools/gennum.go -s 0 -e 999999 -o | gzip -c9 > v1/number-ordinal.txt.gz
