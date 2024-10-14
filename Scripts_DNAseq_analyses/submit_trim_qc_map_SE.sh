#!/bin/bash

#Input file from input parameters
CORES=$1
MEM=$2
TIME=$3
WORKTMP=$4
input_fastq=$5
REF=$6
SAMPLE_FILE=$7

#Declare other variables
ref=$(echo "${REF}" | rev | cut -d'/' -f1 | cut -c 4- | rev)

while IFS= read -r line; do
        #  Split each line for useful further parameters
        # Sample name
        acc=$(echo "${line}" | cut -f1)
	
	sbatch \
                --time=$TIME \
                --mem=$MEM \
                --cpus-per-task=$CORES \
                --job-name=cut_map_SE_$acc \
                --output=./log_files/cut_map_SE_$acc.log \
                --error=./log_files/cut_map_SE_$acc.error.log \
                --partition=single \
                --export=CORES=$CORES,WORKTMP=$WORKTMP,input_fastq=$input_fastq,REF=$REF,acc=$acc \
                ./script_trim_qc_map_SE.sh

done < $WORKTMP/$SAMPLE_FILE



#USAGE:  # ./submit_trim_qc_map_SE.sh <CORES> <MEM> <TIME> <WORKTMP> <input_fastq> <REF> <SAMPLE_FILE>
