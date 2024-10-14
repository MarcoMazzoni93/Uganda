#!/bin/bash
# USAGE:  # ./script_qc_trim.sh <CORES> <WORKTMP> <input_fastq> <REF> <acc>

# Input parameters
#CORES=$1
#WORKTMP=$2
#input_fastq=$3
#REF=$4
#acc=$5

# Declare other variables
length=50
ref=$(echo "${REF}" | rev | cut -d'/' -f1 | cut -c 4- | rev)
output_fastqc=$WORKTMP/03_output_fastqc
output=$WORKTMP/02_output_trim_map

# Required software
module load devel/miniconda/4.9.2
source activate bioinfo_basics_2023 # Includes: Fastqc, Bwa, Samtools, GATK4, Cutadapt

# Create necessary directories
mkdir $output_fastqc
mkdir $output

# Start pipeline
echo ""
echo "Start"
date

## ADAPTOR TRIMMING ##

echo "Trimming adapters..." 
cutadapt -j $CORES -q 15,10 \
	-b TruSeq1=AGATCGGAAGAGC -b Nextera1=CTGTCTCTTATACACATCT -b Nextera1rc=AGATGTGTATAAGAGACAG \
	-B TruSeq2=AGATCGGAAGAGC -B Nextera2=CTGTCTCTTATACACATCT -B Nextera2rc=AGATGTGTATAAGAGACAG \
	--trim-n \
	--minimum-length $length \
	-o $output/$acc.cutadapt.R1.fastq.gz --paired-output $output/$acc.cutadapt.R2.fastq.gz \
	$input_fastq/$acc.R1.fastq.gz $input_fastq/$acc.R2.fastq.gz

# Quality control of raw and processed reads
echo "QC before trimming..."
fastqc -t $CORES -o $output_fastqc $input_fastq/$acc.R1.fastq.gz $input_fastq/$acc.R2.fastq.gz
echo "QC after trimming..."
fastqc -t $CORES -o $output_fastqc $output/$acc.cutadapt.R1.fastq.gz $output/$acc.cutadapt.R2.fastq.gz

## MAPPING ##
echo "Mapping..."
bwa mem -t $CORES \
	-R "@RG\tID:$acc\tSM:$acc" $REF $output/$acc.cutadapt.R1.fastq.gz $output/$acc.cutadapt.R2.fastq.gz \
	| samtools view -@ $CORES -Sbh - > $output/$acc.bam

# Sort bam file
echo "Sorting bam file..."
samtools view -@ $CORES -bh $output/$acc.bam \
	| samtools sort -@ $CORES - > $output/$acc.sort.bam

samtools index $output/$acc.sort.bam

# Remove unnecesary intermediate files
rm $output/$acc.bam

conda deactivate

echo "DONE!"
date
echo ""
