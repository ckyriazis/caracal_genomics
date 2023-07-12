#!/bin/bash
#$ -l highp,h_rt=12:00:00,h_data=16G
#$ -N getPass
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/genotyping_pipeline/15_getPassSites/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/genotyping_pipeline/15_getPassSites/jobfiles
#$ -M ckyriazi





# script for getting only "PASS" sites from vcf
# just uses grep but could probably also do with GATK etc

BGZIP=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/bgzip
TABIX=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/tabix

indir=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/14_getSNPsFromVCF
infile=32Caracals_joint_FilterB_Round2_autosomes_SNPs
#indir=/u/home/c/ckyriazi/kirk-bigdata/moose/output/genotyping_pipeline/11_FilterVCFfile/round13
#infile=18Moose_joint_FilterB_Round13_NC_037328.1
outdir=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/15_getPassSites


zgrep -e "PASS" -e "#" ${indir}/${infile}.vcf.gz | ${BGZIP} > ${outdir}/${infile}_PASS.vcf.gz

${TABIX} -p vcf ${outdir}/${infile}_PASS.vcf.gz
 
