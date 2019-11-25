library(tidyverse)
library(here)

summary <- read_tsv(here("prokka.summary.tsv"))

# complete the missing data
summary <- summary %>% 
  complete(MAG,Feature) 

summary_tsv <- summary %>%
  pivot_wider(id_cols = MAG, names_from = Feature, values_from = Number)

summary_tsv[is.na(summary_tsv)] <- 0

summary_tsv$total <- rowSums(summary_tsv[,-1])

write_tsv(summary_tsv, here("prokka.summary.processed.tsv"))


summary %>%
  ggplot(aes(MAG, Number)) +
  geom_col(aes(fill = Feature)) +
  facet_wrap( ~ Feature, nrow = 4, scale = "free_y") +
  geom_text(aes(label = Number), vjust=1.5) +
  labs(x = "Metagenomic Assembly (MAG)",
       y = "Count",
       title = "Number of Predicted Genes")

ggsave(here("Prokka_genes.png"))
