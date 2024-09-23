library(ggplot2)
library(ape)

setwd("/media/fortytwo/Heart_of_Gold/selscan/SelScan_scores/Selection_Scan_UGD_KYWall/PCA/r9/")

Eigenval = "./r9.eigenval"
Eigenvec = "./r9.eigenvec"

Eigenvec



Eval.df = read.table(Eigenval, header = FALSE)
Evec.df = read.table(Eigenvec, header = TRUE, sep = " ")

dist.df.x <- Evec.df$PC1
dist.df.y <- Evec.df$PC2
dist.df.z <- Evec.df$PC3
label.name <- Evec.df$Sample_ID

dist.df <- data.frame(dist.df.x, dist.df.y, dist.df.z, row.names = label.name)


dist(dist.df, diag = TRUE, upper = TRUE)

h <- hclust(dist(dist.df, diag = T, upper = T))
plot(as.phylo(h), type = "fan", show.tip.label = TRUE,
     edge.color = "black", edge.width = 2, edge.lty = 1,
     tip.color = "black")

colors = c("red", "blue", "yellow", "green", "black")
clus4 = cutree(h, 5)
plot(as.phylo(h), type = "fan", tip.color = colors[clus4],
     label.offset = 0.005, cex = 0.7)

out.tree = write.tree(as.phylo(h))

PC1var = Eval.df[1, "V1"]/sum(Eval.df$V1) * 100
PC2var = Eval.df[2, "V1"]/sum(Eval.df$V1) * 100

pca.plot = ggplot(data = Evec.df, aes(y = PC1, x = PC2, color = Region, shape = r9))  + geom_point(size = 4) + 
  scale_color_manual(values = c("#b8553c",
                                "#46c19a",
                                "#9750a1",
                                "#6da14c",
                                "#6777cf",
                                "#be9d3c",
                                "#b94a73")) + 
  scale_shape_manual(values = c(8,7,2)) + 
  # geom_text(
  # label = Evec.df$Sample_ID,
  # nudge_x = 0.25, nudge_y = 0.25, 
  # ) + 
  labs(title = "Principal Component Analysis - r9", x = paste("PC2 (", round(PC2var, digits = 4), "%)"), y = paste("PC1 (", round(PC1var, digits = 4), "%)")) + 
  theme_classic() +
  theme(legend.position = "right", 
        axis.text.x = element_text(size = 16),
        axis.text.y = element_text(size = 16),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        legend.text = element_text(size = 16),
        legend.title = element_text(size = 16))

pca.plot

ggsave("./PCA_r9.png", pca.plot, width = 15, height = 10, dpi = 600)


