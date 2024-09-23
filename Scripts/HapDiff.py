#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed May 15 08:37:22 2024

@author: fortytwo
"""

import os
import sys

def out_write_freq(list_freq, out_file_name):
    out_stream = open(out_file_name, "w")
    for i in range(len(list_freq)):
        for j in range(len(list_freq[i])):
            out_stream.write(list_freq[i][j] + "\t")
        out_stream.write("\n")

    out_stream.close()
    return 0


def frequency_fst(list_roi, file_name, ken_len, ugd_len):

    if len(list_roi) != 0:
        VCF = []
        for line in open(file_name):
            if line.rstrip().split("\t")[0][0] == "#":
                if line.rstrip().split("\t")[0] == "#CHROM":
                    header = line.rstrip().split("\t")
                else:
                    continue
            else:
                VCF.append(line.rstrip().split("\t"))
        
        
        result_final = []
        for i in range(len(VCF)):
            
            freq_ugd = 0.0
            freq_ken = 0.0
            result_array = []
            
            for j in range(9, len(VCF[i])):
                if j < 9 + ken_len:
                    snp = VCF[i][j].split("|")
                    for n in range(len(snp)):
                        if int(snp[n]) == 1:
                            freq_ken += 1
                else:
                    snp = VCF[i][j].split("|")
                    for n in range(len(snp)):
                        if int(snp[n]) == 1:
                            freq_ugd += 1
            result_array.append(VCF[i][1])
            result_array.append(VCF[i][3])
            result_array.append(VCF[i][4])
            result_array.append(str(freq_ken/(ken_len*2)))
            result_array.append(str(freq_ugd/(ugd_len*2)))
            result_final.append(result_array)
        
        return(result_final)
    else:
        return 0


vcf = sys.argv[1] #already the r7r9 filtered for inverted only.
region = sys.argv[2] #r7 or r9 or r7BI or r7BII
th = float(sys.argv[3]) #threshold for fst significance

dir_ = "/media/fortytwo/Heart_of_Gold/selscan/SelScan_scores/Selection_Scan_UGD_KYWall/r7B/"

#### FST

os.system("vcftools --vcf " + vcf + " --weir-fst-pop ./Ken_" + region + " --weir-fst-pop ./Ugd_" + region + " --out fst_" + region)

#### FST positions


fst = []
pos = []
file = "fst_" + region + ".weir.fst"

for line in open(file):
    if line.rstrip().split("\t")[0] == "CHROM":
        continue
    else:
        if float(line.rstrip().split("\t")[2]) >= float(th):
            fst.append(line.rstrip().split("\t"))
            pos.append(line.rstrip().split("\t")[0:2])

fst_out = open("fst." + region, "w")
for i in range(len(fst)):
    for j in range(len(fst[i])):
        fst_out.write(fst[i][j] + "\t")
    fst_out.write("\n")

pos_out = open("pos." + region, "w")
for i in range(len(pos)):
    for j in range(len(pos[i])):
        pos_out.write(pos[i][j] + "\t")
    pos_out.write("\n")

pos_out.close()
fst_out.close()


os.system("vcftools --vcf " + vcf + " --positions pos." + region + " --recode --out fst_filtered_" + region)
os.system("vcf2bed < fst_filtered_" + region + ".recode.vcf > fst_filtered_" + region + ".bed")
os.system("cat fst_filtered_" + region + ".bed | bedtools intersect -wb -a Amel_GFF_SF.gff3 -b stdin | awk '$3==\"gene\"' > gene_" + region + ".gene")

###GEN
gen = []
for i in open("gene_" + region + ".gene"):
    gen_tmp = []
    if i.rstrip().split("\t") != []:
        gen_tmp.append(i.rstrip().split("\t")[0])
        gen_tmp.append(i.rstrip().split("\t")[3])
    gen.append(gen_tmp)

if len(gen) > 0:
    gen_pos_out = open("gene_" + region + ".pos", "w")
    for i in range(len(gen)):
        for j in range(len(gen[i])):
            gen_pos_out.write(gen[i][j] + "\t")
        gen_pos_out.write("\n")
    gen_pos_out.close()

if len(gen) > 0:
    os.system("vcftools --vcf " + vcf + " --positions gene_" + region + ".pos --recode --out gene_vcf" + region)


os.system("cat fst_filtered_" + region + ".bed | bedtools intersect -wb -a Amel_GFF_SF.gff3 -b stdin | awk '$3==\"CDS\"' > CDS_" + region + ".cds")
os.system("cat fst_filtered_" + region + ".bed | bedtools intersect -wb -a Amel_GFF_SF.gff3 -b stdin | awk '$3==\"three_prime_UTR\"' > 3UTR_" + region + ".3")
os.system("cat fst_filtered_" + region + ".bed | bedtools intersect -wb -a Amel_GFF_SF.gff3 -b stdin | awk '$3==\"five_prime_UTR\"' > 5UTR_" + region + ".5")


### EXTRACT SNPs from bedtools result.


###CDS
cds = []
for i in open("CDS_" + region + ".cds"):
    cds_tmp = []
    if i.rstrip().split("\t") != []:
        cds_tmp.append(i.rstrip().split("\t")[0])
        cds_tmp.append(i.rstrip().split("\t")[3])
    cds.append(cds_tmp)


if len(cds) > 0:
    cds_pos_out = open("CDS_" + region + ".pos", "w")
    for i in range(len(cds)):
        for j in range(len(cds[i])):
            cds_pos_out.write(cds[i][j] + "\t")
        cds_pos_out.write("\n")
    cds_pos_out.close()


###3UTR
utr_3 = []
for i in open("3UTR_" + region + ".3"):
    utr_3_tmp = []
    if i.rstrip().split("\t") != []:
        utr_3_tmp.append(i.rstrip().split("\t")[0])
        utr_3_tmp.append(i.rstrip().split("\t")[3])
    utr_3.append(utr_3_tmp)

if len(utr_3) > 0:
    utr_3_pos_out = open("3UTR_" + region + ".pos", "w")
    for i in range(len(utr_3)):
        for j in range(len(utr_3[i])):
            utr_3_pos_out.write(utr_3[i][j] + "\t")
        utr_3_pos_out.write("\n")
    utr_3_pos_out.close()


###5UTR
utr_5 = []
for i in open("5UTR_" + region + ".5"):
    utr_5_tmp = []
    if i.rstrip().split("\t") != []:
        utr_5_tmp.append(i.rstrip().split("\t")[0])
        utr_5_tmp.append(i.rstrip().split("\t")[3])
    utr_5.append(utr_5_tmp)

if len(utr_5) > 0:
    utr_5_pos_out = open("5UTR_" + region + ".pos", "w")
    for i in range(len(utr_5)):
        for j in range(len(utr_5[i])):
            utr_5_pos_out.write(utr_5[i][j] + "\t")
        utr_5_pos_out.write("\n")
    utr_5_pos_out.close()
    
### Filter VCF (Again)
if len(cds) > 0:
    os.system("vcftools --vcf " + vcf + " --positions CDS_" + region + ".pos --recode --out CDS_vcf" + region)
if len(utr_3) > 0:
    os.system("vcftools --vcf " + vcf + " --positions 3UTR_" + region + ".pos --recode --out 3UTR_vcf" + region)
if len(utr_5) > 0:
    os.system("vcftools --vcf " + vcf + " --positions 5UTR_" + region + ".pos --recode --out 5UTR_vcf" + region)
    
###FREQUENCY COUNTING (Last step)

#Count kenya_number
KEN = []
for line in open("Ken_" + region):
    KEN.append(line.rstrip())
ken_len = len(KEN)


#Count Uganda_number
UGD = []
for line in open("Ugd_" + region):
    UGD.append(line.rstrip())
ugd_len = len(UGD)




#FREQUENCY AND MAPPING TO GENE AGAIN
FREQ_FST = frequency_fst([0, 0], "fst_filtered_" + region + ".recode.vcf", ken_len, ugd_len)
out_write_freq(FREQ_FST, "fst_" + region + "_05_frequencies")


if len(gen) > 0:
    FREQ_GEN = frequency_fst(gen, "gene_vcf" + region + ".recode.vcf", ken_len, ugd_len)
    out_write_freq(FREQ_GEN, "gene_freq_" + region)
if len(cds) > 0:
    FREQ_CDS = frequency_fst(cds, "CDS_vcf" + region + ".recode.vcf", ken_len, ugd_len)
    out_write_freq(FREQ_CDS, "cds_freq_" + region)
    os.system("vcf2bed < CDS_vcf" + region + ".recode.vcf > " + region + "_CDS_bed.bed") 
    os.system("cat " + region + "_CDS_bed.bed | bedtools intersect -wb -a Amel_GFF_SF.gff3 -b stdin | awk '$3==\"gene\"' > CDS_mapped2gene_" + region + ".gene")    
if len(utr_3) > 0:
    FREQ_3UT = frequency_fst(utr_3, "3UTR_vcf" + region + ".recode.vcf", ken_len, ugd_len)
    out_write_freq(FREQ_3UT, "gene_freq_" + region)
    os.system("vcf2bed < 3UTR_vcf" + region + ".recode.vcf > " + region + "_3utr_bed.bed") 
    os.system("cat " + region + "_3utr_bed.bed | bedtools intersect -wb -a Amel_GFF_SF.gff3 -b stdin | awk '$3==\"gene\"' > 3UTR_mapped2gene_" + region + ".gene")
if len(utr_5) > 0:
    FREQ_5UT = frequency_fst(utr_5, "5UTR_vcf" + region + ".recode.vcf", ken_len, ugd_len)
    out_write_freq(FREQ_5UT, "gene_freq_" + region)
    os.system("vcf2bed < 5UTR_vcf" + region + ".recode.vcf > " + region + "_5utr_bed.bed") 
    os.system("cat " + region + "_5utr_bed.bed | bedtools intersect -wb -a Amel_GFF_SF.gff3 -b stdin | awk '$3==\"gene\"' > 5UTR_mapped2gene_" + region + ".gene")
