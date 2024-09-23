#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Apr 24 08:40:47 2024

@author: fortytwo
"""

### Create txt2gene from transcriptome
### get the line of fasta with cat + grep '>' command : cat Apis_mellifera.Amel_HAv3.1.cds.all.fa | grep '>' > fasta_line.fa


file = open("./fasta_line.fa")
tx2gene = open("./tx2gene.txt", "w")
fasta = []
for line in file:
  if line.rstrip().split(" ")[3].split(":")[1][0] == "L":
    Gene_ID = line.rstrip().split(" ")[3].split(":")[1].split("LOC")[1]
  else:
   Gene_ID = line.rstrip().split(" ")[3].split(":")[1].split("GeneID_")[1]
   Transcript_name = line.rstrip().split(" ")[0].split(">")[1]
  tx2gene.write(Transcript_name + "\t" + Gene_ID + "\n")
tx2gene.close()
