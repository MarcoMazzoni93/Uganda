# Script Repo for Uganda project

### DEGs_and_PLOTS.Rmd
This script was used to analyse RNA-seq data and to make the volcano plot in /Uganda_DEGs/Figures/Figure 5.png

### Filter_one_every_nsnp.py
This python script is used to filter a VCF file. It will select one SNP every N SNPs, based on user decision

### HapDiff.py
This script was used to analyze differences in FST between Kenyan and Ugandan Inverted homozygous.

### LDheatmap.R
This script was used to plot the r^2 heatmaps in /Uganda_DEGs/Figures/Figure 2.png

### Run_selscan.sh
Bash script used to get per SNP XP-nsl values

### Run_norm_winsize.sh
Bash script to normalize results of XP-nsl and to get significant regions of genomes involved in adaptation to high-elevation

### plotPCA.R
Rscript to plot Principal component analysis, and to output the tree used to plot /Uganda_DEGs/Figures/Figure 1.png and /Uganda_DEGs/Figures/Figure 3.png

### pltXPnsl.R
Rscript to plot the XP-nsl values and an average based on a sliding window

### run_kallisto.sh
Script used to make Transcriptome index (Amel.idx) and run callisto to quantify counts

### venn_diag.R
Rscript used to plot shared and unique genes detected from XP-nsl analysis

