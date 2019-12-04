# Diana Lin
# ggplot EDUCE module
# October 29, 2019

library(tidyverse)

raw_dat <- read_csv("Saanich_Data.csv")
dat <- raw_dat %>%
	select(Cruise, Date, Depth, Temperature, WS_O2, WS_NO3, WS_H2S) %>%
	filter(!is.na(WS_O2)) %>%
	rename(O2_uM=WS_O2, NO3_uM = WS_NO3, H2S_uM = WS_H2S) %>%
	mutate(Depth_m=Depth*1000)

dat %>%
	ggplot(aes(x=O2_uM, y=NO3_uM)) +
	geom_point()

dat %>%
	ggplot() +
	geom_point(aes(x=O2_uM, y=NO3_uM))

dat %>%
  ggplot(aes(x=O2_uM, y=NO3_uM, color=H2S_uM)) +
  geom_point()

dat %>%
  arrange(H2S_uM) %>%  
  filter(!is.na(H2S_uM)) %>%
  ggplot(aes(x=O2_uM, y=NO3_uM, color=H2S_uM)) +
  geom_point() 

dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>%
  gather(key="Chemical", value="Concentration", -Depth_m)

dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m) %>% 
  ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical)) +
  geom_point()

dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m) %>% 
  ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical, color=Chemical)) +
  geom_point() +
  scale_y_reverse(limits=c(200, 0))

dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m) %>% 
  ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical, color=Chemical)) +
  geom_point() +
  scale_y_reverse(limits=c(200, 0))

dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m) %>% 
  ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical, color=Chemical)) +
  geom_point() +
  scale_y_reverse(limits=c(200, 0)) +
  facet_wrap(~Chemical)

dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m) %>% 
  ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical, color=Chemical)) +
  geom_point() +
  scale_y_reverse(limits=c(200, 0)) +
  facet_wrap(~Chemical, scales="free_x")

dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m) %>% 
  ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical, color=Chemical)) +
  geom_point() +
  scale_y_reverse(limits=c(200, 0)) +
  facet_wrap(~Chemical, scales="free_x") +
  theme_bw()

dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>% 
  gather(key="Chemical", value="Concentration", -Depth_m) %>% 
  ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical, color=Chemical)) +
  geom_point() +
  scale_y_reverse(limits=c(200, 0)) +
  facet_wrap(~Chemical, scales="free_x") +
  theme_bw() +
  theme(legend.position="none")

(p1 <- dat %>%
  select(Depth_m, O2_uM, NO3_uM, H2S_uM) %>%
  gather(key="Chemical", value="Concentration", -Depth_m) %>%
  ggplot(aes(x=Concentration, y=Depth_m, shape=Chemical, color=Chemical)) +
  geom_point() +
  scale_y_reverse(limits=c(200, 0)) +
  facet_wrap(~Chemical, scales="free_x") +
  theme_bw() +
  theme(legend.position="none") +
  labs(y="Depth in m", x="Concentration in uM"))

(p2 <- dat %>%
  ggplot(aes(x=Depth_m)) +
  geom_histogram(binwidth=10) +
  scale_x_reverse(limits=c(200, 0)) +
  labs(x="", y="Total samples") +
  coord_flip() + # flip the x and y axes
  theme_bw())

(p <- plot_grid(p1, p2, labels=c("A", "B"), align="h", axis="tb", rel_widths=c(3/4, 1/4)))

ggsave("saanich.pdf", p, width=10, height=6)
