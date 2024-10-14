#!/bin/bash

# Input file from input parameters
CORES=$1
MEM=$2
TIME=$3
WORKTMP=$4
REF=$5
sample_file=$6

# Loop to read input_file line by line
while IFS= read -r line; do
#  Split each line for useful further parameters
	acc=$(echo "${line}" | cut -f1)

	sbatch \
                --time=$TIME \
                --mem=$MEM \
                --cpus-per-task=$CORES \
                --job-name=SNPcalling_$acc \
                --output=./log_files/SNPcalling_$acc.log \
                --error=./log_files/SNPcalling_$acc.error.log \
                --partition=single \
                --export=WORKTMP=$WORKTMP,REF=$REF,acc=$acc \
                ./script_GATK.sh

done < $WORKTMP/$sample_file

# USAGE:  # ./submit_GATK.sh <CORES> <MEM> <TIME> <WORKTMP> <REF> <sample_file>
