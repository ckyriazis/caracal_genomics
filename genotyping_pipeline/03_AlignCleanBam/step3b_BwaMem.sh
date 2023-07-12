#!/bin/bash
#$ -l highp,h_rt=200:00:00,h_data=8G
#$ -pe shared 4
#$ -N caracals_BwaMem
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/03_AlignCleanBam
#$ -e /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/03_AlignCleanBam
#$ -M ckyriazi

. /u/local/Modules/default/init/modules.sh
module load bwa/0.7.17


REFERENCE=/u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/reference/GCF_000181335.3_Felis_catus_9.0_genomic.fna


Individual=$1
inDir=$2
outDir=$3

bwa mem -M -t 3 -p $REFERENCE ${inDir}/${Individual}/${Individual}_CleanBamToFastq.fastq 2>> ${outDir}/${Individual}/${Individual}_Process_BwaMem.txt > ${outDir}/${Individual}/${Individual}_BwaMem.bam
