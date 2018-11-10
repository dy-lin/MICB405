########################################################
# Install packages
# (only needs to be done once per computer)
########################################################
# R v3.4 or newer
## CRAN packages
install.packages("tidyverse")
install.packages("cowplot")
## Bioconductor packages
source("https://bioconductor.org/biocLite.R")
biocLite("BiocInstaller")
biocLite("pathview")

# R v3.3 or older 
## CRAN packages
install.packages("tibble")
install.packages("readr")
install.packages("dplyr")
install.packages("tidyr")
install.packages("ggplot2")
install.packages("stringr")
install.packages("purrr")
install.packages("forcats")
install.packages("cowplot")
## Bioconductor packages
source("https://bioconductor.org/biocLite.R")
biocLite("BiocInstaller")
biocLite("pathview")

########################################################
# Check that packages work
########################################################
# R v3.4 or newer
library(tidyverse)
library(cowplot)
library(pathview)

# R v3.3 or older
## tidyverse packages
library(tibble)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)
library(purrr)
library(forcats)
## other packages
library(cowplot)
library(pathview)

########################################################
# Tidyverse (tutorial)
########################################################
# Load packages used today
## R v3.4+
library(tidyverse)
## R v3.3-
library(readr)
library(dplyr)
library(tidyr)

############################
# Read in data
############################
# Read to console
read_delim(file="Saanich_Data.csv", col_names=TRUE, delim=",")

read_csv(file="Saanich_Data.csv", col_names=TRUE)

# Save data file as an R object
raw_dat <- read_csv("Saanich_Data.csv", col_names=TRUE)

raw_dat

############################
# Indexing
############################
# Examples of R's index system [rows, columns]
## 3rd row, 5th column
raw_dat[3, 5]

## By column name
raw_dat[3, "Depth"]

## $ operator
### View head() since there are 1605 observations
head(raw_dat$Depth)

############################
# Conditional statements 
# & logical operators
############################
# Subset data
oxygen <- raw_dat$WS_O2
oxygen <- oxygen[c(710, 713, 715, 716, 709, 717, 718, 719)]
oxygen

# Examples
## a == b returns true when a matches b
oxygen == 204.259

## a != b returns true if a does not match b
oxygen != 204.259

## a > b returns true if a is greater than b
oxygen > 204.259

## a %in% b returns true if the value of a is in b
204.259 %in% oxygen

## is.na() returns true in indices where the values of the input are NA (Not Available)
is.na(oxygen)

## Find the indices where the value is <= 120 **AND** >= 20
oxygen <= 120 & oxygen >= 20

## logical OR `|`. Find the indices where the value is <= 50 **OR** >= 150
oxygen <= 50 | oxygen >= 150

############################
# EXERCISE: vectors
############################

# 1. Using help to identify the necessary arguments for the `log` function, compute the natural logarithm of 4, base 2 logarithm of 4, and base 4 logarithm of 4.

# 2. Using indexing and the square bracket operator `[]`, determine A) what depth value occurs in the 20th row, B) what mean methane value occurs in the 170th row

# 3. Calculate the mean and standard deviation of all oxygen measurements. *Hint* use the help function to learn how to deal with NAs in the data.

############################
# Data wrangling in dplyr
############################
# Ugly base R example
raw_dat[apply(!is.na(raw_dat[,"WS_O2"]), 1, any), 
c("Cruise", "Date", "Depth", "Temperature", "WS_O2", "WS_NO3", "WS_H2S")]

# Copy raw data for cleaning
dat <- raw_dat

# Select
dat <- select(dat, Cruise, Date, Depth, Temperature, WS_O2, WS_NO3, WS_H2S)

dat <- select(raw_dat, Cruise, Date, Depth, Temperature, starts_with("WS_"))

# Filter
dat <- filter(dat, !is.na(WS_O2))

############################
# EXERCISE: select and filter
############################
# Copy raw data to practice data
pdat <- raw_dat

# Using your pdat data:

# 1. select the Cruise, Date, Depth, PO4, and NO3 variables

# 2. filter the data to retain data on Cruise 72 where Depth is >= to 0.1 

########################################################
# Tidyverse 2 (class)
########################################################
# Load packages used today
## R v3.4+
library(tidyverse)
## R v3.3-
library(readr)
library(dplyr)

# Reload and clean data if needed
raw_dat <- read_csv("Saanich_Data.csv")
dat <- raw_dat
dat <- select(dat, Cruise, Date, Depth, Temperature, WS_O2, WS_NO3, WS_H2S)
dat <- filter(dat, !is.na(WS_O2))

############################
# More dplyr verbs
############################
# Rename
dat <- rename(dat, O2_uM=WS_O2, NO3_uM=WS_NO3, H2S_uM=WS_H2S)

# Arrange
dat[1:10, ]
arrange(dat[1:10, ], NO3_uM)

# Mutate
dat <- mutate(dat, Depth_m=Depth*1000)

############################
# EXERCISE: rename and mutate
############################
# Create practice data

# 1. Select the Depth_m and O2_uM variables from pdat

# 2. Filter to 100 m samples

# 3. Rename the O2 variable to Oxygen using rename

# 4. Transform Oxygen from micromoles/L to micrograms/L using mutate (multiply Oxygen by 32)

# 5. Calculate the mean and standard deviation of Oxygen in micrograms/L for this subset of data.

############################
# Piping with %>% 
############################
# Redo all data cleaning with pipes
dat <- 
  raw_dat %>%
  select(Cruise, Date, Depth, Temperature,
         WS_O2, WS_NO3, WS_H2S) %>%
  filter(!is.na(WS_O2)) %>%
  rename(O2_uM=WS_O2, NO3_uM=WS_NO3, H2S_uM=WS_H2S) %>%
  mutate(Depth_m=Depth*1000)

############################
# More dplyr verbs
############################
# Summarise
dat %>%
  group_by(Depth_m) %>%
  summarise(Mean_O2=mean(O2_uM, na.rm=TRUE),
  SD_O2=sd(O2_uM, na.rm=TRUE))

############################
# EXERCISE: summarize
############################
# Create practice data
pdat <- dat

# 1. Calculate median, interquartile range, and sample size of Temperature by Cruise.

############################
# Gather and spread
############################
# Example wide data
## Set random seed for reproducibility
set.seed(123)
## Create table
wide = data.frame(
  sample_ID = c(1,2,3,4),
  year_2015 = runif(4, 0, 1) %>% round(3), 
  year_2016 = runif(4, 0.2, 1.2) %>% round(3),
  year_2017 = runif(4, 0.5, 1.5) %>% round(3)
)

wide

# Example long data
## Don't worry about the function yet. Just look at the output
gather(wide, key="Year", value="Value", -sample_ID)

# Our data (wide format)
head(dat)

# Gather
dat <- gather(dat, key="Key", value="Value", -Cruise, -Date, -Depth_m)  
unique(dat$Key)

# Spread
dat <- spread(dat, key="Key", value="Value")
head(dat)

############################
# END
############################