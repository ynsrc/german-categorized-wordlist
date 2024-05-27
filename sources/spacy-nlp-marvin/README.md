# Marwin JWendt's Wordlist with Spacy NLP

This folder contains Marvin's uncategorized wordlist and generated categorized wordlist which generated with Spacy NLP.

# Installing And Preparing Spacy NLP
```
pip3 install spacy
python3 -m spacy download de_core_news_md
```

# Generating Categorized Wordlist File
```python
from tqdm import tqdm

import spacy
nlp = spacy.load("de_core_news_md")

import de_core_news_md
nlp = de_core_news_md.load()

words = []

with open("marvin.txt", "r", encoding="UTF-8") as infile:
  words = infile.readlines()

with open("spacy-nlp-marvin.txt", "w", encoding="UTF-8") as fout:
  for line_ in tqdm(words):
    line = line_.strip()
    w = nlp(line)[0]
    word = w.text
    word_type = w.pos_
    fout.write(word + "; " + word_type + "; " + str(w.morph) + "\n")


print("Completed")
```


# Attributions
* https://gist.github.com/MarvinJWendt/2f4f4154b8ae218600eb091a5706b5f4
* https://github.com/explosion/spaCy


# License
Attribution-ShareAlike 4.0 International


## License Warning
Most of data in this folders are not belong to us.
Please refer the owner licenses if you want to use them.
