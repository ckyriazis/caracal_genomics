#!/bin/bash
#$ -l highp,h_rt=24:00:00,h_data=8G
#$ -pe shared 1
#$ -N SNPs
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/genotyping_pipeline/14_getSNPsFromVCF/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/genotyping_pipeline/14_getSNPsFromVCF/jobfiles
#$ -M ckyriazi



REFERENCE=/u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/reference/GCF_000181335.3_Felis_catus_9.0_genomic.fna
indir=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/13_MergeChroms
outdir=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/14_getSNPsFromVCF

#exclude .vcf.gz
infile=32Caracals_joint_FilterB_Round2_autosomes

. /u/local/Modules/default/init/modules.sh
module load java/jre-1.8.0_281

GATK="/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar"

java -jar -Xmx4G ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-V ${indir}/${infile}.vcf.gz \
--restrictAllelesTo BIALLELIC \
--selectTypeToInclude SNP \
-o ${outdir}/${infile}_SNPs.vcf.gz
