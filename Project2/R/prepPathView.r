library(tidyr)
library(dplyr)
library(pathview)
library(RColorBrewer)
library(knitr)
ko <- read.table("/projects/micb405/project1/Team10/project2/SaanichInlet_MAG120m_ORFs_ko.cleaned.txt") %>% 
  dplyr::rename(orf = V1) %>% 
  dplyr::rename(ko = V2)
metat_rpkm <- read.table("/projects/micb405/project1/Team10/project2/rpkm_output/SaanichInlet_120m_MAG_ORFs_rpkm.txt", header = F, sep=',') %>% 
  dplyr::rename(orf = V1) %>% 
  dplyr::rename(rpkm = V2)

prokka_mag_map <- read.table("/projects/micb405/project1/Team10/project2/Prokka_MAG_map.csv", header=F, sep=',') %>% 
  dplyr::rename(prokka_id = V1) %>% 
  dplyr::rename(mag = V2)

arc_class <- read.table("/projects/micb405/resources/project_2/2019/SaanichInlet_120m/MetaBAT2_SaanichInlet_120m/gtdbtk_output/gtdbtk.ar122.classification_pplacer.tsv", sep="\t")
bac_class <- read.table("/projects/micb405/resources/project_2/2019/SaanichInlet_120m/MetaBAT2_SaanichInlet_120m/gtdbtk_output/gtdbtk.bac120.classification_pplacer.tsv", sep="\t")
gtdb_dat <- rbind(arc_class, bac_class) %>% 
  dplyr::rename(mag = V1) %>% 
  separate(V2, sep=';', into=c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species"))

checkm_dat <- read.table("/projects/micb405/resources/project_2/2019/SaanichInlet_120m/MetaBAT2_SaanichInlet_120m/MetaBAT2_SaanichInlet_120m_min1500_checkM_stdout.tsv",
                         header=TRUE,
                         sep="\t",
                         comment.char = '') %>% 
  dplyr::rename(mag = Bin.Id) %>% 
  dplyr::select(mag, Completeness, Contamination)

# Due to a bug in the renaming script we have to rename the bins. Its a bit hacky but works using tidyverse functions
metag_rpkm <- read.table("/projects/micb405/resources/project_2/2019/SaanichInlet_120m/SaanichInlet_120m_binned.rpkm.csv", header=T, sep=',') %>% 
  mutate(Sequence = gsub('m_', 'm.', Sequence)) %>% 
  mutate(Sequence = gsub('Inlet_', 'Inlet.', Sequence)) %>% 
  separate(col=Sequence, into=c("mag", "contig"), sep='_', extra="merge") %>% 
  group_by(Sample, mag) %>% 
  summarise(g_rpkm = sum(RPKM)) %>% 
  mutate(mag = gsub('Inlet.', 'Inlet_', mag))

gtdb_dat %>% 
  group_by(Phylum) %>% 
  summarise(count = n_distinct(mag)) %>% 
  kable()

gtdb_dat <- dplyr::select(gtdb_dat, mag, Kingdom, Phylum, Class, Order, Family)

rpkm_dat <- left_join(ko, metat_rpkm, by="orf") %>%
  separate(orf, into=c("prokka_id", "orf_id")) %>% # Split the Prokka ORF names into MAG identifier and ORF number for joining
  left_join(prokka_mag_map, by="prokka_id") %>% 
  left_join(gtdb_dat, by="mag") %>% 
  left_join(checkm_dat, by="mag")

# If you also wanted to add the RPKM abundance values from the metagenome:
  # left_join(metag_rpkm, by="mag")

head(rpkm_dat) %>% kable()

# Subset by taxon
ko_rpkm <- rpkm_dat %>%
  filter(Phylum %in% c("p__Proteobacteria", "p__Nanoarchaeota", "p__Thermoplasmatota")) %>%
  group_by(mag, ko) %>% 
  summarise(t_rpkm = sum(rpkm)) %>% 
  spread(key = mag, value = t_rpkm)

# Subset by completeness and contamination
ko_rpkm <- rpkm_dat %>% 
  filter(Completeness >= 90 & Contamination < 5) %>% 
  group_by(mag, ko) %>% 
  summarise(t_rpkm = sum(rpkm)) %>% 
  spread(key = mag, value = t_rpkm)

# Aggregate by a taxonomy, still summing RPKM of each KO number. You could use mean() instead.
ko_rpkm <- rpkm_dat %>%
  group_by(Class, ko) %>% 
  summarise(t_rpkm = sum(rpkm)) %>% 
  spread(key = Class, value = t_rpkm)

pv_mat <- dplyr::select(ko_rpkm, -ko)
rownames(pv_mat) <- ko_rpkm$ko

# Nitrogen metabolism
pv.out <- pathview(gene.data = pv_mat,
                   limit = list(gene = c(0,10)),
                   low = list(gene = "#91bfdb"),
                   mid = list(gene = "#ffffbf"),
                   high = list(gene = "#fc8d59"),
                   species = "ko",
                   pathway.id="00910",
                   kegg.dir = "~/Desktop/MICB405_TAship/MICB405-Metagenomics/2018/")