#!/bin/bash
#$ -l highp,h_rt=72:00:00,h_data=8G
#$ -N remove_inds
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/genotyping_pipeline/16_subsetVCF/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/genotyping_pipeline/16_subsetVCF/jobfiles
#$ -M ckyriazi

. /u/local/Modules/default/init/modules.sh
module load bcftools

TABIX=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/tabix

cd /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/13_MergeChroms

#exclude .vcf.gz
VCF=31Caracals_joint_FilterB_Round1_autosomes.vcf.gz

# see here for bcftools view options http://samtools.github.io/bcftools/bcftools.html#common_options

#bcftools view -s ^NCM01 -O z ${VCF}.vcf.gz -o ${VCF}.vcf.gz

#bcftools view -s MN15 -s MN178 -s MN31 -s MN41 -s MN54 -s MN72 -s MN76 -s MN92 -s MN96 -O z ${VCF}.vcf.gz -o ${VCF}_MN.vcf.gz

${TABIX} -p vcf ${VCF}


