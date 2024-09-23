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
  fstc <- slideFunct(c$WEIR_AND_COCKERHAM_FST, n, n)
  c_pr <- rep(fstc, each = n)
  
  length(c_pr)
  length(c$WEIR_AND_COCKERHAM_FST)
  
  c_pr <- data_completion(c_pr, c$WEIR_AND_COCKERHAM_FST)
  
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



setwd("/media/fortytwo/Heart_of_Gold/selscan/SelScan_scores/Selection_Scan_UGD_KYWall/")

fst <- read.table("./Fst_results.weir.fst", header = TRUE)

fst$WEIR_AND_COCKERHAM_FST[fst$WEIR_AND_COCKERHAM_FST <= 0] <- 0

fst <- na.omit(fst)

fst_g <- fst |> group_by(CHROM) |> summarise(max_bp = max(POS)) |>
  mutate(bp_add = lag(cumsum(max_bp), default = 0)) |>
  select(CHROM, bp_add)

fst <- fst |>
  inner_join(fst_g, by = "CHROM") |>
  mutate(bp_cum = POS + bp_add)

axis_set <- fst |>
  group_by(CHROM) |>
  summarize(center = mean(bp_cum))


fst <- fst %>%
  mutate(ROI = case_when(CHROM == "CM009931.2" ~ "CM009931.2",
                         CHROM == "CM009932.2" ~ "CM009932.2",
                         CHROM == "CM009933.2" ~ "CM009933.2",
                         CHROM == "CM009934.2" ~ "CM009934.2",
                         CHROM == "CM009935.2" ~ "CM009935.2",
                         CHROM == "CM009936.2" ~ "CM009936.2",
                         CHROM == "CM009937.2" & POS >= 5139 & POS <= 591568  ~ "r7",
                         CHROM == "CM009937.2" & POS < 5139 ~ "CM009937.2",
                         CHROM == "CM009937.2" & POS > 591568 ~ "CM009937.2",
                         CHROM == "CM009938.2" ~ "CM009938.2",
                         CHROM == "CM009939.2" & POS >= 3264395 & POS <= 4999196 ~ "r9",
                         CHROM == "CM009939.2" & POS < 3264395 ~ "CM009939.2",
                         CHROM == "CM009939.2" & POS > 4999196 ~ "CM009939.2",
                         CHROM == "CM009940.2" ~ "CM009940.2",
                         CHROM == "CM009941.2" ~ "CM009941.2",
                         CHROM == "CM009942.2" ~ "CM009942.2",
                         CHROM == "CM009943.2" ~ "CM009943.2",
                         CHROM == "CM009944.2" ~ "CM009944.2",
                         CHROM == "CM009945.2" ~ "CM009945.2",
                         CHROM == "CM009946.2" ~ "CM009946.2"))

r7 <- fst %>%
  filter(ROI %in% c("r7"))
r9 <- fst %>%
  filter(ROI %in% c("r9"))

c1 <- fst %>%
  filter(CHROM == "CM009931.2")
c2 <- fst %>%
  filter(CHROM == "CM009932.2")
c3 <- fst %>%
  filter(CHROM == "CM009933.2")
c4 <- fst %>%
  filter(CHROM == "CM009934.2")
c5 <- fst %>%
  filter(CHROM == "CM009935.2")
c6 <- fst %>%
  filter(CHROM == "CM009936.2")
c7 <- fst %>%
  filter(CHROM == "CM009937.2")
c8 <- fst %>%
  filter(CHROM == "CM009938.2")
c9 <- fst %>%
  filter(CHROM == "CM009939.2")
c10 <- fst %>%
  filter(CHROM == "CM009940.2")
c11 <- fst %>%
  filter(CHROM == "CM009941.2")
c12 <- fst %>%
  filter(CHROM == "CM009942.2")
c13 <- fst %>%
  filter(CHROM == "CM009943.2")
c14 <- fst %>%
  filter(CHROM == "CM009944.2")
c15 <- fst %>%
  filter(CHROM == "CM009945.2")
c16 <- fst %>%
  filter(CHROM == "CM009946.2")




c1 <- get_sw(c1, 1000)
c2 <- get_sw(c2, 1000)
c3 <- get_sw(c3, 1000)
c4 <- get_sw(c4, 1000)
c5 <- get_sw(c5, 1000)
c6 <- get_sw(c6, 1000)
c7 <- get_sw(c7, 1000)
c8 <- get_sw(c8, 1000)
c9 <- get_sw(c9, 1000)
c10 <- get_sw(c10, 1000)
c11 <- get_sw(c11, 1000)
c12 <- get_sw(c12, 1000)
c13 <- get_sw(c13, 1000)
c14 <- get_sw(c14, 1000)
c15 <- get_sw(c15, 1000)
c16 <- get_sw(c16, 1000)
c1 <- get_sw_mp(c1, 1000)
c2 <- get_sw_mp(c2, 1000)
c3 <- get_sw_mp(c3, 1000)
c4 <- get_sw_mp(c4, 1000)
c5 <- get_sw_mp(c5, 1000)
c6 <- get_sw_mp(c6, 1000)
c7 <- get_sw_mp(c7, 1000)
c8 <- get_sw_mp(c8, 1000)
c9 <- get_sw_mp(c9, 1000)
c10 <- get_sw_mp(c10, 1000)
c11 <- get_sw_mp(c11, 1000)
c12 <- get_sw_mp(c12, 1000)
c13 <- get_sw_mp(c13, 1000)
c14 <- get_sw_mp(c14, 1000)
c15 <- get_sw_mp(c15, 1000)
c16 <- get_sw_mp(c16, 1000)


f_new <- rbind(c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16)
f_new$midpoint <- round(f_new$midpoint)

f_new <- f_new %>%
  mutate(ROI = case_when(CHROM == "CM009931.2" ~ "CM009931.2",
                         CHROM == "CM009932.2" ~ "CM009932.2",
                         CHROM == "CM009933.2" ~ "CM009933.2",
                         CHROM == "CM009934.2" ~ "CM009934.2",
                         CHROM == "CM009935.2" ~ "CM009935.2",
                         CHROM == "CM009936.2" ~ "CM009936.2",
                         CHROM == "CM009937.2" & POS >= 5139 & POS <= 591568  ~ "r7",
                         CHROM == "CM009937.2" & POS < 5139 ~ "CM009937.2",
                         CHROM == "CM009937.2" & POS > 591568 ~ "CM009937.2",
                         CHROM == "CM009938.2" ~ "CM009938.2",
                         CHROM == "CM009939.2" & POS >= 3264395 & POS <= 4999196 ~ "r9",
                         CHROM == "CM009939.2" & POS < 3264395 ~ "CM009939.2",
                         CHROM == "CM009939.2" & POS > 4999196 ~ "CM009939.2",
                         CHROM == "CM009940.2" ~ "CM009940.2",
                         CHROM == "CM009941.2" ~ "CM009941.2",
                         CHROM == "CM009942.2" ~ "CM009942.2",
                         CHROM == "CM009943.2" ~ "CM009943.2",
                         CHROM == "CM009944.2" ~ "CM009944.2",
                         CHROM == "CM009945.2" ~ "CM009945.2",
                         CHROM == "CM009946.2" ~ "CM009946.2"))

r7 <- f_new %>%
  filter(ROI %in% c("r7"))
r9 <- f_new %>%
  filter(ROI %in% c("r9"))

f_new

manhplot <- ggplot(f_new, aes(
  x = bp_cum, y = WEIR_AND_COCKERHAM_FST,
  color = as_factor(CHROM))) +
  geom_point(alpha = 0.4, size = 0.7) +
  scale_x_continuous(
    label = axis_set$CHROM,
    breaks = axis_set$center
  ) +
  geom_point(data = r7,
             shape = 21,
             size = 1, 
             fill = "steelblue",
             color = "steelblue") + 
  geom_point(data = r9,
             shape = 21,
             size = 1, 
             fill = "springgreen3",
             color = "springgreen3") +
  geom_line(data = f_new, aes(x = midpoint, y = avg_fst),  color = "black") +
  scale_color_manual(values = rep(
    c("grey", "darkgrey"),
    unique(length(axis_set$CHROM))
  )) +
  scale_size_continuous(range = c(0.5, 3)) +
  labs(
    x = NULL,
    y = "F<sub>ST</sub>"
  ) +
  theme_classic() + 
  theme(
    legend.position = "none",
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    axis.title.y = element_markdown(size = 24),
    axis.text.x = element_text(angle = 90, size = 18, vjust = 0.5),
    axis.text.y = element_text(size = 18, vjust = 0.5))
manhplot

ggsave(filename = "./FST_general.tiff", plot = manhplot, dpi = 600, height = 15, width = 25)

