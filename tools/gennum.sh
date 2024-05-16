#!/bin/bash

# Generate Numbers as Text in German Language

# NOTE: This is a funny and heavy way to converting numbers
# to text with bash scripting. Another programming languages
# can be more too much faster than this!

# Example Usage:
# bash gennum.sh -s1000 -e2000

START=0
END=0
TYPE="ordinal"
DECLENSIONS=0

if [ $# -eq 0 ]; then
    echo "Usage: $0 [-s][-e][-o|c][-d]" 1>&2
    echo "  -s: start number" 1>&2
    echo "  -e: end number" 1>&2
    echo "Number Types:" 1>&2
    echo "  -o: ordinal numbers (default)" 1>&2
    echo "  -c: cardinal numbers" 1>&2
    echo "Other:" 1>&2
    echo "  -d: with declensions (-r, -n etc.)" 1>&2
    echo "Examples: " 1>&2
    echo " $0 -s0 -e1000" 1>&2
    exit 1
fi

while getopts "s:e:ocd" opt; do
  case ${opt} in
  s) START=${OPTARG} ;;
  e) END=${OPTARG} ;;
  o) TYPE="ordinal" ;;
  c) TYPE="cardinal" ;;
  d) DECLENSIONS=1 ;;
  ?)
    echo "Error: illegal argument -${OPTARG}" 1>&2
    exit 1
  ;;
  esac
done

echo -n "Generating '${TYPE}' numbers from ${START} to ${END}" 1>&2
if [ $DECLENSIONS -eq 1 ]; then echo -n " (with declensions)" 1>&2; fi
echo 

if [ $END -lt $START ]; then
  END=$START
  echo "Warning: Start value must be lower than end value!" 1>&2
  echo "Setting end value to start value ($START)" 1>&2
fi

ordinal_number_0_to_19() {
  case $1 in
    0) echo -n "null" ;;
    1) echo -n "eins" ;;
    2) echo -n "zwei" ;;
    3) echo -n "drei" ;;
    4) echo -n "vier" ;;
    5) echo -n "fünf" ;;
    6) echo -n "sechs" ;;
    7) echo -n "sieben" ;;
    8) echo -n "acht" ;;
    9) echo -n "neun" ;;
    10) echo -n "zehn" ;;
    11) echo -n "elf" ;;
    12) echo -n "zwölf" ;;
    13) echo -n "dreizehn" ;;
    14) echo -n "vierzehn" ;;
    15) echo -n "fünfzehn" ;;
    16) echo -n "sechzehn" ;;
    17) echo -n "siebzehn" ;;
    18) echo -n "achtzehn" ;;
    19) echo -n "neunzehn" ;;
  esac
}

ordinal_number_decade() {
  case $1 in
  20) echo -n "zwanzig" ;;
  30) echo -n "dreißig" ;;
  40) echo -n "vierzig" ;;
  50) echo -n "fünfzig" ;;
  60) echo -n "sechzig" ;;
  70) echo -n "siebzig" ;;
  80) echo -n "achtzig" ;;
  90) echo -n "neunzig" ;;
  esac
}

ordinal_number_20_to_99() {
  decade=$(($1 / 10 * 10))
  ones_digit=$(($1 % 10))
  if [ $ones_digit -eq 1 ]; then
    echo -n "ein"
  elif [ $ones_digit -gt 0 ]; then
    echo -n $(ordinal_number_0_to_19 $ones_digit)
  fi
  if [ $(($1 - $decade)) -gt 0 ]; then
    echo -n "und"
  fi
  echo $(ordinal_number_decade $decade)
}

ordinal_number_0_to_99() {
  last2=$(($1 % 100))
  if [ $last2 -lt 20 ]; then
    echo $(ordinal_number_0_to_19 $last2)
  elif [ $last2 -ge 20 ] && [ $last2 -lt 100 ]; then
    echo $(ordinal_number_20_to_99 $last2)
  fi
}

ordinal_number_100_to_999() {
  hundred_digit=$(($1 / 100))
  last2=$(($1 % 100))
  if [ $hundred_digit -eq 1 ]; then
    echo -n "ein"
  else
    echo -n $(ordinal_number_0_to_19 $hundred_digit)
  fi
  if [ $hundred_digit -gt 0 ]; then
    echo -n "hundert"
  fi
  if [ $last2 -gt 0 ]; then
    echo -n $(ordinal_number_0_to_99 $last2)
  fi
}

ordinal_number_0_to_999() {
  if [ $1 -lt 100 ]; then
    echo -n $(ordinal_number_0_to_99 $1)
  elif [ $1 -le 1000 ]; then
    echo -n $(ordinal_number_100_to_999 $1)
  fi
}

ordinal_number_1000_to_999999() {
  tausends=$(($1 / 1000))
  last3=$(($1 % 1000))
  if [ $tausends -eq 1 ]; then
    echo -n "ein"
  else
    echo -n $(ordinal_number_0_to_999 $tausends)
  fi
  if [ $tausends -gt 0 ]; then
    echo -n "tausend"
  fi
  if [ $last3 -gt 0 ]; then
    echo -n $(ordinal_number_0_to_999 $last3)
  fi
}

ordinal_number_0_to_999999() {
  if [ $1 -lt 100 ]; then
    echo -n $(ordinal_number_0_to_99 $1)
  elif [ $1 -lt 1000 ]; then
    echo -n $(ordinal_number_100_to_999 $1)
  elif [ $1 -lt 1000000 ]; then
    echo -n $(ordinal_number_1000_to_999999 $1)
  fi
}

for ((i=$START; i<=$END; i++)); do
  echo "$i = $(ordinal_number_0_to_999999 $i)"
done;

