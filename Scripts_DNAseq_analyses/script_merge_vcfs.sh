#!/bin/bash
# USAGE:  # ./scrip_merge_vcfs.sh <WORKTMP>

# Input parameters
WORKTMP=$1

## Declare other variables ##
outputTMP=$WORKTMP/06a_output_vcf
inputTMP=$WORKTMP/05a_output_jointgenotyping

## Required software ##
GATK4=<path_to_gatk-4.3.0.0>/gatk
module load devel/miniconda/4.9.2
source activate bioinfo_basics_2023 # Includes: bcftools

## Create necessary directories ##
mkdir $outputTMP
cd $WORKTMP

## Start pipeline ##
echo ""
echo "Start script"
date

## Generating input file
echo "Generating vcf map of vcf files from single chromosomes and contigs"

rm $outputTMP/vcfs.map
ls $inputTMP/*.vcf > $outputTMP/vcfs.map

## Merge vcfs with bcftools ##
echo "Merge vcfs"

## Merge vcfs ##
bcftools concat --file-list $outputTMP/vcfs.map --output-type z --output $outputTMP/Merged_all_samples_thrive_out.vcf.gz

conda deactivate

## End ##
echo "DONE!"
date
echo ""
