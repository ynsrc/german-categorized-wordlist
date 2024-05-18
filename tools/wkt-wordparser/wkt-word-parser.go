/*
** Wiktionary Text Dump Word Parser
** Input must be result of "wk-extract" tool
** https://github.com/german-categorized-wordlist/tools/wk-extract/wk-extract.py
** Such as single_output.txt explained in README.md file at repository root.
 */

// TODO: This script is incomplete and non-functional now.

package main

import (
	"bufio"
	"flag"
	"fmt"
	"os"
	s "strings"
)

func main() {
	var fileName string
	flag.StringVar(&fileName, "i", "single_output.txt", "input file to parse")

	fmt.Fprintf(os.Stderr, "Parsing file: %s", fileName)

	file, err := os.Open(fileName)
	if err != nil {
		panic(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	current_word := ""

	for scanner.Scan() {
		line := s.Trim(scanner.Text(), " \r\n\t")

		if len(line) == 0 {
			continue
		}

		if s.HasPrefix(line, "/*") {
			word := line[s.Index(line, "title: ")+7 : s.Index(line, ", id: ")]
			// finish previous word
			current_word = word
			fmt.Println(current_word)
			continue
		}
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "Error:", err)
		os.Exit(1)
	}
}
