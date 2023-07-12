#!/bin/bash


# Uncomment the line below and fill in the name of the individuals.
individuals_array=(C23 MD18 NCF02 TMC02)

for i in "${individuals_array[@]}"
do

qsub -N ${i}RemoveBadReads step5_RemoveBadReads.sh ${i} /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/04_MarkDups /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/05_RemoveBadReads
sleep 1m

done
