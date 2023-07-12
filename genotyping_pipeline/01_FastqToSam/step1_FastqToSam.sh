#!/bin/bash
#$ -l highp,h_rt=10:00:00,h_data=6G
#$ -pe shared 3
#$ -N caracals_FastqToSam
#$ -cwd
#$ -m bea
#$ -M ckyriazi
#$ -o /u/scratch/c/ckyriazi/caracals/output/01_FastqToSam
#$ -e /u/scratch/c/ckyriazi/caracals/output/01_FastqToSam


. /u/local/Modules/default/init/modules.sh
module load java/jre-1.8.0_281

Individual=$1
FastqDir=$2
OutDir=$3

java -jar /u/local/apps/picard/2.25.0/picard/build/libs/picard.jar FastqToSam \
FASTQ=${FastqDir}/${Individual}_R1.fastq.gz \
FASTQ2=${FastqDir}/${Individual}_R2.fastq.gz \
OUTPUT=${OutDir}/${Individual}/${Individual}_FastqToSam.bam \
READ_GROUP_NAME=${Individual}_1a \
SAMPLE_NAME=${Individual} \
LIBRARY_NAME=Lib1 \
PLATFORM=illumina \

