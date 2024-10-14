#!/bin/bash

# Input file from input parameters
CORES=$1
MEM=$2
TIME=$3
WORKTMP=$4
REF=$5
CHR_names=$6

# Loop though contigs based on $ref.fai
while IFS= read -r line; do
        # Chromosome and Contig names
        CHR=$(echo "${line}" | cut -f1)

	sbatch \
                --time=$TIME \
                --mem=$MEM \
                --cpus-per-task=$CORES \
                --job-name=Jointgenotyping_$CHR \
                --output=./log_files/Jointgenotyping_$CHR.log \
                --error=./log_files/Jointgenotyping_$CHR.error.log \
                --partition=single \
                --export=WORKTMP=$WORKTMP,REF=$REF,CHR=$CHR \
                ./script_GVCF.sh
done < $WORKTMP/$CHR_names

# USAGE:  # ./submit_GVCF.sh <CORES> <MEM> <TIME> <WORKTMP> <REF> <CHR_names>
