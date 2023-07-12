#! /bin/bash

#$ -wd /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/analysis/getNeutralRegions/step1
#$ -l h_data=10G,h_rt=6:00:00
#$ -o /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/analysis/getNeutralRegions/step1/jobfiles/GetHiQcoords.out.txt
#$ -e /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/analysis/getNeutralRegions/step1/jobfiles/GetHiQcoords.err.txt
#$ -t 1-20
#$ -m abe



# Author: Sergio Nigenda, based on Tanya Phung's scripts for step 10 of her NGS pipeline 
# Generates a bed file with the high quality sites in the VCF files.
# Usage example: qsub GetHiQualCoords_20200602.sh vaquita

# Modified by Chris Kyriazis 
# Changes: no conda environment, set up to work with cow chroms, 


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



########## Setting conda environment 

#source /u/project/rwayne/software/finwhale/miniconda2/etc/profile.d/conda.sh
#conda activate gentools


. /u/local/Modules/default/init/modules.sh
module load python/2.7.15 
module load bedtools

set -o pipefail


######## Setting directories ######

REF=cow
SCRIPTDIR=/u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/analysis/getNeutralRegions/step1
WORKDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/getNeutralRegions/step1
VCFDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/11_FilterVCFfile
HiQualCoords_SCRIPT=${SCRIPTDIR}/obtain_high_qual_coordinates.py # obtain_noCpG_noRepetitive_coordinates.py

mkdir -p ${WORKDIR}


########## Logging

# echo the input 
echo "[$(date "+%Y-%m-%d %T")] Start GetHiQCoords for ${REF} {IDX} Job ID: ${SGE_TASK_ID}"
echo "The qsub input"
echo "${REF} ${SGE_TASK_ID}"

cd ${WORKDIR}
mkdir -p ./logs
mkdir -p ./temp

PROGRESSLOG=./logs/GetHiQualSitesCoords_A_${REF}_${Chrom}_progress.log
echo -e "[$(date "+%Y-%m-%d %T")] JOB_ID: ${SGE_TASK_ID}" > ${PROGRESSLOG}
echo -e "[$(date "+%Y-%m-%d %T")] Selecting high quality coordinates ... " >> ${PROGRESSLOG}

LOG=./logs/01_A_Get_HighQuality_Coords_${REF}_${Chrom}.log
date "+%Y-%m-%d %T" > ${LOG}


########## Step 9A. Selecting high quality coordinates and missing sites. If ${HiQualCoords_SCRIPT} is defined as obtain_high_qual_coordinates.py it selects only high quality data to later build neutral SFS without projection. However, if is defined as obtain_high_qual_coordinates_miss.py then it includes high quality and missing data for SFS projection. 

python ${HiQualCoords_SCRIPT} --VCF ${VCFDIR}/32Caracals_joint_FilterB_Round1_${Chrom}.vcf.gz --outfile HQsitesCoords_${Chrom}.bed
# python ${HiQualCoords_SCRIPT} --VCF ${VCFDIR}/vaquita_20_chr${IDX}_simple_PASS.vcf.gz --outfile vcfsitesCoords_${IDX}.bed

exitVal=${?}
if [ ${exitVal} -ne 0 ]; then
    echo -e "[$(date "+%Y-%m-%d %T")] FAIL" >> ${PROGRESSLOG}
    exit 1
fi

date "+%Y-%m-%d %T" >> ${LOG}
echo -e "[$(date "+%Y-%m-%d %T")] Done" >> ${PROGRESSLOG}


########## Step 9B. Merging High quality coordinates (The previous step is made for each variant, therefore here we merge those coordinates to have less individual regions)

PROGRESSLOG=./logs/GetHiQualSitesCoords_B_${REF}_${Chrom}_progress.log
echo -e "[$(date "+%Y-%m-%d %T")] Merging high quality coordinates ... " >> ${PROGRESSLOG}

LOG=./logs/01_B_Merge_HighQuality_Coords_${REF}_${Chrom}.log
date "+%Y-%m-%d %T" > ${LOG}

bedtools merge -i HQsitesCoords_${Chrom}.bed > HQsitesCoords_merged_${Chrom}.bed


cat HQsitesCoords_merged_*.bed | sort -k1,1 -k2,2n > all_HQCoords_sorted_merged.bed


exitVal=${?}
if [ ${exitVal} -ne 0 ]; then
    echo -e "[$(date "+%Y-%m-%d %T")] FAIL" >> ${PROGRESSLOG}
    exit 1
fi

date "+%Y-%m-%d %T" >> ${LOG}
echo -e "[$(date "+%Y-%m-%d %T")] Done" >> ${PROGRESSLOG}

#conda deactivate
