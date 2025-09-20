## september 2025
## author: avardanega@unite.it

library(tidyverse)

swn_it_tidy <- read_csv("data/swn_it_tidy/swn_it_tidy.csv")

## Frase di esempio
# "Questa giornata è iniziata con un bellissimo sole, ma un evento 
# terribile ha rovinato tutto. Che peccato."

# dataframe with lemmas from the example sentence
lemmi_esempio <- tibble(
  id = 1,
  lemma = c("questo", "giornata", "iniziare", "con", "un", 
             "bello", "sole", "ma", "un", "evento", "terribile", 
             "rovinare", "tutto", "che", "peccato")
)

print(lemmi_esempio)

# --- Join ---

lemmi_esempio %>%
  inner_join(swn_it_tidy, by = "lemma")

# left join to keep all lemmas: some rows will have NA
sentiment_frase <- lemmi_esempio %>%
  left_join(swn_it_tidy, by = "lemma")

print(sentiment_frase)

# --- Sentiment score by document ---

# sentiment profile by document
sentiment_frase %>%
  group_by(id) %>%
  summarise(
    pos_score = mean(pos_score, na.rm = TRUE),
    neg_score = mean(neg_score, na.rm = TRUE),
    obj_score = mean(obj_score, na.rm = TRUE)
  )

# overall sentiment score by document 
sentiment_frase %>%
  group_by(id) %>%
  summarise(
    mean_score = mean(pos_score, na.rm = T) - mean(neg_score, na.rm = T)
  )





