library(tidyverse)
library(here)
library(ggrepel)

# Read in RPKM of Metatranscriptomic reads to MAGs
tx_rpkm <-read_csv(here("SI072_120m_metaT_rpkm.renamed.processed.csv"))

# Read in RPKM of Metagenomic reads to MAGs
gen_rpkm <- read_csv(here("SaanichInlet_120m_binned.rpkm.renamed.processed.csv"))

# Read in a vector of High Quality MAGs
hq <- scan(here("HQmags.renamed.txt"), character(), quote = "")

# Read in a vector of Medium Quality MAGs
mq <- scan(here("MedQmags.renamed.txt"), character(), quote = "")

# Sum up RPKMs per MAG instead of per contig for metaT
tx_rpkm <- separate(tx_rpkm,Sequence, c("MAG", "Contig"), sep="_") %>%
  group_by(MAG) %>%
  summarise(Metatranscriptomic= sum(RPKM))

# Sum up RPKMs per MAG instead of per contig for metaG
gen_rpkm <- gen_rpkm %>%
  drop_na() %>%
  separate(Sequence_name, c("MAG", "Contig"), sep="_") %>%
  group_by(MAG) %>%
  summarise(Metagenomic = sum(RPKM))

# Combine the two dataframes with left join, meaning only adding information to instances in the metaT
# choice of left join since tx_rpkm contains only 81 MedQPlus MAGS whereas the metaG contains all MAGs
combined <- left_join(tx_rpkm,gen_rpkm, by = "MAG")

# Create a new dataframe for MAGs where the metaT coverage is greater than metaG
combined_tx <- combined %>%
  filter(Metatranscriptomic > Metagenomic)

# Create a new dataframe for MAGs where the metaG coverage is greater than metaT
combined_gen <- combined %>%
  filter(Metagenomic > Metatranscriptomic)

# Pivot longer and add a column for quality
combined_wider <- pivot_longer(combined, cols=c(-MAG), names_to = "Source") %>%
  mutate(Quality = case_when(MAG %in% hq ~ "High Quality",
                             MAG %in% mq ~ "Medium Quality",
                             TRUE ~ "Low Quality"))

# Without semi_join: plot all 81 MedQPlus MAGs 
# With semi_join: plot only the MAGs where the metaT coverage > metaG
# with filter: plot only the HQ MAGs of the same scenario, and then no need to facet by two.
combined_wider %>%
#  semi_join(combined_tx, by = "MAG") %>%
#  filter(MAG %in% hq) %>%
  ggplot(aes(MAG, value, fill = Source)) +
  geom_col(position="dodge", show.legend = FALSE) +
  facet_grid(Source ~ Quality) +
#  facet_wrap(~ Source) +
  theme(text = element_text(size = 18),
        axis.text.x = element_text(angle = 90, size =8)) +
  labs(x = "Metagenomic Assembly (MAG)",
       y = "RPKM",
       title = "Metagenomic vs Metatranscriptomic RPKM Values")

ggsave(here("coverage.png"), device = "png", width=16, height = 9, units = "in", dpi = 300)
# Without semi_join: plot all 81 MedQPlus MAGs
# with semi_join: plot only the MAGs hwere the metaG coverage > metaT
# with filter: plot only the HQ MAGs of the same scenario
combined_wider %>%
#  semi_join(combined_gen, by = "MAG") %>%
  filter(MAG %in% hq) %>%
  mutate(value = round(value, digits =0)) %>%
  ggplot(aes(MAG, value, fill = Source)) +
  geom_col(position="dodge") +
  theme(legend.position = "bottom") +
  labs(x = "Metagenomic Assembly (MAG)",
       y = "RPKM",
       title = "Metagenomic vs Metatranscriptomic RPKM Values in High Quality MAGs") +
  geom_text(aes(label = value), position = position_dodge(width = 1), vjust = -0.5, size = 6) +
  theme(text = element_text(size =18))

ggsave(here("hq_cov.png"), device = "png", width=16, height = 9, units = "in", dpi = 300)
