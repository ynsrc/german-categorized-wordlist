package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
	s "strings"
)

var buildPath = filepath.Join(".", "build")
var targetPath = filepath.Join(".", "generated")

func extractWordlist(fileName string) string {
	inFile, inFileError := os.Open(fileName)
	if inFileError != nil {
		fmt.Fprintln(os.Stderr, inFileError)
		os.Exit(1)
	}
	defer inFile.Close()

	skipFile, skipFileError := os.Create(filepath.Join(buildPath, fileName+"_skipped.txt"))
	if skipFileError != nil {
		fmt.Fprintln(os.Stderr, skipFileError)
		os.Exit(1)
	}
	defer skipFile.Close()

	scanner := bufio.NewScanner(inFile)
	skippedLines := 0
	wordmap := make(map[string]string)

	acceptedTypes := []string{"Adj.", "Adv.", "Art.", "F.", "Interj.", "Konj.", "M.", "N.", "Num. Kard.",
		"Num. Ord.", "Partikel", "Pl.", "Präf.", "Präp.", "Pron.", "Sb.", "Suff.", "V.", "präf."}

	for scanner.Scan() {
		line := scanner.Text()

		if !s.Contains(line, ":") {
			skippedLines++
			skipFile.WriteString(line + "\n")
			continue
		}

		firstPart := s.Split(line, ":")[0]

		if !s.Contains(firstPart, "nhd") {
			skippedLines++
			skipFile.WriteString(line + "\n")
			continue
		}

		subParts := s.Split(firstPart, "nhd")
		wordPart := subParts[0]
		wordTypePart := subParts[1]

		if s.Contains(wordPart, ",") {
			wordPart = s.Split(wordPart, ",")[0]
		}

		if s.Contains(wordPart, "(") {
			wordPart = s.Split(wordPart, "(")[0]
		}

		word := s.Trim(wordPart, "+&#?$* ")

		var wordTypes []string

		wordTypePart = s.Replace(wordTypePart, "F. Pl.", "Pl.", -1)
		wordTypePart = s.Replace(wordTypePart, "M. Pl.", "Pl.", -1)
		wordTypePart = s.Replace(wordTypePart, "N. Pl.", "Pl.", -1)

		for _, pattern := range acceptedTypes {
			if s.Contains(wordTypePart, pattern) {
				wordTypes = append(wordTypes, pattern)
			}
		}

		if word == "" || len(wordTypes) == 0 {
			skippedLines++
			skipFile.WriteString(line + "\n")
			continue
		}

		wordmap[word] = s.Join(wordTypes, "/")
	}

	if skippedLines > 0 {
		fmt.Println(skippedLines, "lines skipped in "+fileName+" file")
	}

	buildFilePath := filepath.Join(buildPath, fileName)
	fmt.Println("Generating:", buildFilePath)

	outFile, outFileError := os.Create(filepath.Join(buildPath, fileName))
	if outFileError != nil {
		fmt.Fprintln(os.Stderr, outFileError)
		os.Exit(1)
	}
	defer inFile.Close()

	for word, wordType := range wordmap {
		if s.Contains(wordType, "/") {
			for _, wordType := range s.Split(wordType, "/") {
				outFile.WriteString(word + "; " + wordType + "\n")
			}
		} else {
			outFile.WriteString(word + "; " + wordType + "\n")
		}
	}

	return buildFilePath
}

func main() {
	buildPathErr := os.MkdirAll(buildPath, os.ModePerm)
	if buildPathErr != nil {
		fmt.Fprintln(os.Stderr, buildPathErr)
		os.Exit(1)
	}

	targetPathErr := os.MkdirAll(targetPath, os.ModePerm)
	if targetPathErr != nil {
		fmt.Fprintln(os.Stderr, targetPathErr)
		os.Exit(1)
	}

	inputFiles := []string{"grimm1.txt", "grimm2.txt", "edel.txt"}

	for _, fileName := range inputFiles {
		fmt.Println("Extracting: " + fileName)
		extractWordlist(fileName)
	}

	fmt.Println("Completed!")
}
