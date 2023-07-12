#!/bin/bash

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub

# Uncomment the line below and fill in the name of the individuals.

individuals_array=(MD10 MD16 MD17 NCF01 NCF03) 

for i in "${individuals_array[@]}"
do

qsub -N ${i}MarkAdapters step2_MarkAdapters.sh ${i} /u/scratch/c/ckyriazi/caracals/output/01_FastqToSam /u/scratch/c/ckyriazi/caracals/output/02_MarkAdapters
sleep 1m

done
