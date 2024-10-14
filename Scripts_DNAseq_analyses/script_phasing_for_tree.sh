#!/bin/bash
 
##USAGE:  # ./script_phasing_for_tree.sh <WORKDIR> <REF>

# Input parameters
WORKTMP=$1
REF=$2

## Declare other variables ##
inputTMP=$WORKTMP/06a_output_vcf

## Required software ##
beagle=<path_to_beagle>/beagle.22Jul22.46e.jar
GATK4=<path_to_gatk-4.3.0.0>/gatk
module load devel/miniconda/4.9.2
source activate SNP_filtering   # Includes: tabix

## Create necessary directories ##
cd $WORKTMP

## Start pipeline ##
echo ""
echo "Start script"
date

# Index vcf
tabix -p vcf $inputTMP/Merged_all_samples_thrive_out_filtered_indv.vcf.gz

##Keep only chromosomes
echo "keep only chromosomes"

$GATK4 --java-options "-Xmx8G" SelectVariants \
      -R $REF \
      -V $inputTMP/Merged_all_samples_thrive_out_filtered_indv.vcf.gz \
      -L $WORKTMP/chromosomes.intervals \
      -O $inputTMP/Merged_all_samples_thrive_out_chromosomes.vcf.gz

# Phasing with beagle
echo "Phasing with beagle"
java -XX:-UseGCOverheadLimit -Xmx100g -jar $beagle gt=$inputTMP/Merged_all_samples_thrive_out_chromosomes.vcf.gz nthreads=10 impute=false out=$inputTMP/Merged_all_samples_thrive_out_filtered_chromosomes_phased

# Index vcf
tabix -p vcf $inputTMP/Merged_all_samples_thrive_out_filtered_chromosomes_phased.vcf.gz

conda deactivate

## End ##
echo "DONE!"
date
echo ""
