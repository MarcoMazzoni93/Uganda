# Index of tables


### Table 1. *Apis mellifera scutellata* and *Apis mellifera monticola* dataset and genetic differentiation (FST).
The symmetric matrix represent the genome wide comparison between all population involved in this study. The low FST values highlight the very small genetic difference between highland and lowland honey bees in East Africa.
| Region | Population | Label* | n | MF | MS | MKF | MKS | RWHL | RWLL |
| ------ | ---------- | ------ | --- | --- | --- | --- | --- | ---- | ---- |
| Mau | highland | MF | 10 | - | 0.009 | 0.004 | 0.004 | 0.012 | 0.016 |
|     | lowland | MS | 10 | 0.009 | - | 0.011 | 0.002 | 0.016 | 0.022 |
| Mt. Kenya | highland | MKF | 10 | 0.004 | 0.011 | - | 0.009 | 0.015 | 0.028|
|           | lowland | MKS | 9 | 0.004 | 0.002 | 0.009 | - | 0.017 | 0.023 |
| Rwenzori | highland | RWHL | 18 | 0.012 | 0.016 | 0.015 | 0.017 | - | 0.024 |
|          | lowland | RWLL | 6 | 0.024 | 0.022 | 0.028 | 0.023 | 0.024 | - |
###### *MF: Mau forest, MS: Mau savannah, MKF: Mt. Kenya forest, MKS: Mt. Kenya savannah, RWHL: Rwenzori forest, RWLL: Rwenzori savannah.

### Table 2. Frequency of r7 and r9 inversion polymorphisms in the three considered populations, and relative FST values when compared to other populations.
The frequency reported is the frequency of the INV allele over the overall number of alleles; the lower triangle shows FST. values relative to the r  7 inversion; the upper triangle shows FST values relative to the r9 inversions.

| | | | | | | Genetic | differentiation | (FST) | |
|---|---|---|---|---|---|---|---|---|---|
| | | | Frequency | r9 |
| | Label* | r7 | r9 | MF | MS | MKF | MKS | RWHL | RWLL |
|r7| MF | 0.9 | 0.9 | - | 0.108 | 0.005 | 0.176 | 0.067 | 0.279 |
| | MS | 0.1 | 0.1 | 0.348 | - | 0.131 | 0.007 | 0.167 | 0.067 |
| | MKF | 1.0 | 0.89 | 0.045 | 0.480 | - | 0.199 | 0.073 | 0.242 |
| | MKS | 0.2 | 0.2 | 0.442 | 0.035 | 0.563 | - | 0.226 | 0.011 |
| | RWHL | 0.89 | 0.92 | 0.099 | 0.410 | 0.150 | 0.493 | - | 0.279 |
| | RWLL | 0.25 | 0.08 | 0.309 | 0.024 | 0.493 | 0.139 | 0.395 | - |
###### *MF: Mau Forest; MS: Mau Savannah; MKF: Mount Kenya Forest; MKS: Mount Kenya Savannah; RWHL: Rwenzori Highland; RWLL: Rwenzori Lowland.

### Table 3. GO enrichment analysis using DEGs. 
The threshold selected was ±0.7 log2FC and p-value ≤ 0.05. MF: Molecular Function, BP: Biological Process, CC: Cellular component and KEGG: Kyoto Encyclopedia of Genes end Genomes.

| Gene Ontology | Description | Source | pvalue |
| -------- | ------- | ------ | ---------- |
| GO:0016491 | oxidoreductase activity | MF | 0.0011 |
| GO:0102965 | alcohol-forming long-chain fatty acyl-CoA reductase activity |	MF | 0.0086 |
| GO:0016620 | oxidoreductase activity, acting on the aldehyde or oxo group of donors, NAD or NADP as acceptor | MF | 0.0277 |
| GO:0016885 | ligase activity, forming carbon-carbon bonds |	MF | 0.0353 |
| GO:0080019 | alcohol-forming very long-chain fatty acyl-CoA reductase activity | MF | 0.0498 |
| GO:0044281 | small molecule metabolic process	| BP | 0.000126 |
| GO:0019752 | carboxylic acid metabolic process | BP | 0.000313 |
| GO:0043436 | oxoacid metabolic process | BP | 0.000313 |
| GO:0006739 | NADP metabolic process | BP | 0.000317 |
| GO:0006082 | organic acid metabolic process | BP | 0.000336 |
| GO:0032787 | monocarboxylic acid metabolic process | BP | 0.000352 |
| GO:0044283 | small molecule biosynthetic process | BP |	0.000441 |
| GO:0072330 | monocarboxylic acid biosynthetic process | BP | 0.000485 |
| GO:0006633 | fatty acid biosynthetic process | BP | 0.000485 |
| GO:0046394 | carboxylic acid biosynthetic process | BP | 0.00206 |
| GO:0016053 | organic acid biosynthetic process | BP | 0.00236 |
| GO:0006631 | fatty acid metabolic process | BP | 0.00259 |
| GO:0072524 | pyridine-containing compound metabolic process | BP | 0.00643 |
| GO:1901568 | fatty acid derivative metabolic process | BP | 0.00892 |
| GO:0006740 | NADPH regeneration | BP | 0.00892 |
| GO:0051156 | glucose 6-phosphate metabolic process | BP | 0.00892 |
| GO:0006098 | pentose-phosphate shunt | BP | 0.00892 |
| GO:0006629 | lipid metabolic process | BP | 0.0142 |
| GO:0005975 | carbohydrate metabolic process | BP | 0.0355 | 
| KEGG:01100 | Metabolic pathways | KEGG | 0.0407 | 
| KEGG:01212 | Fatty acid metabolism | KEGG | 0.00796 | 
| KEGG:01200 | Carbon metabolism | KEGG | 0.0168 | 
| KEGG:00030 | Pentose phosphate pathway | KEGG | 0.0286 | 
| KEGG:04146 | Peroxisome | KEGG | 0.0315 |

### Table 4. Genes detected both by selection scan and differentially expressed genes analysis
when only the p-value is considered. A star (*) near the log2FC value means that it is above/below the selected threshold of ± 0.7.

| Gene ID |	Chromosome | XP-nsl | log2FC | DEG p-value |
| ------- | ---------- | ------ | ------ | ----------- |
| LOC551356 | CM009931.2 | 3.38 | 0.485 | 3.82e-02 |
| LOC551123 | CM009932.2 | 3.41 | 0.658 | 1.88e-02 |
| LOC411053	| CM009934.2 | 3.51 | -0.951*	| 1.03e-02 |
| LOC100578929 | CM009936.2 | 4.69 | -1.399* | 3.66e-02 |
| LOC413698	| CM009937.2 | 6.15 | 1.033* | 3.62e-02 |
| LOC726656 | CM009937.2 | 6.77 |	0.628 |	4.71e-02 |
| LOC102656070 | CM009937.2 | 5.43 | -0.587 |	4.49e-02 |
| LOC725031 | CM009939.2 | 2.39 |	-1.354* |	2.93e-04 |
| LOC408315 | CM009941.2 | 2.83 |	-0.576 |4.48e-02 |
| LOC408343 | CM009941.2 | 3.78 |	0.686 | 1.89e-02 |
| LOC411569 | CM009945.2 | 3.23 |	-0.812* | 4.71e-02 |
| LOC552844 | CM009945.2 | 3.71 |	0.682 | 2.22e-02 |

### Table 5. Significant differentially expressed genes (DEGs) with a model accounting for inversion status only. Tukey Honestly Significance Difference (HSD) test was applied to understand weather all three groups, Inverted homozygous (INV), Non-Inverted homozygous (STD) and heterozygous (HET), where equal or different. A star (*) near the p-value represent a significance level of α ≤ 0.05, two stars near the p-value represent a significance level of α ≤ 0.001.
| Gene ID | log<sub>2</sub>FC | p-value (DESeq2) | Comparison | p-value (Tukey HSD) |
| ------- | ----------------- | ---------------- | ---------- | ------------------- |
|         |                   |                  | STD - INV  | 6.58e-04**          |
|LOC413698| 1.582             | 7.50e-05**       | STD - HET  | 3.19e-02*           |


# Index of supplementary tables

Supplementary tables can be found in the file ./Supplementary Tables.xlsx

### Supplementary Table 1. Uganda elevation collection and coordinates
### Supplementary Table 2. Samples included in the study and relatives coordinates of collection (where it was described in the original paper)
### Supplementary Table 3. List of SNPs with FST higher than 0.5 falling inside the r7 region. The INFO field states if the mutation is synonymous or non synonymous and the gene associated to it
### Supplementary Table 4. List of SNPs with FST higher than 0.5 falling inside UTRs regions. The INFO field states if the mutation is relative to the 5' or 3' UTR and the gene associated to it
### Supplementary Table 5. Genes falling inside 5% windows in Mau region
### Supplementary Table 6. Genes falling inside 5% windows in Mt. Kenya region
### Supplementary Table 7. Genes falling inside 5% windows in Rwenzori mountain region
### Supplementary Table 8. GO terms for selection scan analysis of Mau region population
### Supplementary Table 9. GO terms for selection scan analysis of the Mt. Kenya population
### Supplementary Table 10. GO terms for selection scan analysis of the Rwenzori mountains population
### Supplementary Table 11. Unique and common genes related to GO:0004930. UGD: Rwenzori mountains population, MTK: Mt. Kenya population, MAU: Mau region population.
