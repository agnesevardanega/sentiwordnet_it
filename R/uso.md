---
title: "Uso del dataset in R"
author: "Agnese Vardanega <avardanega@unite.it"
date: "2025-09-18
---

# Uso del dataset in R

## Dati di esempio

Il dataset "tidy" (`swn_it_tidy.csv`) è progettato per essere facilmente utilizzabile in R. 

```r
# pacchetti
library(tidyverse)
# caricamento del dataset
swn_it_tidy <- read_csv("data/swn_it_tidy/swn_it_tidy.csv")
```

Consideriamo il dataset dei lemmi per la frase: "Questa giornata è iniziata con un bellissimo sole, ma un evento terribile ha rovinato tutto. Che peccato."

```r
# tibble con identificativo di documento e lemmi
# in questo caso, abbiamo un solo documento (id = 1)
lemmi_esempio <- tibble(
  id = 1,
  lemma = c("questo", "giornata", "iniziare", "con", "un",  
            "bello", "sole", "ma", "un", "evento", "terribile", 
            "rovinare", "tutto", "che", "peccato")
)
```
```r
head(lemmi_esempio)
```
```
# A tibble: 6 × 2
     id lemma   
  <dbl> <chr>   
1     1 questo  
2     1 giornata
3     1 iniziare
4     1 con     
5     1 un      
6     1 bello 

```

## Uso del lessico

Per associare a ogni lemma i punteggi, è possibile usare le funzioni della famiglia `_join` del pacchetto `dplyr`. 

Con **`inner_join`** le righe dei lemmi che non sono nel lessico vengono eliminate nel dataset dei risultati. Non si avranno `NA`, ma si perderanno eventuali informazioni aggiuntive, contenute nel dataset originale.

```r
lemmi_esempio %>%
  inner_join(swn_it_tidy, by = "lemma")
```

```
# A tibble: 11 × 5
      id lemma     pos_score neg_score obj_score
   <dbl> <chr>         <dbl>     <dbl>     <dbl>
 1     1 questo       0         0.188      0.812
 2     1 giornata     0         0          1    
 3     1 iniziare     0         0          1    
 4     1 bello        0.604     0.0208     0.375
 5     1 sole         0.25      0          0.75 
 6     1 ma           0         0          1    
 7     1 evento       0         0          1    
 8     1 terribile    0         0.625      0.375
 9     1 rovinare     0.0893    0.357      0.554
10     1 tutto        0.219     0.0625     0.719
11     1 peccato      0         0.312      0.688
```

Per un dataframe di risultato composto come quello dei lemmi, si può usare **`left_join`**:

```r
sentiment_frase <- lemmi_esempio %>%
  left_join(swn_it_tidy, by = "lemma")
```

## Punteggi complessivi

Profilo di sentiment per documento o segmento (`group_by(id)`):

```r
sentiment_frase %>%
  group_by(id) %>%
  summarise(
    pos_score = mean(pos_score, na.rm = TRUE),
    neg_score = mean(neg_score, na.rm = TRUE),
    obj_score = mean(obj_score, na.rm = TRUE)
  )
```

```
# A tibble: 1 × 4
     id pos_score neg_score obj_score
  <dbl>     <dbl>     <dbl>     <dbl>
1     1     0.114     0.138     0.749
```

Punteggio medio per documento:

```r
sentiment_frase %>%
  group_by(id) %>%
  summarise(
    mean_score = mean(pos_score, na.rm = T) - mean(neg_score, na.rm = T)
  )
```
```
# A tibble: 1 × 2
     id mean_score
  <dbl>      <dbl>
1     1    -0.0367
```