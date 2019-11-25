library(tidyverse)
library(UpSetR)
library(here)

#### KO Upset ####

# read in the KO upset data
data <- as.data.frame(read_tsv(here("upset.tsv")))

# make the first column also row names
rownames(data) <- data$MAG

# drop the first column and then transpose
flipped <- data %>% 
  select(c(-MAG)) %>% 
  t

#### KO Frequency ####
# open PNG device for saving
png(filename = here("upset_freq.png"), width=1440, height=810, units="px", pointsize=18)

# plot upset by frequency
upset(as.data.frame(flipped), 
 #     nintersects = NA,
      nsets=ncol(flipped), 
           text.scale=3, 
            point.size = 4, 
            line.size=1,
# number.angles = 30,
      order.by = 'freq'
)

# close device
dev.off()

#### KO Degree ####
# open png device
png(filename = here("upset_deg.png"), width=1440, height=810, units="px", pointsize = 18)

# plot upset by degree
upset(as.data.frame(flipped), 
      #     nintersects = NA,
      nsets=ncol(flipped), 
      text.scale=3, 
      point.size = 4, 
      line.size=1,
      order.by = 'degree'
)

# close device
dev.off()


#### CDS Upset ####

# load in CDS upset data
cds <- as.data.frame(read_tsv(here("cds.tsv")))

# make first column also row names
rownames(cds) <- cds$MAG

# drop the first column and transpose
cds_flipped <- cds %>%
  select(c(-MAG)) %>%
  t

#### CDS Frequency ####

# open device
png(filename = here("cds_upset_freq.png"), width=1440, height=810, units="px", pointsize=18)

# plot the upset by frequency
upset(as.data.frame(cds_flipped), 
      #     nintersects = NA,
      nsets=ncol(cds_flipped), 
      text.scale=3, 
      point.size = 4, 
      line.size=1,
      order.by = 'freq'
)

# close the device
dev.off()

#### CDS Degree ####

# open device
png(filename = here("cds_upset_deg.png"), width=1440, height=810, units="px", pointsize=18)

# plot the upset by frequency
upset(as.data.frame(cds_flipped), 
      #     nintersects = NA,
      nsets=ncol(cds_flipped), 
      text.scale=3, 
      point.size = 4, 
      line.size=1,
      order.by = 'degree'
)

# close the device
dev.off()

#### rRNA Upset ####

# read in rRNA data
rRNA <- as.data.frame(read_tsv(here("rRNA.tsv")))

# make the first column as rownames
rownames(rRNA) <- rRNA$MAG

# drop first column and transpose
rRNA_flipped <- rRNA %>%
  select(c(-MAG)) %>%
  t

#### rRNA Frequency ####

# open device
png(filename = here("rRNA_upset_freq.png"), width=1440, height=810, units="px", pointsize=18)

# plot the upset by frequency
upset(as.data.frame(rRNA_flipped), 
      #     nintersects = NA,
      nsets=ncol(rRNA_flipped), 
      text.scale=3, 
      point.size = 4, 
      line.size=1,
      order.by = 'freq'
)

# close the device
dev.off()

#### rRNA Degree ####

# open device
png(filename = here("rRNA_upset_deg.png"), width=1440, height=810, units="px", pointsize=18)

# plot the upset by frequency
upset(as.data.frame(rRNA_flipped), 
      #     nintersects = NA,
      nsets=ncol(rRNA_flipped), 
      text.scale=3, 
      point.size = 4, 
      line.size=1,
      order.by = 'degree'
)

# close the device
dev.off()

#### tRNA Upset ####

# read in tRNA data
tRNA <- as.data.frame(read_tsv(here("tRNA.tsv")))

# make the first column as rownames
rownames(tRNA) <- tRNA$MAG

# drop first column and transpose
tRNA_flipped <- tRNA %>%
  select(c(-MAG)) %>%
  t

#### tRNA Frequency ####

# open device
png(filename = here("tRNA_upset_freq.png"), width=1440, height=810, units="px", pointsize=18)

# plot the upset by frequency
upset(as.data.frame(tRNA_flipped), 
      #     nintersects = NA,
      nsets=ncol(tRNA_flipped), 
      text.scale=3, 
      point.size = 4, 
      line.size=1,
      order.by = 'freq'
)

# close the device
dev.off()

#### tRNA Degree #####
# open device
png(filename = here("tRNA_upset_deg.png"), width=1440, height=810, units="px", pointsize=18)

# plot the upset by frequency
upset(as.data.frame(tRNA_flipped), 
      #     nintersects = NA,
      nsets=ncol(tRNA_flipped), 
      text.scale= 3, 
      point.size = 4, 
      line.size=1,
      order.by = 'degree'
)

# close the device
dev.off()

#### tmRNA Upset ####
# read in tmRNA data
tmRNA <- as.data.frame(read_tsv(here("tmRNA.tsv")))

# make the first column as rownames
rownames(tmRNA) <- tmRNA$MAG

# drop first column and transpose
tmRNA_flipped <- tmRNA %>%
  select(c(-MAG)) %>%
  t

#### tmRNA Frequency ####

# open device
png(filename = here("tmRNA_upset_freq.png"), width=1440, height=810, units="px", pointsize=18)

# plot the upset by frequency
upset(as.data.frame(tmRNA_flipped), 
      #     nintersects = NA,
      nsets=ncol(tmRNA_flipped), 
      text.scale=3, 
      point.size = 4, 
      line.size=1,
      order.by = 'freq'
)

# close the device
dev.off()

#### tmRNA Degree #####
# open device
png(filename = here("tmRNA_upset_deg.png"), width=1440, height=810, units="px", pointsize=18)

# plot the upset by frequency
upset(as.data.frame(tmRNA_flipped), 
      #     nintersects = NA,
      nsets=ncol(tmRNA_flipped), 
      text.scale=3, 
      point.size = 4, 
      line.size=1,
      order.by = 'degree'
)

# close the device
dev.off()
