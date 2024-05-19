/*
** Wiktionary Text Dump Word Parser
** Input must be result of "wk-extract" tool
** https://github.com/ynsrc/german-categorized-wordlist (tools/wk-extract)
** Such as single_output.txt explained in README.md file at repository root.
 */

package main

import (
	"bufio"
	"flag"
	"fmt"
	"os"
	"regexp"
	s "strings"
)

const failIfNotParsed = false
const columnSeperator = "; "
const wordTypeListSeperator = "+"

var wordTypesPattern = regexp.MustCompile("=== (.*?\\|Deutsch}}.*?) ===")
var typeListPattern = regexp.MustCompile("[\\{'\\w]{1,2}[^}{']+[}'\\w]{1,2}")

func parseWordTypes(raw string) []string {
	var detectedWordTypes []string

	raw = s.Trim(raw, " \t\r\n")

	if s.HasPrefix(raw, "{{Wortart|") {
		detectedWordTypes = append(detectedWordTypes, s.Split(raw, "|")[1])
	} else if s.HasPrefix(raw, "{{") {
		raw = s.Replace(raw, "{{", "", -1)
		raw = s.Replace(raw, ".}}", "", -1)
		raw = s.Replace(raw, "}}", "", -1)
		detectedWordTypes = append(detectedWordTypes, raw)
	} else if s.HasPrefix(raw, "''") {
		raw = s.Replace(raw, "'", "", -1)
		raw = s.Replace(raw, ";", ",", -1)
		if s.Contains(raw, ", ") {
			detectedWordTypes = append(detectedWordTypes, s.Split(raw, ", ")...)
		} else {
			detectedWordTypes = append(detectedWordTypes, raw)
		}
	} else if raw != "" {
		detectedWordTypes = append(detectedWordTypes, raw)
	}

	return detectedWordTypes
}

func parseWord(word string, text string) string {
	var detectedWordTypes []string

	if wordTypesMatches := wordTypesPattern.FindAllStringSubmatch(text, 1); len(wordTypesMatches) > 0 {
		wordTypes := wordTypesMatches[0][1]

		if typeListMatches := typeListPattern.FindAllStringSubmatch(wordTypes, -1); len(typeListMatches) > 0 {
			for _, wordTypeRaw := range typeListMatches {
				wordTypes := parseWordTypes(wordTypeRaw[0])
				if len(wordTypes) > 0 {
					detectedWordTypes = append(detectedWordTypes, wordTypes...)
				} else if failIfNotParsed {
					panic("Undetectable word type: " + wordTypeRaw[0] + " for: " + word)
				} else {
					fmt.Fprintln(os.Stderr, "Undetectable word type: "+wordTypeRaw[0]+" for: "+word)
				}
			}
		}
	}

	if len(detectedWordTypes) > 0 {
		return word + columnSeperator + s.Join(detectedWordTypes, wordTypeListSeperator)
	} else if failIfNotParsed {
		panic("No word type found for: " + word)
	} else {
		fmt.Fprintln(os.Stderr, "No word type found for: "+word)
	}

	return ""
}

func main() {
	var inputFileName string
	flag.StringVar(&inputFileName, "i", "single_output.txt", "input file to parse")

	var outputFileName string
	flag.StringVar(&outputFileName, "o", "parsed_words.csv", "target csv file for parsed words")

	fmt.Fprintln(os.Stderr, "Parsing file:", inputFileName)
	fmt.Fprintln(os.Stderr, "Output file:", outputFileName)

	inputFile, err := os.Open(inputFileName)
	if err != nil {
		panic(err)
	}
	defer inputFile.Close()

	outputFile, err := os.Create(outputFileName)
	if err != nil {
		panic(err)
	}
	defer outputFile.Close()

	scanner := bufio.NewScanner(inputFile)

	current_word := ""
	current_text := ""

	fmt.Fprintln(os.Stderr, "Parsing words, please wait...")

	for scanner.Scan() {
		line := scanner.Text()

		if s.HasPrefix(line, "/*") {
			if current_word != "" && current_text != "" {
				if csv_line := parseWord(current_word, current_text); csv_line != "" {
					outputFile.WriteString(csv_line + "\n")
				}
			}

			word := line[s.Index(line, "title: ")+7 : s.Index(line, ", id: ")]
			current_word = word
			current_text = ""

			continue
		} else {
			current_text += line + "\n"
		}
	}

	// process last word
	if current_word != "" && current_text != "" {
		parseWord(current_word, current_text)
	}

	fmt.Fprintln(os.Stderr, "Completed!")

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "Error:", err)
		os.Exit(1)
	}
}
