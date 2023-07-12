#!/bin/bash

individuals_array=(MD10 MD16 MD17 NCF01 NCF03)

for i in "${individuals_array[@]}"
do

qsub -N ${i}SamToFastq step3a_SamToFastq.sh ${i} /u/scratch/c/ckyriazi/caracals/output/02_MarkAdapters  /u/scratch/c/ckyriazi/caracals/output/03_AlignCleanBam/
sleep 1m

done
