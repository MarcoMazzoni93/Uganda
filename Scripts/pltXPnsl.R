library(ggplot2)
library(tidyverse)
library(ggtext)
library(normentR)


slideFunct <- function(data, window, step){
  total <- length(data)
  spots <- seq(from=1, to=(total-window), by=step)
  result <- vector(length = length(spots))
  for(i in 1:length(spots)){
    result[i] <- mean(data[spots[i]:(spots[i]+window)])
  }
  
  return(result)
}

data_completion <- function(results, data){
  for(i in 1:(length(data) - length(results))){
    results <- append(results, tail(results, n = 1))
  }
  return(results)
}

get_sw <- function(c, n){
  fstc <- slideFunct(c$XPnsl_val, n, n)
  c_pr <- rep(fstc, each = n)
  
  length(c_pr)
  length(c$XPnsl_val)
  
  c_pr <- data_completion(c_pr, c$XPnsl_val)
  
  c$avg_fst <- c_pr
  return(c)  
}

get_sw_mp <- function(c, n){
  fstc <- slideFunct(c$bp_cum, n, n)
  c_pr <- rep(fstc, each = n)
  
  length(c_pr)
  length(c$POS)
  
  c_pr <- data_completion(c_pr, c$bp_cum)
  
  c$midpoint <- c_pr
  return(c)  
  
}

setwd("/media/fortytwo/Heart_of_Gold/selscan/SelScan_scores/Selection_Scan_UGD_KYWall/MTK/NORM/")

XPnsl <- read.table("./XPnsl_plt_MK.final", header = FALSE)

colnames(XPnsl)[1] <- "POS"
colnames(XPnsl)[2] <- "XPnsl_val"
colnames(XPnsl)[3] <- "CHROM"

XPnsl$CHROM[XPnsl$CHROM == "1"] <- "CM009931.2"
XPnsl$CHROM[XPnsl$CHROM == "2"] <- "CM009932.2"
XPnsl$CHROM[XPnsl$CHROM == "3"] <- "CM009933.2"
XPnsl$CHROM[XPnsl$CHROM == "4"] <- "CM009934.2"
XPnsl$CHROM[XPnsl$CHROM == "5"] <- "CM009935.2"
XPnsl$CHROM[XPnsl$CHROM == "6"] <- "CM009936.2"
XPnsl$CHROM[XPnsl$CHROM == "7"] <- "CM009937.2"
XPnsl$CHROM[XPnsl$CHROM == "8"] <- "CM009938.2"
XPnsl$CHROM[XPnsl$CHROM == "9"] <- "CM009939.2"
XPnsl$CHROM[XPnsl$CHROM == "10"] <- "CM009940.2"
XPnsl$CHROM[XPnsl$CHROM == "11"] <- "CM009941.2"
XPnsl$CHROM[XPnsl$CHROM == "12"] <- "CM009942.2"
XPnsl$CHROM[XPnsl$CHROM == "13"] <- "CM009943.2"
XPnsl$CHROM[XPnsl$CHROM == "14"] <- "CM009944.2"
XPnsl$CHROM[XPnsl$CHROM == "15"] <- "CM009945.2"
XPnsl$CHROM[XPnsl$CHROM == "16"] <- "CM009946.2"

XPnsl_g <- XPnsl |> group_by(CHROM) |> summarise(max_bp = max(POS)) |>
  mutate(bp_add = lag(cumsum(max_bp), default = 0)) |>
  select(CHROM, bp_add)

XPnsl <- XPnsl |>
  inner_join(XPnsl_g, by = "CHROM") |>
  mutate(bp_cum = POS + bp_add)

axis_set <- XPnsl |>
  group_by(CHROM) |>
  summarize(center = mean(bp_cum))


XPnsl <- XPnsl %>%
  mutate(ROI = case_when(XPnsl_val >= 3.25 ~ "Highland Critical Value",
                         XPnsl_val <= -2.82 ~ "Lowland Critical Value",
                         TRUE ~ "Ns"))

r7 <- XPnsl %>%
  filter(ROI %in% c("Highland Critical Value"))
r9 <- XPnsl %>%
  filter(ROI %in% c("Lowland Critical Value"))

c1 <- XPnsl %>%
  filter(CHROM == "CM009931.2")
c2 <- XPnsl %>%
  filter(CHROM == "CM009932.2")
c3 <- XPnsl %>%
  filter(CHROM == "CM009933.2")
c4 <- XPnsl %>%
  filter(CHROM == "CM009934.2")
c5 <- XPnsl %>%
  filter(CHROM == "CM009935.2")
c6 <- XPnsl %>%
  filter(CHROM == "CM009936.2")
c7 <- XPnsl %>%
  filter(CHROM == "CM009937.2")
c8 <- XPnsl %>%
  filter(CHROM == "CM009938.2")
c9 <- XPnsl %>%
  filter(CHROM == "CM009939.2")
c10 <- XPnsl %>%
  filter(CHROM == "CM009940.2")
c11 <- XPnsl %>%
  filter(CHROM == "CM009941.2")
c12 <- XPnsl %>%
  filter(CHROM == "CM009942.2")
c13 <- XPnsl %>%
  filter(CHROM == "CM009943.2")
c14 <- XPnsl %>%
  filter(CHROM == "CM009944.2")
c15 <- XPnsl %>%
  filter(CHROM == "CM009945.2")
c16 <- XPnsl %>%
  filter(CHROM == "CM009946.2")




c1 <- get_sw(c1, 10000)
c2 <- get_sw(c2, 10000)
c3 <- get_sw(c3, 10000)
c4 <- get_sw(c4, 10000)
c5 <- get_sw(c5, 10000)
c6 <- get_sw(c6, 10000)
c7 <- get_sw(c7, 10000)
c8 <- get_sw(c8, 10000)
c9 <- get_sw(c9, 10000)
c10 <- get_sw(c10, 10000)
c11 <- get_sw(c11, 10000)
c12 <- get_sw(c12, 10000)
c13 <- get_sw(c13, 10000)
c14 <- get_sw(c14, 10000)
c15 <- get_sw(c15, 10000)
c16 <- get_sw(c16, 10000)
c1 <- get_sw_mp(c1, 10000)
c2 <- get_sw_mp(c2, 10000)
c3 <- get_sw_mp(c3, 10000)
c4 <- get_sw_mp(c4, 10000)
c5 <- get_sw_mp(c5, 10000)
c6 <- get_sw_mp(c6, 10000)
c7 <- get_sw_mp(c7, 10000)
c8 <- get_sw_mp(c8, 10000)
c9 <- get_sw_mp(c9, 10000)
c10 <- get_sw_mp(c10, 10000)
c11 <- get_sw_mp(c11, 10000)
c12 <- get_sw_mp(c12, 10000)
c13 <- get_sw_mp(c13, 10000)
c14 <- get_sw_mp(c14, 10000)
c15 <- get_sw_mp(c15, 10000)
c16 <- get_sw_mp(c16, 10000)

#PLOT EVERYTHING
XP_new <- rbind(c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16)
XP_new$midpoint <- round(XP_new$midpoint)

quantile(XP_new$XPnsl_val, c(0.99986))

XP_new <- XP_new %>%
  mutate(ROI = case_when(XPnsl_val >= quantile(XP_new$XPnsl_val, c(0.0025, 0.9975))[2] ~ "Highland Critical Value",
                         XPnsl_val <= quantile(XP_new$XPnsl_val, c(0.0025, 0.9975))[1] ~ "Lowland Critical Value"))

values <- (c(7.07189, 4.97029, 6.00259))

r7 <- XP_new %>%
  filter(ROI %in% c("Highland Critical Value"))
r9 <- XP_new %>%
  filter(ROI %in% c("Lowland Critical Value"))

manhplot <- ggplot(XP_new, aes(
  x = bp_cum, y = XPnsl_val,
  color = as_factor(CHROM))) +
  geom_point(alpha = 0.4, size = 0.4) +
  scale_x_continuous(
    label = axis_set$CHROM,
    breaks = axis_set$center
  ) +
  geom_point(data = r7,
             shape = 21,
             size = 0.5, 
             fill = "firebrick",
             color = "firebrick") + 
  geom_point(data = r9,
             shape = 21,
             size = 0.5, 
             fill = "deepskyblue1",
             color = "deepskyblue1") +
  geom_line(data = XP_new, aes(x = midpoint, y = avg_fst),  color = "black") +
  scale_color_manual(values = rep(
    c("grey", "darkgrey"),
    unique(length(axis_set$CHROM))
  )) +
  scale_size_continuous(range = c(0.5, 3)) +
  labs(
    x = "Chromosome",
    y = "XP-nsl"
  ) +
  theme_classic() + 
  theme(
    legend.position = "none",
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    axis.title.x = element_text(size = 14, face = "bold"), 
    axis.title.y = element_text(size = 14, face = "bold"),
    axis.text.x = element_text(angle = 45, size = 10, hjust = 1),
    axis.text.y = element_text(size = 10))
manhplot

ggsave(filename = "/home/fortytwo/MK_XPnsl.png", plot = manhplot, dpi = 600, height = 10, width = 10)

#PLOT ONLY r7
XP_new <- c7
XP_new$midpoint <- round(XP_new$midpoint)
XP_new_filter <- XP_new %>% 
  filter(POS < 6e5)


r7 <- XP_new_filter %>%
  filter(ROI %in% c("Highland Critical Value"))
r9 <- XP_new_filter %>%
  filter(ROI %in% c("Lowland Critical Value"))

manhplot <- ggplot(XP_new_filter, aes(
  x = POS, y = XPnsl_val,
  color = as_factor(CHROM))) +
  geom_point(alpha = 0.4, size = 0.4) +
  geom_point(data = r7,
             shape = 21,
             size = 0.5, 
             fill = "firebrick",
             color = "firebrick") + 
  geom_point(data = r9,
             shape = 21,
             size = 0.5, 
             fill = "deepskyblue1",
             color = "deepskyblue1") +
  scale_color_manual(values = rep(
    c("grey", "darkgrey"),
    unique(length(axis_set$CHROM))
  )) +
  scale_x_continuous(breaks = c(100000, 200000, 300000, 400000, 500000, 600000)) + 
#  scale_size_continuous(range = c(0.5, 3)) +
  labs(
    x = "r7",
    y = "XP-nsl"
  ) +
  theme_bw() + 
  theme(
    legend.position = "none",
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    axis.title.y = element_markdown(),
    axis.text.x = element_text(angle = 90, size = 8, vjust = 0.5)
  )
manhplot

ggsave(filename = "./UGD_XPnsl.png", plot = manhplot, dpi = 600, height = 10, width = 10)

#PLOT ONLY r9
XP_new <- c9
XP_new$midpoint <- round(XP_new$midpoint)
XP_new_filter <- XP_new %>% 
  filter(POS > 3264394 & POS < 4999197)


r7 <- XP_new_filter %>%
  filter(ROI %in% c("Highland Critical Value"))
r9 <- XP_new_filter %>%
  filter(ROI %in% c("Lowland Critical Value"))

manhplot <- ggplot(XP_new_filter, aes(
  x = POS, y = XPnsl_val,
  color = as_factor(CHROM))) +
  geom_point(alpha = 0.4, size = 0.4) +
  geom_point(data = r7,
             shape = 21,
             size = 0.5, 
             fill = "firebrick",
             color = "firebrick") + 
  geom_point(data = r9,
             shape = 21,
             size = 0.5, 
             fill = "deepskyblue1",
             color = "deepskyblue1") +
  scale_color_manual(values = rep(
    c("grey", "darkgrey"),
    unique(length(axis_set$CHROM))
  )) +
  scale_x_continuous() + 
  #  scale_size_continuous(range = c(0.5, 3)) +
  labs(
    x = "r9",
    y = "XP-nsl"
  ) +
  theme_bw() + 
  theme(
    legend.position = "none",
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    axis.title.y = element_markdown(),
    axis.text.x = element_text(angle = 90, size = 8, vjust = 0.5)
  )
manhplot

ggsave(filename = "./UGD_XPnsl.png", plot = manhplot, dpi = 600, height = 10, width = 10)


#PLOT ONLY a single protein or region based on a condition 
XP_new <- c7
XP_new$midpoint <- round(XP_new$midpoint)
XP_new_filter <- XP_new %>% filter(POS > 413063)
XP_new_filter <- XP_new_filter %>% filter(POS < 522093)

r7 <- XP_new_filter %>%
  filter(ROI %in% c("Highland Critical Value"))
r9 <- XP_new_filter %>%
  filter(ROI %in% c("Lowland Critical Value"))

manhplot <- ggplot(XP_new_filter, aes(
  x = POS, y = XPnsl_val,
  color = as_factor(CHROM))) +
  geom_point(alpha = 0.4, size = 1.4) +
  geom_point(data = r7,
             shape = 21,
             size = 2, 
             fill = "firebrick",
             color = "firebrick") + 
  geom_point(data = r9,
             shape = 21,
             size = 0.5, 
             fill = "deepskyblue1",
             color = "deepskyblue1") +
  scale_color_manual(values = rep(
    c("grey", "darkgrey"),
    unique(length(axis_set$CHROM))
  )) +
  scale_x_continuous() + 
  #  scale_size_continuous(range = c(0.5, 3)) +
  labs(
    x = "r7",
    y = "XP-nsl"
  ) +
  theme_bw() + 
  theme(
    legend.position = "none",
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    axis.title.y = element_markdown(),
    axis.text.x = element_text(angle = 90, size = 8, vjust = 0.5)
  )
manhplot

ggsave(filename = "./UGD_XPnsl.png", plot = manhplot, dpi = 600, height = 10, width = 10)