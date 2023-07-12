#!/bin/bash
#$ -l highp,h_rt=220:00:00,h_data=6G
#$ -pe shared 5
#$ -N caracals_GenotypeGVCFs
#$ -cwd
#$ -m abe
#$ -o /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/08_GenotypeGVCFs/
#$ -e /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/08_GenotypeGVCFs/
#$ -M ckyriazi



# This script is for all chromosomes (autosomes, X, MT)

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK="/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar"


REFERENCE=/u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/reference/GCF_000181335.3_Felis_catus_9.0_genomic.fna



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



OutDir=$1

AllIndividuals=(CM04 CM05 CM09 CM12 CM18 CM29 CM32 CM33 CRTB08 CRTB18 CRTB20 CRTB24 MD07 MD08 MD10 MD16 MD17 NCF01 NCF03 NCF11 NCM01 NCM08 TMC06 TMC07 TMC12 TMC16 TMC20 TMC30 C23 MD18 NCF02 TMC02)

java -jar -Xmx16G ${GATK} \
-T GenotypeGVCFs \
-R ${REFERENCE} \
-allSites \
-stand_call_conf 0 \
-L ${Chrom} \
$(for Individual in "${AllIndividuals[@]}"; do echo "-V /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/07_GATKHC/${Individual}/${Individual}_${Chrom}_GATK_HC.g.vcf.gz"; done) \
-o ${OutDir}/32Caracals_joint_${Chrom}.vcf.gz
