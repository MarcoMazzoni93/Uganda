library(VennDiagram)



setwd("/media/fortytwo/Heart_of_Gold/selscan/SelScan_scores/Selection_Scan_UGD_KYWall/GO_enrichment/Mountains/")

ugd <- as.vector(read.table("./Comparisons/Genes/UGD.pos.wgs.txt")$V1)
mau <- as.vector(read.table("./Comparisons/Genes/M.pos.wgs.txt")$V1)
mtk <- as.vector(read.table("./Comparisons/Genes/MK.pos.wgs.txt")$V1)



ugd_mau <- intersect(ugd, mau)
ugd_mtk <- intersect(ugd, mtk)
mau_mtk <- intersect(mau, mtk)

ugd_mau_mtk <- intersect(intersect(ugd, mau), mtk)

ugd_mau <- setdiff(ugd_mau, ugd_mau_mtk)
ugd_mtk <- setdiff(ugd_mtk, ugd_mau_mtk)
mau_mtk <- setdiff(mau_mtk, ugd_mau_mtk)

ugd_unique <- setdiff(ugd, union(mau, mtk))
mau_unique <- setdiff(mau, union(ugd, mtk))
mtk_unique <- setdiff(mtk, union(ugd, mau))

write.table(ugd_unique, file = "./ugd_unique.csv", sep = "\t", row.names = FALSE, col.names = FALSE)
write.table(mau_unique, file = "./mau_unique.csv", sep = "\t", row.names = FALSE, col.names = FALSE)
write.table(mtk_unique, file = "./mtk_unique.csv", sep = "\t", row.names = FALSE, col.names = FALSE)
write.table(ugd_mau, file = "./ugd_mau.csv", sep = "\t", row.names = FALSE, col.names = FALSE)
write.table(ugd_mtk, file = "./ugd_mtk.csv", sep = "\t", row.names = FALSE, col.names = FALSE)
write.table(mau_mtk, file = "./mau_mtk.csv", sep = "\t", row.names = FALSE, col.names = FALSE)
write.table(ugd_mau_mtk, file = "./ugd_mau_mtk.csv", sep = "\t", row.names = FALSE, col.names = FALSE)



tan <- as.vector(read.table("/home/fortytwo/TANAB_DEGS.txt")$V1)
UGD <- as.vector(read.table("/home/fortytwo/UGD_DEGS.txt")$V1)

intersect(tan, UGD)


