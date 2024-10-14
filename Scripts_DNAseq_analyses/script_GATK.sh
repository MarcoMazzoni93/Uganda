#!/bin/bash
# USAGE:  # ./script_GATK.sh <WORKTMP> <REF> <ACC>

# Input parameters
#WORKTMP=$1
#REF=$2
#acc=$3

## Declare other variables ##
outputTMP=$WORKTMP/04_output_SNPcalling
inputTMP=$WORKTMP/02_output_trim_map

## Required software ##
GATK4=<path_to_gatk-4.3.0.0>/gatk

## Create necessary directories ##
mkdir $outputTMP
cd $WORKTMP

## Start pipeline ##
echo ""
echo "Start script"
date

## Variant calling with GATK ##
echo "Variant calling – GATK..."

## HaplotypeCaller ##   
$GATK4 --java-options "-Xmx8G" HaplotypeCaller \
	-R $REF \
	-I $inputTMP/$acc.sort.bam \
	-O $outputTMP/$acc.gatk.g.vcf \
	-ERC GVCF

## End ##
echo "DONE!"
date
echo ""
