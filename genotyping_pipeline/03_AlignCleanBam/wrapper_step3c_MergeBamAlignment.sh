#!/bin/bash


# Uncomment the line below and fill in the name of the individuals.
individuals_array=(MD17)

for i in "${individuals_array[@]}"
do

qsub -N ${i}MergeBamAlignment step3c_PicardMergeBamAlignment.sh ${i} /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/03_AlignCleanBam /u/scratch/c/ckyriazi/caracals/output/01_FastqToSam /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/03_AlignCleanBam
sleep 1m

done
