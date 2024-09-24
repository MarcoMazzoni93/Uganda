#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep 17 15:23:00 2024

@author: fortytwo
"""

### create the info file for the LDheatmap.R
### This adds the position in both fields. But you can modify the first one to allow for SNP name.


file_name = "filteredvcf.vcf"

VCF = []
for line in open(file_name):
    if line.rstrip().split("\t")[0][0] == "#":
        if line.rstrip().split("\t")[0] == "#CHROM":
            header = line.rstrip().split("\t")
        else:
            continue
    else:
        VCF.append(line.rstrip().split("\t"))

out = open("infofile.csv", "w")
out.write("\tid\tdist\n")
for i in range(len(VCF)):
    out.write(str(i) + "\t" + VCF[i][1] + "\tsnp" + VCF[i][1] + "\n")
out.close()#                                            |
#                                                       |
#                                                       |
#                                                       ⌄            
#                                               You can modify this to allow for VCF[i][2] and remove snp from the string.
