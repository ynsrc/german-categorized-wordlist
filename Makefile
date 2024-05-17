# Generating Wordlists

all: number-cardinal.txt number-ordinal.txt

number-cardinal.txt:
	@echo "Generating number-cardinal.txt"
	go run tools/gennum.go -s 0 -e 999999 > v1/number-cardinal.txt

number-ordinal.txt:
	@echo "Generating number-ordinal.txt"
	go run tools/gennum.go -s 0 -e 999999 -o > v1/number-ordinal.txt

