## Custom dataset based on swn_it
## september 2025
## author: avardanega@unite.it


# to change the treatment of the lemmi_it column --------------------

library(tidyverse)
swn_it <- read_csv("data/swn_it/swn_it.csv")

my_swn_df <- swn_it %>%
  # remove GAP and PSEUDOGAP from lemmi_it column
  # rimuovi GAP and PSEUDOGAP dalla colonna lemmi_it
  mutate(lemmi_it = sapply(strsplit(lemmi_it, ", "), function(lemmas) {
      paste(lemmas[!lemmas %in% c("GAP!", "PSEUDOGAP!")], collapse = ", ")
    })) %>%
  # remove rows where lemmi_it is empty
  # rimuove le righe dove lemmi_it è vuota
  filter(lemmi_it != "") %>% 
  # separate lemmi_it into multiple rows
  # separa lemmi_it in più righe
  separate_longer_delim(lemmi_it, ", ")

# The resulting dataframe has 62,125 rows