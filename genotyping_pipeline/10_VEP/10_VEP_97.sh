#! /bin/bash
#$ -cwd
#$ -l highp,h_rt=48:00:00,h_data=16G
#$ -pe shared 2 
#$ -N caracals_VEP
#$ -o /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/10_VEP
#$ -e /u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/10_VEP
#$ -m abe
#$ -M ckyriazi


# Step 10: Annotate variants with Variant Effect Predictor from Ensembl

# Usage: ./10_VEP.sh [chromosome]


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


#source /u/local/Modules/default/init/modules.sh
#module load perl

source /u/home/c/ckyriazi/miniconda2/etc/profile.d/conda.sh
conda activate vep

VEPDIR=/u/home/c/ckyriazi/project-klohmuel/software/ensembl-vep-97
BGZIP=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/bgzip
TABIX=/u/home/c/ckyriazi/project-klohmuel/software/htslib-1.3.2/tabix

INDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/09_TrimAlternates_VariantAnnotator
OUTDIR=/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/10_VEP

INFILE=${INDIR}/32Caracals_joint_VariantAnnotator_${Chrom}.vcf.gz
OUTFILE=${OUTDIR}/32Caracals_joint_VEP_${Chrom}.vcf.gz

perl ${VEPDIR}/vep \
--dir ${VEPDIR} --cache --vcf --offline --sift b --species felis_catus \
--canonical --allow_non_variant --symbol --force_overwrite \
--dir_cache /u/home/c/ckyriazi/project-klohmuel/software/ensembl-vep-97 \
-i ${INFILE} \
-o STDOUT \
--stats_file ${OUTFILE}_stats.html | \
sed 's/ /_/g' | ${BGZIP} > ${OUTFILE}

$TABIX -p vcf ${OUTFILE}
