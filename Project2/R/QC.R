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


merged <- left_join(checkM,rpkm, by = "MAG")

hq <- merged %>%
  filter(Contamination < 5 & Completeness > 90)

merged %>%
  ggplot(aes(Completeness,Contamination, colour = `Marker lineage`)) +
  geom_point() +
  geom_point(aes(size = RPKM)) +
  ylim(0,30) +
  labs (x = "Completeness (%)", x = "Contamination (%)", colour = "Taxonomy") +
  geom_vline(xintercept = c(50,70,90), linetype = 2, colour = "dimgrey") +
  geom_hline(yintercept = c(5,10,15), linetype = 2, colour = "dimgrey") +
  geom_rect(xmin = 90, xmax = 100, ymin = 0, ymax = 5, fill = NA, show.legend = FALSE, colour = "red")# +
#  scale_size_continuous(limits=c(0,3000)) 

ggsave(here("QC_plot.png"), device = "png", width = 12, height = 8)
