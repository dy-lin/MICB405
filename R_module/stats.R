########################################################
# Statistics in R (class)
########################################################
# Load packages used today
## R v3.4+
library(tidyverse)
## R v3.3-
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

# Load raw data
raw_dat <- read_csv("Saanich_Data.csv")

# Data cleaning
dat <- 
  raw_dat %>%
  select(Cruise, Date, Depth, Temperature,
         WS_O2, WS_NO3, WS_H2S) %>%
  filter(!is.na(WS_O2)) %>%
  rename(O2_uM=WS_O2, NO3_uM=WS_NO3, H2S_uM=WS_H2S) %>%
  mutate(Depth_m=Depth*1000)

############################
# t-test
############################
# Subset data to 2 depths in 3 cruises in February.
dat.ttest <- dat %>%
  filter(Depth_m %in% c(10, 100) & Cruise %in% c(18,30,42)) %>% 
  select(Cruise, Date, Depth_m, O2_uM)

# Visualize data
dat.ttest %>% 
  ggplot(aes(x=as.factor(Depth_m), y=O2_uM)) +
  geom_boxplot() +
  geom_point() +
  labs(x="Depth (m)", y="Oxygen (uM)")

# Fit a t-test and estimate p-values
t.test(O2_uM ~ as.factor(Depth_m), data = dat.ttest, var.equal=FALSE)

############################
# One-way ANOVA
############################
# Subset data to 3 depths in 3 cruises in February.
dat.aov <- dat %>%
  filter(Depth_m %in% c(10, 100, 200) & Cruise %in% c(18,30,42)) %>% 
  select(Cruise, Date, Depth_m, O2_uM)

# Visualize the data
dat.aov %>% 
  ggplot(aes(x=as.factor(Depth_m), y=O2_uM)) +
  geom_boxplot() +
  geom_point() +
  geom_hline(aes(yintercept=mean(O2_uM))) + # Add a horizontal line for the overall mean
  labs(x="Depth (m)", y="Oxygen (uM)")

# Fit ANOVA and estimate p-values
summary(aov(O2_uM ~ as.factor(Depth_m), data = dat.aov))

############################
# Linear regression
############################
# Subset the data to 3 February cruises.
dat.lm <- dat %>%
  filter(Cruise %in% c(18,30,42)) %>% 
  select(Cruise, Date, Depth_m, O2_uM)

# Visualize the data
dat.lm %>% 
  ggplot(aes(x=Depth_m, y=O2_uM)) +
  geom_point() +
  geom_smooth(method="lm") +
  labs(x="Depth (m)", y="Oxygen (uM)")

# Fit the linear model and estimate p-values
summary(lm(O2_uM ~ Depth_m, data = dat.lm))

############################
# Testing assumptions
############################
# t-test and ANOVA
## Are the data normally distributed?
ggplot(dat.aov, aes(x=O2_uM)) +
  geom_histogram(bins=6)

## Are the sample sizes large and equal? Are the sample variances equal?
dat.aov %>% 
  group_by(Depth_m) %>% 
  summarise(n = n(), 
            sd = sd(O2_uM), 
            variance = var(O2_uM))

# Linear regression
## Residual plotting
### Set window to 2x2 plots
par(mfrow=c(2,2))
### Use base R to plot
plot(lm(O2_uM ~ Depth_m, data = dat.lm))

## Concrete testing
library(gvlma)
gvlma(lm(O2_uM ~ Depth_m, data = dat.lm))

## Plot a different fit (non-linear)
dat.lm %>% 
ggplot(aes(x=Depth_m, y=O2_uM)) +
  geom_point() +
  geom_smooth(method="loess") +
  labs(x="Depth (m)", y="Oxygen (uM)")

############################
# END
############################