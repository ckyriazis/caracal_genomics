#! /bin/bash
#$ -wd /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/getNeutralRegions/step3
#$ -l h_rt=23:00:00,h_data=20G,h_vmem=30G
#$ -o /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/getNeutralRegions/step3/jobfiles/NoRepeats_sites.out.txt
#$ -e /u/home/c/ckyriazi/project-klohmuel/moose_pipeline/scripts/analysis/getNeutralRegions/step3/jobfiles/NoRepeats_sites.err.txt
#$ -m abe
#$ -t 2-20

# Extract genomic regions that are at least 10 Kb apart from exons and are not within repetitive regions or cpg islands, to new vcf files per chromosome or scaffold
# Adapted from Annabel Beichman's script (for analyzing exomes) by Sergio Nigenda to analyze whole genome data.
# Usage: qsub Extract_noCpG_noRepetitive.sh [reference species]

# Modified by Chris Kyriazis 12-8-20
# main modification was to remove exclusion of CpG islands (at least for now)


########## Setting environement

#source /u/project/rwayne/software/finwhale/miniconda2/etc/profile.d/conda.sh
#conda activate gentools


. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

set -oe pipefail


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


########## Set variables, files and directories

REF=cat

WORKDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/getNeutralRegions/step2
GATK=/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar
EXONS=/u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/reference/gtf/GCF_002263795.1_ARS-UCD1.2_genomic_exons.bed
VCFDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/11_FilterVCFfile
OUTDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/getNeutralRegions/step3
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/reference/GCF_000181335.3_Felis_catus_9.0_genomic.fna
REFDIR=/u/home/c/ckyriazi/project-klohmuel/caracale_pipeline/reference/
#CK: only masking repeats right now, might also consider masking CpG islands
MASK=/u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/reference/mask/GCF_000181335.3_Felis_catus_9.0_rm.bed


TenKb=${WORKDIR}/DistanceFromExons/all_HQCoords_min10kb_DistFromExons.0based.bed

mkdir -p ${WORKDIR}
mkdir -p ${OUTDIR}

##### Logging

#cd ${WORKDIR}/neutralVCFs
cd ${OUTDIR}


mkdir -p ./logs
mkdir -p ./temp

# echo the input
echo "[$(date "+%Y-%m-%d %T")] Start extracting non repetitive regions for ${REF} ${SGE_TASK_ID} JOB_ID: ${JOB_ID}"
echo "The qsub input"
echo "${REF} ${SGE_TASK_ID}"

PROGRESSLOG=./logs/Extract_No_repeats_cpg_${REF}_${Chrom}_progress.log
echo -e "[$(date "+%Y-%m-%d %T")] JOB_ID: ${JOB_ID}" > ${PROGRESSLOG}


########## Obtain vcf files per chromosome or scaffold that do not contain repeat regions and are at least 10 Kb apart from exons

echo -e "[$(date "+%Y-%m-%d %T")]  Extracting neutral regions with GATK SelecVariants... " >> ${PROGRESSLOG}
LOG=./logs/Step1_ExtractNeutralSites_${REF}_SelectVariants_${Chrom}.log
date "+%Y-%m-%d %T" > ${LOG}

java -jar ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
--variant ${VCFDIR}/32Caracals_joint_FilterB_Round1_${Chrom}.vcf.gz \
-XL ${MASK} \
-L ${TenKb} \
-o ${OUTDIR}/no_repeats_SFS_${Chrom}.vcf.gz &>> ${LOG}

exitVal=${?}
if [ ${exitVal} -ne 0 ]; then
    echo -e "[$(date "+%Y-%m-%d %T")] FAIL" >> ${PROGRESSLOG}
    exit 1
fi

date "+%Y-%m-%d %T" >> ${LOG}
echo -e "[$(date "+%Y-%m-%d %T")] Done" >> ${PROGRESSLOG}

echo "[$(date "+%Y-%m-%d %T")] Done extracting non repeats regions for ${REF} ${SGE_TASK_ID} Job ID: ${JOB_ID}"

#conda deactivate

