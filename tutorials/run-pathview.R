# Diana Lin
# MICB405 Pathview Tutorial
# October 22, 2019

library(tidyr)
library(dplyr)
library(pathview)
library(RColorBrewer)
library(knitr)

ko <- read.table("~/MICB405/Project2/KAAS/SaanichInlet_HQ_MAG_ORFs_ko.cleaned.txt") %>%
	dplyr::rename(orf = V1) %>%
	dplyr::rename(ko = V2)

metat_rpkm <- read.table("~/MICB405/Project2/R/SI072_120m_metaT_rpkm.csv", sep=",") %>%
	dplyr::rename(orf = V1) %>%
	dplyr::rename(rpkm = V2)

prokka_mag_map <- read.table("~/MICB405/Project2/csv/prokka_MAG_map.csv", sep=",") %>%
	dplyr::rename(prokka_id = V1) %>%
	dyplr::rename(mag = V2)

arc_class <- read.table("~/MICB405/Project2/R/gtdbtk.ar122.classification_pplacer.tsv", sep="\t")
bac_class <- read.table("~/MICB405/Project2/R/gtdbtk.bac120.classification_pplacer.tsv", sep="\t")
gtdb_dat <- rbind(arc_class, bac_class) %>%
	dplyr::rename(mag = V1) %>%
	separate(V2, sep=";", into=c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species"))

checkm_dat <- read.table("~/MICB405/Project2/R/MetaBAT2_SaanichInlet_120m_min1500_checkM_stdout.tsv", header = TRUE, sep="\t", comment.char="") %>%
	dplyr::rename(mag = Bin.Id) %>%
	dplyr::select(mag, Completeness, Contamination)

metag_rpkm <- read.table("~/MICB405/Project2/R/SaanichInlet_120m_binned.rpkm.csv", header = T, sep=",") %>%
	mutate(Sequence = gsub("m_", "m.", Sequence)) %>%
	mutate(Sequence = gusb("Inlet_", "Inlet.", Sequence)) %>%
	separate(col = Sequence, into = c("mag", "contig"), sep="_", extra="merge") %>%
	group_by(Sample, mag) %>%
	summarise(g_rpkm = sum(rpkm)) %>%
	mutate(mag= gsub("Inlet.", "Inlet_", mag))

gtdb_dat %>%
	group_by(Phlyum) %>%
	summarise(count = n_distinct(mag)) %>%
	kable()

gtdb_dat <- dplyr::select(gtdb_dat, mag, Kingdom, Phylum, Class, Order, Family)

rpkm_dat <- left_join(ko, metat_rpkm, by="orf") %>%
	separate(orf, into=c("prokka_id", "orf_id")) %>%
	left_join(prokka_mag_map, by="prokka_id") %>%
	left_join(gtdb_dat, by="mag") %>%
	left_join(checkm_dat, by="mag")

ko_rpkm <- rpkm_dat %>%
	filter(Phylum %in% c("p__Proteobacteria", "p__Nanoarchaeota", "p__Thermoplasmatota")) %>%
	group_by(mag, ko) %>%
	summarise(t_rpkm = sum(rpkm)) %>%
	spread(key = mag, value = t_rpkm)

ko_rpkm <- rpkm_dat %>%
	filter(Completeness > 90 & Contamination < 5) %>%
	group_by(mag, ko) %>%
	summarize(t_rpkm = sum(rpkm)) %>%
	spread(key = mag, value = t_rpkm)

ko_rpkm <- rpkm_dat %>%
	group_by(Class, ko) %>%
	summarise(t_rpkm = sum(rpkm)) %>%
	spread(key= Class, value = t_rpkm)

pv_mat <- dplyr::select(ko_rpkm, -ko)
rownames(pv_mat) <- ko_rpkm$ko

pv.out <- pathview(gene.data = pv.mat,
				   limit = list(gene=c(0,10)),
				   low = list(gene = "#91bfdb"),
				   mid = list(gene = "#ffffbf"),
				   high = list(gene = "#fc8d59"),
				   species = "ko",
				   pathway.id="00910",
				   kegg.dir = "~/MICB405/Project2/R/")


