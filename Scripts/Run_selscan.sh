#!/bin/bash

declare -a chromosomes=( chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 )

for i in "${chromosomes[@]}"; do

	selscan --xpnsl --vcf Mountain_Pop.${i}.vcf --vcf-ref Savannah_Pop.${i}.vcf --out Pop.${i}

done
