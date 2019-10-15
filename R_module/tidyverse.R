# my very first R script

library(tidyverse)
library(cowplot)

raw_dat <- read_delim(file="~/MICB405/R_module/Saanich_Data.csv", col_names = TRUE, delim = ",")

raw_dat <- read_csv("~/MICB405/R_module/Saanich_Data.csv", col_names = TRUE)

PO4 <- raw_dat$PO4

dat <- select(raw_dat, Date, Depth, PO4)
