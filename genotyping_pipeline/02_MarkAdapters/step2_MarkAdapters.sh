#!/bin/bash
#$ -l highp,h_rt=8:00:00,h_data=8G
#$ -pe shared 3
#$ -N caracals_MarkAdapters
#$ -cwd
#$ -o /u/scratch/c/ckyriazi/caracals/output/02_MarkAdapters/
#$ -e /u/scratch/c/ckyriazi/caracals/output/02_MarkAdapters/
#$ -m bea
#$ -M ckyriazi

. /u/local/Modules/default/init/modules.sh
module load java/jre-1.8.0_281

Individual=$1
BamDir=$2
OutDir=$3

java -jar /u/local/apps/picard/2.25.0/picard/build/libs/picard.jar MarkIlluminaAdapters \
I=${BamDir}/${Individual}/${Individual}_FastqToSam.bam \
O=${OutDir}/${Individual}/${Individual}_MarkAdapters.bam \
M=${OutDir}/${Individual}/${Individual}_MarkAdapters.bam_metrics.txt


