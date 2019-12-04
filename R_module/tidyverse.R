# my very first R script

library(tidyverse)
library(cowplot)
library(here)

# Day 1----
raw_dat <- read_delim(file=here("Saanich_Data.csv"), col_names = TRUE, delim = ",")

# Load Saanich dataset
raw_dat <- read_csv(here("Saanich_Data.csv"), col_names = TRUE)

PO4 <- raw_dat$PO4

dat <- select(raw_dat, Date, Depth, PO4)

# Day 2-----

# Subset Saanich dataset variables

dat <- select(raw_dat,1, 2, 3, 4, 5)
dat <- select(raw_dat, Cruise, Date, Depth, Temperature, starts_with("WS_"))
vector <- dat$Depth
vector2 <- c(5,8,10)
vector[vector2]

subset_data <- slice(dat, 710, 713, 715, 717) # Cruise, Date, Depth, Temp, WSO3, WS_NO3, WS_H2S
filter(subset_data, WS_O2 == 204.259)

filter(subset_data, WS_O2 > 204.259)

filter(subset_data, WS_O2 %in% c(204.259,40.745))

filter(subset_data, na.omit(WS_O2) %in% c(204.259, 40.745))

dat <- rename(dat, O2_uM = WS_O2, NO3_uM = WS_NO3, H2S_uM = WS_H2S)

arrange(dat, NO3_uM)

dat <- mutate(dat, Depth_m = Depth * 1000)

# Exercise 1
log(4)
log(4, base = 2)
log(4, base = 4)

# Exercise 2
mean(dat$O2_uM, na.rm = TRUE)
sd(dat$O2_uM, na.rm = TRUE)

# Exercise 3
pdat1 <- raw_dat
slice(pdat1, 20) %>%
  select(Depth)

slice(pdat1, 170) %>%
  select(Mean_CH4)

# Exercise 4
pdat2 <- raw_dat
select(pdat2, Cruise, Date, Depth, PO4, WS_NO3) %>%
  filter(Cruise == 72 & Depth >= 0.1)

dat <- select(raw_dat, Cruise, Date, Depth, Temperature, starts_with("WS_")) %>%
  filter(!is.na(WS_O2)) %>%
  mutate(Depth_m = Depth * 1000)
