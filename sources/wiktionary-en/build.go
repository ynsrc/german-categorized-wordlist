/*
** This script generated parsed_words.csv file
** from build/single_output.txt
 */

package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
	s "strings"
)

const failIfNotParsed = false
const columnSeperator = ";"

var buildPath = filepath.Join(".", "build")
var inputFilePath = filepath.Join(buildPath, "single_output.txt")
var outputFilePath = filepath.Join(".", "parsed_words.csv")

var wordTypeMap = make(map[string]string)
var acceptedWordTypes []string

func initWordTypeMap() {
	wordTypeMap["de-adj"] = "adjective"
	wordTypeMap["de-adv"] = "adverb"
	wordTypeMap["de-cardinals"] = "number-cardinal"
	// wordTypeMap["de-conj"] = "conjunction"
	wordTypeMap["de-noun|f"] = "noun-die"
	wordTypeMap["de-noun|m"] = "noun-der"
	wordTypeMap["de-noun|n"] = "noun-das"
	wordTypeMap["de-ordinals"] = "number-ordinal"
	wordTypeMap["de-proper noun"] = "noun-proper"
	wordTypeMap["de-proverb"] = "expression-proverb"
	wordTypeMap["de-verb"] = "verb"
}

func parseWord(word string, text string) string {
	for typeName, typeCategory := range wordTypeMap {
		if s.Contains(text, "{{"+typeName) {

			if typeName == "de-adj" && s.Contains(text, "{{de-adj form of") {
				return ""
			}

			return word + columnSeperator + typeCategory
		}
	}
	return ""
}

func main() {
	initWordTypeMap()

	inputFile, inputFileError := os.Open(inputFilePath)
	if inputFileError != nil {
		panic(inputFileError)
	}
	defer inputFile.Close()

	outputFile, outputFileError := os.Create(outputFilePath)
	if outputFileError != nil {
		panic(outputFileError)
	}
	defer outputFile.Close()

	skippedFile, skippedFileError := os.Create(filepath.Join(buildPath, "skipped.txt"))
	if skippedFileError != nil {
		panic(skippedFile)
	}
	defer skippedFile.Close()

	scanner := bufio.NewScanner(inputFile)

	current_word := ""
	current_text := ""

	for scanner.Scan() {
		line := scanner.Text()

		if s.HasPrefix(line, "/*") {
			if current_word != "" && current_text != "" {
				if csv_line := parseWord(current_word, current_text); csv_line != "" {
					outputFile.WriteString(csv_line + "\n")
				} else {
					skippedFile.WriteString(current_word + "\n")
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
		if csv_line := parseWord(current_word, current_text); csv_line != "" {
			outputFile.WriteString(csv_line + "\n")
		} else {
			skippedFile.WriteString(current_word + "\n")
		}
	}

	fmt.Fprintln(os.Stderr, "Completed!")
}
