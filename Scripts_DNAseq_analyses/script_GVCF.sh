#!/bin/bash
# USAGE:  # ./script_GVCF.sh <WORKTMP> <REF> <CHR>

## Input parameters
#WORKTMP=$1
#REF=$2
#CHR=$3

## Declare other variables ##
outputTMP=$WORKTMP/05a_output_jointgenotyping
inputTMP=$WORKTMP/04_output_SNPcalling

## Required software ##
GATK4=<path_to_gatk-4.3.0.0>/gatk

## Create necessary directories ##
mkdir $outputTMP
cd $outputTMP

## Start pipeline ##
echo ""
echo "Start script"
date

### Joint Genotyping with GATK ###
echo "Generating sample map of g.vcf files..."
ls $inputTMP/*.gatk.g.vcf > $outputTMP/gvcfs.sample_map_TEMP_$CHR
rm $outputTMP/gvcfs.sample_map_$CHR

while IFS= read -r line; do
	acc=$(echo "${line}" | rev | cut -d'/' -f1 | rev | cut -d'.' -f1)
       	echo -e "$acc\t$line" >> $outputTMP/gvcfs.sample_map_$CHR
done <  $outputTMP/gvcfs.sample_map_TEMP_$CHR
rm $outputTMP/gvcfs.sample_map_TEMP_$CHR

echo "Removing previous database"
rm -rf mydatabase

echo "Creating new GDBI..."
$GATK4 --java-options '-Xmx16G -Xms16G' GenomicsDBImport \
	--genomicsdb-workspace-path mydatabase_$CHR \
	--batch-size 20 \
	-R $REF -L $CHR \
	--sample-name-map $outputTMP/gvcfs.sample_map_$CHR \
	--reader-threads 5

echo "Joint genotyping..."
$GATK4 --java-options '-Xmx15G -Xms8G' GenotypeGVCFs \
       	-R $REF \
	-V gendb://mydatabase_$CHR \
	-O $outputTMP/"$CHR".vcf

echo "Delete mydatabase"
rm -rf $outputTMP/mydatabase_$CHR

## End ##
echo "DONE!"
date
echo ""
