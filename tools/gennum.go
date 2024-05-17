package main

import (
	"flag"
	"fmt"
	"os"
	"strconv"
)

/* CONFIG */

var verboseEin = false
var verboseUnd = false
var verboseUseParentheses = false

/* CARDINAL NUMBERS */

func cardinalNumber0to19(i int) string {
	numbers := []string{"null", "eins", "zwei", "drei", "vier", "fünf", "sechs",
		"sieben", "acht", "neun", "zehn", "elf", "zwölf", "dreizehn", "vierzehn",
		"fünfzehn", "sechzehn", "siebzehn", "achtzehn", "neunzehn"}
	return numbers[i]
}

func cardinalNumberDecade(i int) string {
	numbers := []string{"zwanzig", "dreißig", "vierzig", "fünfzig", "sechzig",
		"siebzig", "achtzig", "neunzig"}
	return numbers[i/10-2]
}

func cardinalNumber20to99(i int) string {
	decade := i / 10 * 10
	ones_digit := i % 10
	result := ""
	if ones_digit == 1 {
		result += "ein"
	} else if ones_digit > 0 {
		result += cardinalNumber0to19(ones_digit)
	}
	if i-decade > 0 {
		result += "und"
	}
	result += cardinalNumberDecade(decade)
	return result
}

func cardinalNumber0to99(i int) string {
	last2 := i % 100
	if last2 < 20 {
		return cardinalNumber0to19(last2)
	} else if last2 >= 20 {
		return cardinalNumber20to99(last2)
	} else {
		return ""
	}
}

func cardinalNumber100to999(i int) string {
	hundred_digit := i / 100
	last2 := i % 100
	result := ""
	if hundred_digit == 1 {
		if verboseEin {
			if verboseUseParentheses {
				result += "(ein)"
			} else {
				result += "ein"
			}
		}
	} else {
		result += cardinalNumber0to19(hundred_digit)
	}
	if hundred_digit > 0 {
		result += "hundert"
	}
	if last2 > 0 {
		if verboseUnd {
			if verboseUseParentheses {
				result += "(und)"
			} else {
				result += "und"
			}
		}
		result += cardinalNumber0to99(last2)
	}
	return result
}

func cardinalNumber0to999(i int) string {
	if i < 100 {
		return cardinalNumber0to99(i)
	} else if i < 1000 {
		return cardinalNumber100to999(i)
	} else {
		return ""
	}
}

func cardinalNumber1000to999999(i int) string {
	tausends := i / 1000
	last3 := i % 1000
	result := ""
	if tausends == 1 {
		if verboseEin {
			if verboseUseParentheses {
				result += "(ein)"
			} else {
				result += "ein"
			}
		}
	} else {
		result += cardinalNumber0to999(tausends)
	}
	if tausends > 0 {
		result += "tausend"
	}
	if last3 > 0 {
		if verboseUnd {
			if verboseUseParentheses {
				result += "(und)"
			} else {
				result += "und"
			}
		}
		result += cardinalNumber0to999(last3)
	}
	return result
}

func cardinalNumber0to999999(i int) string {
	if i < 100 {
		return cardinalNumber0to99(i)
	} else if i < 1000 {
		return cardinalNumber100to999(i)
	} else if i < 1000000 {
		return cardinalNumber1000to999999(i)
	} else {
		return ""
	}
}

/* ORDINAL NUMBERS */

func ordinalNumber0to19(i int) string {
	numbers := []string{"nullte", "erste", "zweite", "dritte", "vierte", "fünfte", "sechste", "siebte",
		"achte", "neunte", "zehnte", "elfte", "zwölfte", "dreizehnte", "vierzehnte", "fünfzehnte",
		"sechzehnte", "siebzehnte", "achtzehnte", "neunzehnte"}
	return numbers[i]
}

func ordinalNumberDecade(i int) string {
	numbers := []string{"zwanzigste", "dreißigste", "vierzigste", "fünfzigste", "sechzigste",
		"siebzigste", "achtzigste", "neunzigste"}
	return numbers[i/10-2]
}

func ordinalNumber20to99(i int) string {
	decade := i / 10 * 10
	ones_digit := i % 10
	result := ""
	if ones_digit == 1 {
		result += "ein"
	} else if ones_digit > 0 {
		result += cardinalNumber0to19(ones_digit)
	}
	if i-decade > 0 {
		result += "und"
	}
	result += ordinalNumberDecade(decade)
	return result
}

func ordinalNumber0to99(i int) string {
	last2 := i % 100
	if last2 < 20 {
		return ordinalNumber0to19(last2)
	} else if last2 < 100 {
		return ordinalNumber20to99(last2)
	} else {
		return ""
	}
}

func ordinalNumber100to999(i int) string {
	hundred_digit := i / 100
	last2 := i % 100
	result := ""
	if hundred_digit == 1 {
		if verboseEin {
			if verboseUseParentheses {
				result += "(ein)"
			} else {
				result += "ein"
			}
		}
	} else {
		result += cardinalNumber0to19(hundred_digit)
	}
	if hundred_digit > 0 {
		result += "hundert"
	}
	if last2 > 0 {
		if verboseUnd {
			if verboseUseParentheses {
				result += "(und)"
			} else {
				result += "und"
			}
		}
		result += ordinalNumber0to99(last2)
	} else {
		result += "ste"
	}
	return result
}

func ordinalNumber0to999(i int) string {
	if i < 100 {
		return ordinalNumber0to99(i)
	} else if i < 1000 {
		return ordinalNumber100to999(i)
	} else {
		return ""
	}
}

func ordinalNumber1000to999999(i int) string {
	tausends := i / 1000
	last3 := i % 1000
	result := ""
	if tausends == 1 {
		if verboseEin {
			if verboseUseParentheses {
				result += "(ein)"
			} else {
				result += "ein"
			}
		}
	} else {
		result += cardinalNumber0to999(tausends)
	}
	if tausends > 0 {
		result += "tausend"
	}
	if last3 > 0 {
		if verboseUnd {
			if verboseUseParentheses {
				result += "(und)"
			} else {
				result += "und"
			}
		}
		result += ordinalNumber0to999(last3)
	} else {
		result += "ste"
	}
	return result
}

func ordinalNumber0to999999(i int) string {
	if i < 100 {
		return ordinalNumber0to99(i)
	} else if i < 1000 {
		return ordinalNumber100to999(i)
	} else if i < 1000000 {
		return ordinalNumber1000to999999(i)
	} else {
		return ""
	}
}

func main() {
	startPtr := flag.Int("s", 0, "start number from")
	endPtr := flag.Int("e", 0, "count until value")
	isOrdinalPtr := flag.Bool("o", false, "print ordinal numbers instad of cardinals")
	showUsagePtr := flag.Bool("h", false, "show usage help")
	verboseEinPtr := flag.Bool("ein", false, "verbose ein in einhundert, eintausend etc.")
	verboseUndPtr := flag.Bool("und", false, "verbose und in hundertundeins, tausendundzwei etc.")
	verboseUseParenthesesPtr := flag.Bool("p", false, "use parentheses in (ein)hundert, tausend(und)zwei etc.")
	verboseDigitsPtr := flag.Bool("d", false, "print number also in digits at the beginning of the line")

	flag.Parse()

	if *showUsagePtr {
		os.Stderr.WriteString("Usage:\n")
		flag.PrintDefaults()
		os.Exit(0)
	}

	start := *startPtr
	end := *endPtr
	isOrdinal := *isOrdinalPtr

	verboseEin = *verboseEinPtr
	verboseUnd = *verboseUndPtr
	verboseUseParentheses = *verboseUseParenthesesPtr
	verboseDigits := *verboseDigitsPtr

	if end < start {
		os.Stderr.WriteString("Warning: Start value must be lower than end!\n")
		os.Stderr.WriteString("Setting end value to start value = " + strconv.Itoa(start) + "\n")
		end = start
	}

	if verboseEin || verboseUnd {
		os.Stderr.WriteString("Verbose on: ")
		if verboseEin {
			if verboseUseParentheses {
				os.Stderr.WriteString("(ein)")
			} else {
				os.Stderr.WriteString("ein")
			}
		}
		if verboseUnd {
			if verboseUseParentheses {
				os.Stderr.WriteString(", (und)")
			} else {
				os.Stderr.WriteString(", und")
			}
		}
		os.Stderr.WriteString("\n")
	}

	if !isOrdinal {
		os.Stderr.WriteString("Generating 'cardinal' numbers from " +
			strconv.Itoa(start) + " to " + strconv.Itoa(end) + "\n")

		for i := start; i <= end; i++ {
			if verboseDigits {
				fmt.Println(i, "=", cardinalNumber0to999999(i))
			} else {
				fmt.Println(cardinalNumber0to999999(i))
			}
		}
	} else {
		os.Stderr.WriteString("Generating 'ordinal' numbers from " +
			strconv.Itoa(start) + " to " + strconv.Itoa(end) + "\n")

		for i := start; i <= end; i++ {
			if verboseDigits {
				fmt.Println(i, "=", ordinalNumber0to999999(i))
			} else {
				fmt.Println(ordinalNumber0to999999(i))
			}
		}
	}
}
