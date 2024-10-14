#!/bin/bash
# USAGE:  # ./scrip_filter_vcfs.sh <WORKTMP> <REF>

# Input parameters
WORKTMP=$1
REF=$2

## Declare other variables ##
outputTMP=$WORKTMP/07a_output_vcf_stats
inputTMP=$WORKTMP/06a_output_vcf

## Required software ##
module load devel/miniconda/4.9.2
source activate SNP_filtering # Includes: vcftools, vcflib, tabix, bcftools
GATK4=<path_to_gatk-4.3.0.0>/gatk
GATK3=<path_to_gatk-3.8.1.0>/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef

## Create necessary directories ##
mkdir $outputTMP
cd $WORKTMP

## Start pipeline ##
echo ""
echo "Start script"
date

# Indexing with GATK
echo "Index vcf"
$GATK4 --java-options -Xmx4G IndexFeatureFile \
	-I $inputTMP/Merged_all_samples_thrive_out.vcf.gz

## Generate Allele Balance Info field - Runs ca. 16 hours
echo "Annotate allele balance"
java '-Xmx5g' -jar $GATK3/GenomeAnalysisTK.jar -T VariantAnnotator \
	-R $REF \
	-V $inputTMP/Merged_all_samples_thrive_out.vcf.gz \
	-o $inputTMP/Merged_all_samples_thrive_out_AlleleBalance.vcf.gz \
	-A AlleleBalance \

## AB filter
echo "Apply AB filter"
vcffilter -s -f "ABHet > 0.25 & ABHet < 0.75 | ABHet < 0.01"  $inputTMP/Merged_all_samples_thrive_out_AlleleBalance.vcf.gz > $inputTMP/Merged_all_samples_thrive_out_ABfilter.vcf

## Zip and index vcf
bgzip $inputTMP/Merged_all_samples_thrive_out_ABfilter.vcf
tabix -p vcf $inputTMP/Merged_all_samples_thrive_out_ABfilter.vcf.gz

## Basic filters
bcftools view -O z -o $inputTMP/Merged_all_samples_thrive_out_basicfilters.vcf.gz -e 'MQ < 40 || MQRankSum < -5 || MQRankSum > 5 || ExcessHet > 20 || AC = 1 || INFO/DP < 11660 || INFO/DP > 21654 || AN < 826 || FS > 20 || SOR > 5 || QD < 5' $inputTMP/Merged_all_samples_thrive_out_ABfilter.vcf.gz

## Zip vcf
bgzip $inputTMP/Merged_all_samples_thrive_out_basicfilters.vcf
tabix -p vcf $inputTMP/Merged_all_samples_thrive_out_basicfilters.vcf.gz

## Remove indels, only biallelic
echo "Remove indels and keep biallelic SNPs"
bcftools view -O z -o $inputTMP/Merged_all_samples_thrive_out_filtered.vcf.gz -m2 -M2 -v snps $inputTMP/Merged_all_samples_thrive_out_basicfilters.vcf.gz

## Zip vcf
tabix -p vcf $inputTMP/Merged_all_samples_thrive_out_filtered.vcf.gz
 
echo "depth"
vcftools --gzvcf $inputTMP/Merged_all_samples_thrive_out_filtered.vcf.gz --depth --out $outputTMP/Merged_all_samples_thrive_out_filtered

## Filter missing individuals with missing data with less coverage than 6x
## A list was manually generated from the output file for depth

echo "Remove this individuals"
bcftools view -O z -o $inputTMP/Merged_all_samples_thrive_out_filtered_indv.vcf.gz --samples-file ^$WORKTMP/low_coverage_samples.txt $inputTMP/Merged_all_samples_thrive_out_filtered.vcf.gz

# Index vcf
tabix -p vcf $inputTMP/Merged_all_samples_thrive_out_filtered_indv.vcf.gz

conda deactivate

## End ##
echo "DONE!"
date
echo ""
