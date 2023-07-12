#!/bin/bash
#$ -l highp,h_rt=24:00:00,h_data=8G
#$ -N bcftools_roh
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/analysis/ROH/bcftools/jobfiles	
#$ -e /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/analysis/ROH/bcftools/jobfiles
#$ -M ckyriazi



# This script is for running bcftools roh given vcf input
# see here https://samtools.github.io/bcftools/bcftools.html#roh and here https://samtools.github.io/bcftools/howtos/roh-calling.html for details

# usage: qsub run_bcftools_roh.sh


. /u/local/Modules/default/init/modules.sh
module load bcftools


indir=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/13_MergeChroms/
infile=32Caracals_joint_FilterB_Round2_autosomes.vcf.gz
outdir=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/ROH/
outfile=32Caracals_round2_roh_bcftools_G30_noNCM01.out

# need -G flag to indicate genotypes rather than genotype likelihoods
# do i also need to add a flag for calculating allele frequencies????

bcftools roh -G30 ${indir}${infile} --include 'FILTER="PASS"' -s ^NCM01 -o ${outdir}${outfile}








