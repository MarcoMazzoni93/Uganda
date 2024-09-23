#### Plot Heatmap
#### Adapted from https://sfustatgen.github.io/LDheatmap/articles/vcfOnLDheatmap.html#getting-started

convertToNumeric <- function(x){
  gdat <- matrix(NA,nrow = nrow(x), ncol = ncol(x))
  for (m in 1:nrow(x)){
    for (n in 1:ncol(x)){
      a <-as.numeric(unlist(strsplit(x[m,n], "|"))[1]) 
      
      b <- as.numeric(unlist(strsplit(x[m,n], "|"))[3])
      gdat[m,n] <- a+b
    }
  }
  rownames(gdat) <- rownames(x)
  colnames(gdat) <- colnames(x)
  return(gdat)
}

library(vcfR)
library(snpStats)
library(LDheatmap)
library(GWLD)

setwd("/media/fortytwo/Heart_of_Gold/selscan/SelScan_scores/Selection_Scan_UGD_KYWall/LDHEATMAP/")

snp_chr7 <- read.vcfR("./chr7_thinned_1OUT5.vcf") ### File with 1 SNP every n SNP, we decided to select one SNP every 50 (Python Script)
snp_chr9 <- read.vcfR("./chr9_thinned_1OUT5.vcf")

sample_info_bees <- read.csv("./Sample_info_bees.csv", sep = "\t")
info_chr7 <- read.csv("snp_id_dist_chr7_thinned_1OUT5.csv")
info_chr9 <- read.csv("snp_id_dist_chr9_thinned_1OUT5.csv")

chr7 <- sample_info_bees[sample_info_bees$Population %in% c("A-Lineage"), c(1, 2)]
chr9 <- sample_info_bees[sample_info_bees$Population %in% c("A-Lineage"), c(1, 2)]

chr7_gt <- snp_chr7@gt[,colnames(snp_chr7@gt) %in% chr7[,1]]
chr9_gt <- snp_chr9@gt[,colnames(snp_chr9@gt) %in% chr9[,1]]

chr7_snpMat <- t(chr7_gt)
chr9_snpMat <- t(chr9_gt)

chr7_snpMat.numeric <- convertToNumeric(chr7_snpMat)
chr9_snpMat.numeric <- convertToNumeric(chr9_snpMat)

snpNames_chr7 <- info_chr7$id
snpNames_chr9 <- info_chr9$id

colnames(chr7_snpMat.numeric) <- snpNames_chr7 
colnames(chr9_snpMat.numeric) <- snpNames_chr9 

chr7_snpMat.numeric <- as(chr7_snpMat.numeric, "SnpMatrix")
chr9_snpMat.numeric <- as(chr9_snpMat.numeric, "SnpMatrix")

bluepalette <- colorRampPalette(c("blue", "lightgrey"), space = "rgb")(255)
greenpalette <- colorRampPalette(c("darkgreen", "lightgrey"), space = "rgb")(50)

png(filename = "./LDchr7.png", width = 5, height = 5, res = 1200, units = "in")
LDheatmap(chr7_snpMat.numeric, info_chr7$dist, title = "CM009937.2", flip = TRUE, color = bluepalette, add.map = FALSE)
dev.off()

png(filename = "./LDchr9.png", width = 5, height = 5, res = 1200, units = "in")
LDheatmap(chr9_snpMat.numeric, info_chr7$dist, title = "CM009939.2", flip = TRUE, color = greenpalette, add.map = FALSE)
dev.off()

