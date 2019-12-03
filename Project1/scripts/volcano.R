# Plot Volcano

# import packages
library(tidyverse)
library(plotly)
library(ggrepel)

# import the DESeq output as a dataframe
de <- read_csv("/projects/micb405/project1/Team10/DESeq2_output/primary_vs_control_naive_deseq2.csv")
de <- rename(de, Gene = X1)
gene_dict <- read.csv("/projects/micb405/project1/Team10/CistromeGO/combined/gene_dict.csv", header = FALSE)

jak_stat <- scan("/projects/micb405/project1/Team10/CistromeGO/combined/JAK_STAT.processed.mm10.txt", character(), quote="")

top10cg <- scan("/projects/micb405/project1/Team10/CistromeGO/combined/Gene_Rank_By_Rank_Product.top10.txt", character(), quote="")

names(gene_dict)<- c("Gene", "Gene_Name")

gene_dict$Gene <- as.character(gene_dict$Gene)
gene_dict$Gene_Name <- as.character(gene_dict$Gene_Name)



colours <- c(
 # "JAK/STAT" = "green",
  "Upregulated" = "red",
  "Downregulated" = "blue",
  "Not significant" = "grey"
)

shapes <- c(
#  "JAK/STAT" = 19,
  "Upregulated" = 1,
  "Downregulated" = 1,
  "Not significant" = 1
)

alphas <- c(
#  "JAK/STAT" = 1,
  "Upregulated" =  0.1,
  "Downregulated" = 0.1,
  "Not significant" = 0.1
)
FDR <- 0.05
LFC <- 1

de_processed <- inner_join(de,gene_dict, by = "Gene")

de_processed <-
  de_processed %>%
#  mutate(logp=-log10(pvalue), padjcat=ifelse(padj < padj_cutoff, paste("FDR <",padj_cutoff), paste("FDR >=", padj_cutoff)))
  mutate(logp=ifelse(pvalue > 0, -log10(pvalue),NA), 
         de=case_when(
#           Gene_Name %in% jak_stat ~ "JAK/STAT", 
           padj < FDR & log2FoldChange > LFC ~ "Upregulated", 
           padj < FDR & log2FoldChange < -LFC ~ "Downregulated", 
           TRUE ~ "Not significant"))

de_processed$de <- factor(de_processed$de, levels = c(
#  "JAK/STAT",
   "Upregulated", 
  "Downregulated", 
  "Not significant"))

top10a1 <- de_processed %>%
  filter((de == "Upregulated" | de == "Downregulated") & padj != 0) %>%
  mutate(lfcABS=abs(log2FoldChange)) %>%
  arrange(padj,desc(lfcABS)) %>%
  head(10) 

top10a2 <- de_processed %>%
  filter((de == "Upregulated" | de == "Downregulated") & padj != 0) %>%
  mutate(lfcABS=abs(log2FoldChange)) %>%
  arrange(desc(lfcABS), padj) %>%
  head(10) 

top10d1 <- de_processed %>%
  filter(de == "Downregulated" & padj != 0) %>%
  mutate(lfcABS=abs(log2FoldChange),FC=-2**lfcABS) %>%
  arrange(padj, desc(lfcABS)) %>%
  head(10)

top10d2 <- de_processed %>%
  filter(de == "Downregulated" & padj != 0) %>%
  mutate(lfcABS=abs(log2FoldChange), FC=-2**lfcABS) %>%
  arrange(desc(lfcABS)) %>%
  head(10)

top10u1 <- de_processed %>%
  filter(de == "Upregulated" & padj != 0) %>%
  mutate(lfcABS=abs(log2FoldChange),FC=2**lfcABS) %>%
  arrange(padj,desc(lfcABS)) %>%
  head(10)

top10u2 <- de_processed %>%
  filter(de == "Upregulated" & padj != 0) %>%
  mutate(lfcABS=abs(log2FoldChange),FC=2**lfcABS) %>%
  arrange(desc(lfcABS)) %>%
  head(10)

# top10 <- names(c())

de_processed %>%
  ggplot(aes(log2FoldChange,logp, colour = de)) +
  geom_point(
#    aes(
 #     alpha = de,
  #    shape = de
   #   )
    ) +
#  ylim(0,max(de_processed$logp)) +
  xlim(-13.5,13.5) +
#  scale_y_log10() +
  ylab( "-log(P-value)") +
  xlab("LFC") +
  geom_vline(xintercept=c(-LFC,LFC),linetype="dotted") +
  theme(legend.title = element_blank(),
        text = element_text(size=18),
        axis.text = element_text(size=18),
        axis.title = element_text(size=18),
        legend.position = "top",
        legend.text = element_text(size=18),
        plot.title = element_text(size=24)
        ) +
  ggtitle("Differentially Expressed Genes in Primary vs Naive T Cells") +
 # geom_label_repel(aes(label=Gene_Name),alpha=1, data = subset(de_processed, Gene_Name %in% top10u1$Gene_Name | Gene_Name %in% top10d1$Gene_Name), show.legend = FALSE) +
 # geom_label_repel(aes(label=Gene_Name, size = 8),alpha=1, data = subset(de_processed, Gene_Name %in% top10u2$Gene_Name | Gene_Name %in% top10d2$Gene_Name), show.legend = FALSE) +
 # geom_point(colour = "green",data=subset(de_processed, Gene_Name %in% jak_stat)) + 
  geom_label_repel(aes(label=Gene_Name, size = 8), alpha=1, data= subset(de_processed, Gene_Name %in% top10cg), show.legend = FALSE) + 
  scale_color_manual(values=colours) +
  scale_shape_manual(values=shapes) +
  scale_alpha_manual(values=alphas) +
  labs(caption = paste("FDR <", FDR, "; LFC > ", LFC)) 


# ggsave("volcano.png", device = "png", dpi = 300, height = 11, width = 11, units = "cm")
# ggplotly()
