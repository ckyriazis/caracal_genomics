#!/bin/bash
#$ -l highp,h_rt=24:00:00,h_data=4G
#$ -pe shared 1
#$ -N getCoverage
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/genotyping_pipeline/12_GetCoverage/per_individual/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/genotyping_pipeline/12_GetCoverage/per_individual/jobfiles
#$ -M ckyriazi



. /u/local/Modules/default/init/modules.sh
module load python/2.7.13_shared

if [ $SGE_TASK_ID == 1 ]
then
        Chrom=NC_018723.3
elif [ $SGE_TASK_ID == 2 ]
then
        Chrom=NC_018724.3
elif [ $SGE_TASK_ID == 3 ]
then
        Chrom=NC_018725.3
elif [ $SGE_TASK_ID == 4 ]
then
        Chrom=NC_018726.3
elif [ $SGE_TASK_ID == 5 ]
then
        Chrom=NC_018727.3
elif [ $SGE_TASK_ID == 6 ]
then
        Chrom=NC_018728.3
elif [ $SGE_TASK_ID == 7 ]
then
        Chrom=NC_018729.3
elif [ $SGE_TASK_ID == 8 ]
then
        Chrom=NC_018730.3
elif [ $SGE_TASK_ID == 9 ]
then
        Chrom=NC_018731.3
elif [ $SGE_TASK_ID == 10 ]
then
        Chrom=NC_018732.3
elif [ $SGE_TASK_ID == 11 ]
then
        Chrom=NC_018733.3
elif [ $SGE_TASK_ID == 12 ]
then
        Chrom=NC_018734.3
elif [ $SGE_TASK_ID == 13 ]
then
        Chrom=NC_018735.3
elif [ $SGE_TASK_ID == 14 ]
then
        Chrom=NC_018736.3
elif [ $SGE_TASK_ID == 15 ]
then
        Chrom=NC_018737.3
elif [ $SGE_TASK_ID == 16 ]
then
        Chrom=NC_018738.3
elif [ $SGE_TASK_ID == 17 ]
then
        Chrom=NC_018739.3
elif [ $SGE_TASK_ID == 18 ]
then
        Chrom=NC_018740.3
elif [ $SGE_TASK_ID == 19 ]
then
        Chrom=NC_018741.3
elif [ $SGE_TASK_ID == 20 ]
then
        Chrom=NC_001700.1
fi



python getcoverage_perchromperind_caracals.py ${Chrom}
sleep 20s

