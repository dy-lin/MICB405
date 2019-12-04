# Diana Lin
# MICB405 DESeq2 tutorial
# October 18, 2019

library(DESeq2)
library(tidyverse)
library(pheatmap)
library(RColorBrewer)

dir <- "/projects/micb405/resources/DESeq2_tutorial"
sample_metadata <- read_csv(file.path(dir, "samples.csv"))

files <- paste0(file.path(dir, sample_metadata$sample), ".htseq.out")

file.exists(files)

all(files.exists(files))

sample_df <- data.frame(sampleName = sample_metadata$sample,
						fileName = files,
						condition = sample_metadata$condition)

ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sample_df,
									   design = ~ condition)

ddsHTSeq$condition <- relevel(ddsHTSeq$condition, ref = "control")

dds <- DESeq(ddsHTSeq)

rld <- rlog(dds)

plotPCA(rld, intgroup = "condition")

sample_dists <- dist(t(assay(rld)))
sample_dist_matrix <- as.matrix(sample_dists)
colnames(sample_dist_matrix) <- NULL
colours <- colorRampPalete(rev(brewer.pal(9, "Blues"))(255))
pheatmap(sample_dist_matrix,
		 clustering_distance_rows = sample_dists,
		 clustering_distance_cols = sample_dists,
		 col = colours)

resultsNames(dds)

res <- results(dds, name = "condition_treatment_vs_control")

significant_res <- subset(res, padj < 0.05)
write.csv(as.data.frame(significant_res), file = "treat_vs_control_05.csv")
