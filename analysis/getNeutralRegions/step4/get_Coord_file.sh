#! /bin/bash
#$ -wd /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/analysis/getNeutralRegions/step4
#$ -l h_rt=23:00:00,h_data=4G
#$ -o /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/analysis/getNeutralRegions/step4/jobfiles/getNeutralCoords.out.txt
#$ -e /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/analysis/getNeutralRegions/step4/jobfiles/getNeutralCoords.err.txt
#$ -m abe
#$ -t 2-19

# Gets neutral coordinates to bed file
# Adapted from Annabel Beichman's script (to analyze exomes) by Sergio Nigenda to analyze whole genome data.
# Usage: qsub get_Coord_file.sh Vaquita


########## Setting environment

#source /u/project/rwayne/software/finwhale/miniconda2/etc/profile.d/conda.sh
#conda activate gentools


. /u/local/Modules/default/init/modules.sh
module load python/2.7.15
module load bedtools

set -oe pipefail

########## Set variables, files and directories


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



REF=cat

VCFDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/getNeutralRegions/step3
WORKDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/getNeutralRegions/step4
SCRIPTDIR=/u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/analysis/getNeutralRegions/step4
NeutralCoord_SCRIPT=${SCRIPTDIR}/obtain_noCpG_noRepetitive_coordinates.py


##### make directories were this information will be stored

mkdir -p ${WORKDIR}/repeatRegions
mkdir -p ${WORKDIR}/get_fasta


##### Logging

cd ${WORKDIR}

mkdir -p ./logs
mkdir -p ./temp

echo "[$(date "+%Y-%m-%d %T")] Start creating bed files for ${REF} ${SGE_TASK_ID} JOB_ID: ${JOB_ID}"
echo "The qsub input"
echo "${REF} ${SGE_TASK_ID}"

PROGRESSLOG=./logs/create_beds_${REF}_${Chrom}_progress.log
echo -e "[$(date "+%Y-%m-%d %T")] JOB_ID: ${JOB_ID}" > ${PROGRESSLOG}


########## Creates a bed file for each vcf file

echo -e "[$(date "+%Y-%m-%d %T")]  creating bed files ... " >> ${PROGRESSLOG}
LOG=./logs/Step2_Creating_bed_files_${REF}_${IDX}.log
date "+%Y-%m-%d %T" > ${LOG}

python ${NeutralCoord_SCRIPT} --VCF ${VCFDIR}/no_repeats_SFS_${Chrom}.vcf.gz --outfile ${WORKDIR}/repeatRegions/min10kb_DistFromCDRs_noCpGIsland_noRepeat_${Chrom}.bed

bedtools merge -d 10 -i ${WORKDIR}/repeatRegions/min10kb_DistFromCDRs_noCpGIsland_noRepeat_${Chrom}.bed > ${WORKDIR}/repeatRegions/min10kb_DistFromCDRs_noCpGIsland_noRepeat_mergedMaxDistance10_${Chrom}.bed

cat ${WORKDIR}/repeatRegions/min10kb_DistFromCDRs_noCpGIsland_noRepeat_mergedMaxDistance10_*.bed | sort -k1,1 -k2,2n > ${WORKDIR}/get_fasta/min10kb_DistFromCDRs_noCpGIsland_noRepeat_mergedMaxDistance10_sorted.bed 


exitVal=${?}
if [ ${exitVal} -ne 0 ]; then
    echo -e "[$(date "+%Y-%m-%d %T")] FAIL" >> ${PROGRESSLOG}
    exit 1
fi

date "+%Y-%m-%d %T" >> ${LOG}
echo -e "[$(date "+%Y-%m-%d %T")] Done" >> ${PROGRESSLOG}


#conda deactivate

