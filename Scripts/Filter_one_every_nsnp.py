#!/usr/bin/env python3
# -*- coding: utf-8 -*-


###At the end copy paste the old header into the new one, and the new VCF works just fine

file_name = "file_to_filter.vcf"

VCF = []
for line in open(file_name):
    if line.rstrip().split("\t")[0][0] == "#":
        if line.rstrip().split("\t")[0] == "#CHROM":
            header = line.rstrip().split("\t")
        else:
            continue
    else:
        VCF.append(line.rstrip().split("\t"))
    

out = open("./filtered_vcf_file.vcf", "w")
for i in range(len(header)):
    out.write(header[i] + "\t")
out.write("\n")

VCF_thinned = []
for i in range(len(VCF)):
    if i % 35 == 0:
        for j in range(len(VCF[i])):
            out.write(VCF[i][j] + "\t")
        out.write("\n")

out.close()