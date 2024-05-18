# Wiktionary Extractor
# This script extracts dewiktionary pages-articles.xml dump to a single text file

import argparse
from xml.etree import cElementTree as ET

parser = argparse.ArgumentParser()
parser.add_argument('-i', '--input', required=True, help="input xml file")
parser.add_argument('-o', '--output', required=True, help='output txt file')
args = parser.parse_args()

print(f"Input file: {args.input}")
print(f"Output file: {args.output}")

print("Extracting, please wait...")

with open(args.input, "r", encoding="UTF-8") as xml_file:
    with open(args.output, "w", encoding="UTF-8") as page_file:
        parser = ET.XMLPullParser(["start", "end"])
        in_page = False
        page_id = ""
        parent_id = ""
        page_title = ""
        for line in xml_file:
            parser.feed(line)
            for event_ns, elem_ns in parser.read_events():
                event = event_ns.split(' ')[0]
                tag = elem_ns.tag.split('}')[-1]
                text = elem_ns.text

                if tag == "page":
                    in_page = event == "start"
                    page_id, parent_id, page_title = "", "", ""
                
                if in_page and event == "end":
                    if tag == "title" and text is not None:
                        page_title = elem_ns.text
                    
                    if tag == "id" and len(page_id) == 0 and text is not None:
                        page_id = elem_ns.text

                    if tag == "parentid" and len(parent_id) == 0 and text is not None:
                        parent_id = elem_ns.text
                    
                    if tag == "text" and not len(page_title) == 0 and text is not None:
                        if text.count("({{Sprache|Deutsch}})") > 0 and not page_title.startswith("Wiktionary:"):
                            page_file.write(f"\n\n/*---------- title: {page_title}, id: {page_id}, parent_id: {parent_id} ----------*/\n\n")
                            page_file.write(text)

print("Completed!")
