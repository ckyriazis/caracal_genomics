#!/bin/bash
#$ -l highp,h_rt=150:00:00,h_data=6G
#$ -pe shared 4
#$ -N caracals_TrimAlternates
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/09_TrimAlternates_VariantAnnotator/
#$ -e /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/09_TrimAlternates_VariantAnnotator/
#$ -M ckyriazi


# Step 9: Trim unused alternate alleles and add VariantType and AlleleBalance annotations
# to INFO column

# Usage: ./09_TrimAlternates_VariantAnnotator.sh [chromosome]

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77

GATK="/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar"
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/reference/GCF_000181335.3_Felis_catus_9.0_genomic.fna
INDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/08_GenotypeGVCFs/
WORKDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/09_TrimAlternates_VariantAnnotator
TEMPDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/09_TrimAlternates_VariantAnnotator


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


LOG=${WORKDIR}/JointCalls_09_A_TrimAlternates_${Chrom}.vcf.gz_log.txt

date > ${LOG}

java -jar -Xmx26g -Djava.io.tmpdir=${TEMPDIR} ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-trimAlternates \
-L ${Chrom} \
-V ${INDIR}/32Caracals_joint_${Chrom}.vcf.gz \
-o ${WORKDIR}/32Caracals_joint_TrimAlternates_${Chrom}.vcf.gz &>> ${LOG}

date >> ${LOG}


LOG=${WORKDIR}/JointCalls_09_B_VariantAnnotator_${Chrom}.vcf.gz_log.txt

date > ${LOG}

java -jar -Xmx26g -Djava.io.tmpdir=${TEMPDIR} ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L ${Chrom} \
-V ${WORKDIR}/32Caracals_joint_TrimAlternates_${Chrom}.vcf.gz \
-o ${WORKDIR}/32Caracals_joint_VariantAnnotator_${Chrom}.vcf.gz &>> ${LOG}

date >> ${LOG}
