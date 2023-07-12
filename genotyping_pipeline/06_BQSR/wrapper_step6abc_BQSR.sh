#!/bin/bash

individuals_array=(MD16)


for i in "${individuals_array[@]}"
do

qsub -N ${i}.step6abc.R1 step6abc_BQSR_1round.sh ${i} /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/05_RemoveBadReads /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/06_BQSR

#sleep 1m

done

