#! /bin/bash
#$ -cwd
#$ -l h_rt=12:00:00,h_data=12G 
#$ -pe shared 4
#$ -N filtering
#$ -o /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/jobfiles
#$ -m a
#$ -M ckyriazi



# Step 11: Apply mask and hard filters to VCF file


. /u/local/Modules/default/init/modules.sh
module load java/jre-1.8.0_281

GATK=/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar
BGZIP=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/bgzip
TABIX=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/tabix
INDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/10_VEP
OUTDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/11_FilterVCFfile
ROUND=2

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


### A. Apply mask and hard filters with VariantFiltration

MASK=/u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/reference/mask/GCF_000181335.3_Felis_catus_9.0_rm.bed
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/reference/GCF_000181335.3_Felis_catus_9.0_genomic.fna


INFILE=${INDIR}/32Caracals_joint_VEP_${Chrom}.vcf.gz
OUTFILE=${OUTDIR}/32Caracals_joint_FilterA_Round${ROUND}_${Chrom}.vcf.gz

java -jar ${GATK} \
-T VariantFiltration \
-R ${REFERENCE} \
--logging_level ERROR \
--mask ${MASK} --maskName "FAIL_Rep" \
-filter "QUAL < 30.0" --filterName "FAIL_qual" \
-filter "DP >1301 " --filterName "FAIL_DP" \
-L ${Chrom} \
-V ${INFILE} \
-o ${OUTFILE}


### B. Apply custom site- and genotype-level filters

FILTER_SCRIPT=/u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/customVCFfilter_100920.py

INFILE2=${OUTDIR}/32Caracals_joint_FilterA_Round${ROUND}_${Chrom}.vcf.gz
OUTFILE2=${OUTDIR}/32Caracals_joint_FilterB_Round${ROUND}_${Chrom}.vcf.gz

set -o pipefail

python ${FILTER_SCRIPT} ${INFILE2} | ${BGZIP} > ${OUTFILE2}

${TABIX} -p vcf ${OUTFILE2}





