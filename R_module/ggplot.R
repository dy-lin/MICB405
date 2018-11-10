########################################################
# ggplot (tutorial)
########################################################
# R v3.4+
library(tidyverse)
# R v3.3-
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
# Building a ggplot
############################
# Giving data to ggplot
ggplot(dat)
# is equivalent to
dat %>% ggplot()

# Add variables (axes)
dat %>%
  ggplot(aes(x=O2_uM, y=NO3_uM))

# Add variable values across all layers 
dat %>%
  ggplot(aes(x=O2_uM, y=NO3_uM)) +
  geom_point()

# Add variable values to just the geom_point layer
dat %>%
  ggplot() +
  geom_point(aes(x=O2_uM, y=NO3_uM))


############################
# EXERCISE: geom_point
############################
# Using scatterplots, 

# 1. Investigate the relationship between oxygen and hydrogen sulfide

# 2. Investigate the relationship between nitrate and hydrogen sulfide

## Does it appear that our earlier hypotheses hold true?

############################
# Customizing your plot (color)
############################
# Add color
dat %>%
  ggplot(aes(x=O2_uM, y=NO3_uM, color=H2S_uM)) +
  geom_point() 

# Rearrange the data and remove NAs
dat %>%
  arrange(H2S_uM) %>%  
  filter(!is.na(H2S_uM)) %>%

ggplot(aes(x=O2_uM, y=NO3_uM, color=H2S_uM)) +
  geom_point() 

############################
# Customizing your plot (shape)
############################
# Shape does not work for continuous variables
dat %>%
  arrange(H2S_uM) %>%  
  filter(!is.na(H2S_uM)) %>%

ggplot(aes(x=O2_uM, y=NO3_uM, shape=H2S_uM)) +
  geom_point() 

# Rethink the plot
## dat %>%
##  ggplot(aes(x=?, y=Depth_m, shape=?)) +
##  geom_point()

# Using gather to transform the data for plotting
dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m)

# Gather and ggplot
dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m) %>% 

ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical)) +
  geom_point()

# More customization
dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m) %>% 

ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical, color=Chemical)) +
  geom_point() +
  scale_y_reverse(limits=c(200, 0))

############################
# EXERCISE: color and shape
############################

# 1. Create a plot of oxygen, nitrate, and hydrogen sulfide like above but only including Cruise 72.

# 2. Modify the x- and y-axes labels in this plot. *Hint* look at the R cheatsheet to find the guide functions to achieve this.

########################################################
# ggplot (additional)
########################################################
# R v3.4+
library(tidyverse)
library(cowplot)
# R v3.3-
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(cowplot)

# Load data
raw_dat <- read_csv("Saanich_Data.csv")

# Clean data
dat <- raw_dat %>%
  select(Cruise, Date, Depth, Temperature,
  WS_O2, WS_NO3, WS_H2S) %>%
  filter(!is.na(WS_O2)) %>%
  rename(O2_uM=WS_O2, NO3_uM=WS_NO3, H2S_uM=WS_H2S) %>%
  mutate(Depth_m=Depth*1000)

############################
# Facetting
############################
# Think about this plot again
dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m) %>% 
  
  ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical, color=Chemical)) +
  geom_point() +
  scale_y_reverse(limits=c(200, 0))

# Add facetting
dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m) %>% 
  
  ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical, color=Chemical)) +
  geom_point() +
  scale_y_reverse(limits=c(200, 0)) +
  facet_wrap(~Chemical)

# Rescale x-axes
dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m) %>% 
  
ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical, color=Chemical)) +
  geom_point() +
  scale_y_reverse(limits=c(200, 0)) +
  facet_wrap(~Chemical, scales="free_x")

############################
# EXERCISE: facets
############################
# Consider this plot again
dat %>%
  ggplot(aes(x=O2_uM, y=NO3_uM)) +
  geom_point()

# Interrogate this plot further by completing the following.

# 1. Filter to data to depths 10, 60, 100 and 200 m

# 2. Plot Oxygen vs Nitrate faceted by Depth

############################
# Themese
############################
# Add the black and white theme
dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m) %>% 

ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical, color=Chemical)) +
  geom_point() +
  scale_y_reverse(limits=c(200, 0)) +
  facet_wrap(~Chemical, scales="free_x") +
  theme_bw()

# Further customize the theme
dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m) %>% 

ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical, color=Chemical)) +
  geom_point() +
  scale_y_reverse(limits=c(200, 0)) +
  facet_wrap(~Chemical, scales="free_x") +
  theme_bw() +
  theme(legend.position="none")

############################
# Multi-panel figures (cowplot)
############################
# Save each plot as an object
p1 <- dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m) %>% 
  
  ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical, color=Chemical)) +
  geom_point() +
  scale_y_reverse(limits=c(200, 0)) +
  facet_wrap(~Chemical, scales="free_x") +
  theme_bw() +
  theme(legend.position="none") +
  labs(y="Depth in m", x="Concentration in uM")

p1

p2 <- dat %>%
  ggplot(aes(x=Depth_m)) +
  geom_histogram(binwidth=10) +
  scale_x_reverse(limits=c(200, 0)) +
  labs(x="", y="Total samples") +
  coord_flip() + # flip the x and y axes
  theme_bw() 

p2

# Combine p1 and p2 into 1 plot
p <- plot_grid(p1, p2, labels=c("A", "B"), align="h", axis="tb", rel_widths=c(3/4, 1/4))

p

############################
# Saving ggplots
############################
# Save as a pdf
ggsave("saanich.pdf", p, width=10, height=6)

############################
# END
############################