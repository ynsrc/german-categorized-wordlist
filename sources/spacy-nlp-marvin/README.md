# Marwin JWendt's Wordlist with Spacy NLP

This folder contains Marvin's uncategorized wordlist and generated categorized wordlist which generated with Spacy NLP.

# Installing And Preparing Spacy NLP
```
pip install -U pip setuptools wheel cupy-cuda12x
pip install -U "spacy[cuda12x]"
python -m spacy download de_core_news_md
```

# Generating Categorized Wordlist File

```python
import spacy
spacy.require_gpu()
nlp = spacy.load("de_core_news_md")

import de_core_news_md
spacy.require_gpu()
nlp = de_core_news_md.load()

fin = open("marvin.txt", "r")
fout = open("spacy-nlp-marvin.txt", "w")

for line in fin:
  w = nlp(line)[0]
  word = w.text
  word_type = w.pos_
  fout.write(word + "; " + word_type + "; " + str(w.morph) + "\n")

fin.close()
fout.close()
```


# Attributions
* https://gist.github.com/MarvinJWendt/2f4f4154b8ae218600eb091a5706b5f4
* https://github.com/explosion/spaCy


# License
Attribution-ShareAlike 4.0 International


## License Warning
Most of data in this folders are not belong to us.
Please refer the owner licenses if you want to use them.
