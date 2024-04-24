library(ggplot2)
library(dplyr)
library(reshape2)
library(ggtext)

setwd("/media/fortytwo/Heart_of_Gold/selscan/SelScan_scores/Selection_Scan_UGD_KYWall/")

GO_UGD_DEGs <- read.table("/home/fortytwo/Documents/UGD_DEGs.csv", sep = ",", header = TRUE)
GO_UGD_SeSc <- read.table("/home/fortytwo/Documents/UGD_selscan.csv", sep = ",", header = TRUE)
GO_MAU_SeSc <- read.table("/home/fortytwo/Documents/MAU_selscan.csv", sep = ",", header = TRUE)
GO_MTK_SeSc <- read.table("/home/fortytwo/Documents/MTK_selscan.csv", sep = ",", header = TRUE)

remove_go_useless_col <- function(GO, ...){
  GO$highlighted <- NULL
  GO$intersection_size <- NULL
  GO$adjusted_p_value <- round(GO$adjusted_p_value, digits = 4)
  GO$query_size <- NULL
  GO$term_size <- NULL
  GO$effective_domain_size <- NULL
  GO$intersections <- NULL
  
  GO$term_name <- factor(GO$term_name, levels = GO$term_name)
  GO$term_id <- factor(GO$term_id, levels = GO$term_id)
  
  return(GO)
  
}

GO_UGD_DEGs <- remove_go_useless_col(GO_UGD_DEGs)
GO_UGD_SeSc <- remove_go_useless_col(GO_UGD_SeSc)
GO_MAU_SeSc <- remove_go_useless_col(GO_MAU_SeSc)
GO_MTK_SeSc <- remove_go_useless_col(GO_MTK_SeSc)

plt <- ggplot(GO_MTK_SeSc, aes(x = term_name , y = negative_log10_of_adjusted_p_value, fill = source)) + geom_col(aes(col=source)) + scale_color_manual(values = c("black", "black", "black", "black")) +
  scale_fill_manual(values = c("darkgreen", "red", "grey", "yellow")) + 
  geom_hline(yintercept = 1.28, color = "red", linetype = "dashed") +
  geom_text(size = 2, aes(label = adjusted_p_value, size = 10), vjust = -0.5) + 
  xlab("Gene Ontology terms") +
  ylab("-log<sub>10</sub>(p<sub>adj</sub>)") +
  theme_classic() + 
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    axis.title.x = element_text(size = 14, face = "bold"), 
    axis.title.y = element_markdown(size = 14, face = "bold"),
    axis.text.x = element_text(angle = 90, size = 10, hjust = 1),
    axis.text.y = element_text(size = 10))

ggsave(filename = "MTK_SeSc.png", plot = , dpi = 600, height = 15, width = 20)
