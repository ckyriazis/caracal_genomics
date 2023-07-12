#!/bin/bash
#$ -l highp,h_rt=6:00:00,h_data=8G
#$ -N getAnnotations
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/get_annotations/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/genotyping_pipeline/11_FilterVCFfile/get_annotations/jobfiles
#$ -M ckyriazi

. /u/local/Modules/default/init/modules.sh
module load java/1.8.0_77



GATK=/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/reference/GCF_000181335.3_Felis_catus_9.0_genomic.fna
OUTDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/11_FilterVCFfile/annotation_tables
WKDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/10_VEP
VCF=32Caracals_joint_VEP_
CHR=NC_018723.3



cd ${WKDIR}

java -Xmx1g -jar ${GATK} -T SelectVariants -R ${REFERENCE} -V ${VCF}${CHR}.vcf.gz -selectType SNP -o ${OUTDIR}/${VCF}${CHR}_snps.vcf



java -Xmx1g -jar ${GATK} -R ${REFERENCE} -T VariantsToTable -V ${OUTDIR}/${VCF}${CHR}_snps.vcf --allowMissingData -F AN -F BaseQRankSum -F DP -F FS -F MQ -F MQRankSum -F QD -F ReadPosRankSum -F SOR --out ${OUTDIR}/${VCF}${CHR}_SNPs_table.txt

