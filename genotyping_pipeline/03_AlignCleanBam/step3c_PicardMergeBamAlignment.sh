#!/bin/bash
#$ -l highp,h_rt=12:00:00,h_data=8G
#$ -pe shared 4
#$ -N PicardMergeBamAlignment
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/03_AlignCleanBam/
#$ -e /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/03_AlignCleanBam/
#$ -M ckyriazi

PICARD=/u/local/apps/picard/2.25.0/picard/build/libs/picard.jar
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/reference/GCF_000181335.3_Felis_catus_9.0_genomic.fna

Individual=$1
AlignedBamDir=$2
UnmappedBamDir=$3
OutDir=$4

. /u/local/Modules/default/init/modules.sh
module load java/jre-1.8.0_281

java -Xmx16G -jar ${PICARD} MergeBamAlignment \
ALIGNED_BAM=${AlignedBamDir}/${Individual}/${Individual}_BwaMem.bam \
UNMAPPED_BAM=${UnmappedBamDir}/${Individual}/${Individual}_FastqToSam.bam \
OUTPUT=${OutDir}/${Individual}/${Individual}_AlignCleanBam.bam \
R=$REFERENCE CREATE_INDEX=true \
ADD_MATE_CIGAR=true CLIP_ADAPTERS=false CLIP_OVERLAPPING_READS=true \
INCLUDE_SECONDARY_ALIGNMENTS=true MAX_INSERTIONS_OR_DELETIONS=-1 \
PRIMARY_ALIGNMENT_STRATEGY=MostDistant ATTRIBUTES_TO_RETAIN=XS \
2>>${OutDir}/${Individual}/${Individual}_Process_MergeBam.txt
