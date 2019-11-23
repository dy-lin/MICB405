library(tidyverse)
library(here)

summary <- read_tsv(here("prokka.summary.tsv"))

# complete the missing data
summary <- summary %>% 
  complete(MAG,Feature) 

summary[is.na(summary)] <- 0

summary <- summary %>%
  pivot_wider(id_cols = MAG, names_from = Feature, values_from = Number)

summary$total <- rowSums(summary[,-1])

# summary %>%
#   ggplot(aes(MAG, Number)) +
#   geom_col(aes(fill = Feature), position="fill", stat="identity")
