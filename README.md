# SentiWordNet It (swn_it)


[![](https://img.shields.io/badge/License-CC%20BY%20SA%204.0-orange.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

A sentiment lexical resource for italian, based on SentiWordNet 3.0 and
MultiWordNet.

## Description

This repository contains a sentiment lexicon for Italian, based on
SentiWordNet 3.0 (Baccianella, Esuli, and Sebastiani 2010; Esuli
\[2019\] 2025) and MultiWordNet (Pianta, Bentivogli, and Girardi 2002).

The included files, in the `data/` folder are:

- **`swn_it.csv`**: A dataset of **35,001 Italian synsets** with
  polarity scores, POS, synset, offset, English synset lemmas, and gloss
  (in English).
- **`swn_it_tidy.csv`**: A *tidy* (*one token per row*) dataset of
  **41,725 lemmas**, with polarity scores. It is designed for use in R.

It also contains a folder with examples in R, and scripts to use and
manipulate the datasets:

- **`R/`**:
  - `custom_dataset.R`: Create a custom *tidy* dataset from the original
    one, treating duplicate entries differently.
  - `example.R`: Examples of how to use the dataset for sentiment
    analysis on a sample text.
  - `uso.md`: Instructions for using the dataset in R (in Italian),
    referred to in `example.R`.

## Methodology

### Sources

- **SentiWordNet**, based on WordNet 3.0. Repository:
  <https://github.com/aesuli/SentiWordNet>; License: [CC BY-SA
  3.0](https://creativecommons.org/licenses/by-sa/3.0/)
- **MultiWordNet** (Italian), aligned with WordNet 1.6. Website:
  <https://nlplab.fbk.eu/tools-and-resources/lexical-resources-and-corpora/multiwordnet>;
  License: [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/)

Access and alignment of these resources were performed using NLTK and
the library OMW - **Open Multilingual Wordnet** (Bond et al. 2023).

### Steps

The lexicon was generated following these steps:

- **Synset Mapping**: Each Italian synset in MultiWordNet was aligned
  with its counterpart in SentiWordNet 3.0 using the ***synset***
  **name** (e.g., “a_lot.r.01”).
- **Score Assignment**: The scores from each SentiWordNet synset were
  then assigned to the corresponding Italian synset.
- In the Italian lemmas field, the placeholders used in MultiWordNet to
  mark so-called “**lexical gaps**” (“GAP!” and “PSEUDOGAP!”) have been
  retained. These indicate that the synset is not “missing”: it was
  handled in MultiWordNet but has no lexical equivalent in Italian
  (Pianta, Bentivogli, and Girardi 2002).
- The synset terms are present in **both languages** (Italian and
  English) to facilitate any future comparisons.

## Dataset Format

The column naming follows the conventions of the NLTK package for
WordNet and SentiWordNet.

### Synset Dataset (`swn_it.csv`)

- **Encoding:** UTF-8
- **Separator:** Comma (`,`)

**Columns:**

- **`pos`**: The part of speech of the synset. Possible values are:
  - n: noun
  - v: verb
  - a: adjective
  - r: adverb
- **`offset`**: The unique numerical identifier of a synset within a
  specific version of WordNet. It is the recommended ID for join and
  lookup operations within the same version and is used together with
  the `pos`.
- **`synset`**: The symbolic and human-readable name
  (`lemma.pos.sense_number`). This identifier is more stable across
  versions than the offset, which may be reassigned during WordNet
  updates (cf. Kafe 2017). The Italian WordNet has not been updated
  beyond version 1.6, so this information may be important (cf. Basile
  and Nissim 2013).
- **`pos_score`**: The positivity score of the synset, ranging from 0.0
  to 1.0.
- **`neg_score`**: The negativity score of the synset, ranging from 0.0
  to 1.0.
- **`obj_score`**: The objectivity score of the synset, ranging from 0.0
  to 1.0. This score is calculated as:
  `obj_score = 1.0 - (pos_score + neg_score)`.
- **`lemmi_it`**: Italian lemmas (*terms*) belonging to the synset,
  separated by commas (with original capitalization).
- **`lemmi_en`**: English lemmas (*terms*) belonging to the synset,
  separated by commas (with original capitalization).
- **`gloss`**: The definition of the synset, providing semantic context
  for the associated lemmas.

### “Tidy” Lemma Dataset (`swn_it_tidy.csv`)

Each row represents a single term (lemma) with its corresponding scores.
Capitalization and duplicate entries have been removed by calculating
the average scores for each repeated lemma. Consequently, the `pos` tag
no longer applies.

- **Encoding:** UTF-8
- **Separator:** Comma (`,`)

**Columns:**

- **`lemma`**: The term (word) in Italian, in lowercase.
- **`pos_score`**: The positivity score of the synset, ranging from 0.0
  to 1.0.
- **`neg_score`**: The negativity score of the synset, ranging from 0.0
  to 1.0.
- **`obj_score`**: The objectivity score of the synset, ranging from 0.0
  to 1.0.This score is calculated as:
  `obj_score = 1.0 - (pos_score + neg_score)`.

However, it is possible to reconstruct the *tidy* dataset from the
original dataset, treating duplicate entries differently.

See the script `custom_dataset.R` in the `R` folder for details.

## License

This dataset is released under the [Creative Commons Attribution 4.0
International (CC BY SA 4.0)
License](https://creativecommons.org/licenses/by-sa/4.0/).

## References

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0">

<div id="ref-baccianella_sentiwordnet_2010" class="csl-entry">

Baccianella, Stefano, Andrea Esuli, and Fabrizio Sebastiani. 2010.
“Sentiwordnet 3.0: An Enhanced Lexical Resource for Sentiment Analysis
and Opinion Mining.” In *Lrec*, 10:2200–2204. 2010. Valletta.
<http://lrec-conf.org/proceedings/lrec2010/pdf/769_Paper.pdf>.

</div>

<div id="ref-basile_sentiment_2013" class="csl-entry">

Basile, Valerio, and Malvina Nissim. 2013. “Sentiment Analysis on
Italian Tweets.” In *Proceedings of the 4th Workshop on Computational
Approaches to Subjectivity, Sentiment and Social Media Analysis*,
100–107.

</div>

<div id="ref-bond_documenting_2023" class="csl-entry">

Bond, Francis, Michael Wayne Goodman, Ewa Rudnicka, Luis Morgado da
Costa, Alexandre Rademaker, and John P. McCrae. 2023. “Documenting the
Open Multilingual Wordnet.” In *Proceedings of the 12th Global Wordnet
Conference*, edited by German Rigau, Francis Bond, and Alexandre
Rademaker, 150–57. University of the Basque Country, Donostia - San
Sebastian, Basque Country: Global Wordnet Association.
<https://aclanthology.org/2023.gwc-1.18/>.

</div>

<div id="ref-denecke_using_2008" class="csl-entry">

Denecke, Kerstin. 2008. “Using Sentiwordnet for Multilingual Sentiment
Analysis.” In *2008 IEEE 24th International Conference on Data
Engineering Workshop*, 507–12. IEEE.
<https://ieeexplore.ieee.org/abstract/document/4498370/>.

</div>

<div id="ref-esuli_aesuli_2019" class="csl-entry">

Esuli, Andrea. (2019) 2025. “Aesuli/SentiWordNet.”
<https://github.com/aesuli/SentiWordNet>.

</div>

<div id="ref-kafe_how_2017" class="csl-entry">

Kafe, Eric. 2017. “How Stable Are WordNet Synsets?” In *LDK Workshops*,
113–24. <https://ceur-ws.org/Vol-1899/CfWNs_2017_proc1-paper_1.pdf>.

</div>

<div id="ref-pianta_multiwordnet_2002" class="csl-entry">

Pianta, Emanuele, Luisa Bentivogli, and Christian Girardi. 2002.
“MultiWordNet: Developing an Aligned Multilingual Database.” In *First
International Conference on Global WordNet*, 293–302.
<https://cris.fbk.eu/handle/11582/499>.

</div>

</div>
