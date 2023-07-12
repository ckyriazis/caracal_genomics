#!/bin/bash

#. /u/local/etc/profile.d/sge.sh
#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub

# Uncomment the line below and fill in the name of the individuals.
individuals_array=(MD10 MD16 MD17 NCF01 NCF03) 


for i in "${individuals_array[@]}"
do

qsub -N ${i}FastqToSam step1_FastqToSam.sh ${i} /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/caracal_genomes /u/scratch/c/ckyriazi/caracals/output/01_FastqToSam
sleep 1m

done
