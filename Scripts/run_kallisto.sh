#!/bin/bash

declare -a samples=( IV1 IV2 IV3 V2 V3 V4 VI1 VI2 VI3 VII1 VII2 VII3 )

kallisto index -i ./Amel.idx ./Apis_mellifera.Amel_HAv3.1.cds.all.fa

for i in "${array[@]}"; do
  kallisto quant -i Amel.idx -o ${i} ./raw_data/${i}_1.fq.gz ./raw_data/${i}_2.fq.gz --bias
done
