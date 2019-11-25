library(tidyverse)
library(UpSetR)
library(here)

data <- as.data.frame(read_tsv(here("upset.csv")))

rownames(data) <- data$MAG

flipped <- data %>% 
  select(c(-MAG)) %>% 
  t

png(filename = here("upset_freq.png"), width=1440, height=810, units="px", pointsize=18)

upset(as.data.frame(flipped), 
 #     nintersects = NA,
      nsets=ncol(flipped)-1, 
           text.scale=3, 
            point.size = 4, 
            line.size=1,
# number.angles = 30,
      order.by = 'freq'
)
dev.off()

png(filename = here("upset_deg.png"), width=1440, height=810, units="px", pointsize = 18)

upset(as.data.frame(flipped), 
      #     nintersects = NA,
      nsets=ncol(flipped)-1, 
      text.scale=3, 
      point.size = 4, 
      line.size=1,
      order.by = 'degree'
)

dev.off()
