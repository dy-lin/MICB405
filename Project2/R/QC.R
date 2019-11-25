library(tidyverse)
library(here)
library(plotly)
library(ggrepel)

# CONCERNS:
# metaT RPKM values that Sean generated are only for 81 MAGs that are MedQ+, but the plot contains other MAGs, where NA will not be plotted but a value of 0 is deceptive
# I think maybe instead of the metaT RPKMs maybe we're supposed to use genomic, aka SaanichInlet_120m_binned.rpkm.csv

# The Taxonomy that they have in the sample plot has a similar issue, the full lineages using gtdbtk are only for MedQPlus mags
# All MAGs have a kingdom taxonomy which I guess we can use, but is definitely different from the sample plot.

# Also don't know how to do the external arrow thing....

set_here(getwd())
checkM <- read_tsv(here("MetaBAT2_SaanichInlet_120m_min1500_checkM_stdout.renamed.processed.tsv"))
checkM <- checkM %>%
  rename(MAG = "Bin Id")
rpkm <- read_csv(here("SI072_120m_metaT_rpkm.renamed.csv"))
names(rpkm) <- c("Sample", "MAG", "RPKM")
rpkm<- separate(rpkm,MAG,c("MAG", "Contig"), sep = "_")
# rpkm[is.na(rpkm)] <- 0 ??
rpkm <- rpkm %>%
  group_by(MAG) %>%
  summarise(RPKM = sum(RPKM))

gtdbtk <- read_tsv(here("gtdbtk.both.classiication_pplacer.renamed.processed.tsv"), col_names = FALSE)

gtdbtk <- gtdbtk %>%
  separate(X2, c(NA,"Domain"), sep="__") %>%
  separate(X3, c(NA, "Phylum"), sep = "__") %>%
  separate(X4, c(NA, "Class"), sep = "__") %>%
  separate(X5, c(NA, "Order"), sep = "__") %>%
  separate(X6, c(NA, "Family"), sep = "__") %>%
  separate(X7, c(NA, "Genus"), sep = "__") %>%
  separate(X8, c(NA, "Species"), sep = "__") %>%
  rename(MAG = X1)

gtdbtk[gtdbtk==""] <- NA

merged <- checkM %>%
  select(c(-`Marker lineage`)) %>%
  left_join(rpkm, by = "MAG")

merged <- left_join(merged,gtdbtk, by = "MAG")

hq <- merged %>%
  filter(Contamination < 5 & Completeness > 90)

hq_rel <- hq %>%
  select(c(MAG,Completeness, Contamination,RPKM, Domain, Phylum, Class, Order, Family, Genus, Species)) %>%
  mutate(Taxonomy = paste(Domain, Phylum, Class, Order, Family, Genus, Species))

write_tsv(hq_rel, here("HQ_QC_RPKM_Taxonomy.tsv"))

merged %>%
  ggplot(aes(Completeness,Contamination, colour = Phylum, text = MAG)) +
  geom_point() +
  geom_point(aes(size = RPKM)) +
  ylim(0,30) +
  labs (x = "Completeness (%)", y = "Contamination (%)", colour = "Phylum", title = "Quality Control of All MAGs") +
  geom_vline(xintercept = c(50,70,90), linetype = 2, colour = "dimgrey") +
  geom_hline(yintercept = c(5,10,15), linetype = 2, colour = "dimgrey") +
  geom_rect(xmin = 90, xmax = 100, ymin = 0, ymax = 5, fill = NA, show.legend = FALSE, colour = "red") +
  theme(text = element_text(size = 18)) + 
  guides(
    size = guide_legend(order = 1),
    colour = guide_legend(order =2)
  )
#  scale_size_continuous(limits=c(0,3000)) 

ggsave(here("QC_plot.png"), device = "png", width = 16, height = 9, units = "in", dpi = 300)

hq %>%
  ggplot(aes(Completeness,Contamination, colour = Phylum, text = MAG)) +
  geom_point(aes(size = RPKM)) +
  ylim(0,5) +
  xlim(90,100) +
  labs (x = "Completeness (%)", y = "Contamination (%)", colour = "Phylum", title = "Quality Control of High Quality MAGs") +
  geom_vline(xintercept = c(50,70,90), linetype = 2, colour = "dimgrey") +
  geom_hline(yintercept = c(5,10,15), linetype = 2, colour = "dimgrey") +
#  geom_rect(xmin = 90, xmax = 100, ymin = 0, ymax = 5, fill = NA, show.legend = FALSE, colour = "red") +
  theme(text = element_text(size = 18)) +
#  scale_size_continuous(limits=c(0,3000)) 
  geom_label_repel(aes(label = MAG), show.legend = FALSE, size = 8, nudge_y = 0.3, nudge_x = 0.3) +
  guides(
    size = guide_legend(order = 1),
    colour = guide_legend(order =2)
  )

ggsave(here("HQ_QC_plot.png"), device = "png", width = 16, height = 9, units = "in", dpi = 300)
