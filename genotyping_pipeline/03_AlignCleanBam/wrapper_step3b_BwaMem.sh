#!/bin/bash


individuals_array=(MD10 MD16 MD17 NCF01 NCF03)

for i in "${individuals_array[@]}"
do

qsub -N ${i}BwaMem step3b_BwaMem.sh ${i} /u/scratch/c/ckyriazi/caracals/output/03_AlignCleanBam /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/03_AlignCleanBam 
sleep 2m

done
