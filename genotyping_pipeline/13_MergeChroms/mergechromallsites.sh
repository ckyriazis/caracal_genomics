
## This cats all the chroms for the allsites vcf.
## Script modified from Clare's version for caracals

. /u/local/Modules/default/init/modules.sh
module load java/jre-1.8.0_281

GATK="/u/home/c/ckyriazi/project-klohmuel/software/gatk_37/GenomeAnalysisTK.jar"
REFERENCE=/u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/reference/GCF_000181335.3_Felis_catus_9.0_genomic.fna


indir='/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/11_FilterVCFfile/'
outdir='/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/13_MergeChroms'
prefix='32Caracals_joint_FilterB_Round2_'
suffix='.vcf.gz'

Chrom1=NC_018723.3
Chrom2=NC_018724.3
Chrom3=NC_018725.3
Chrom4=NC_018726.3
Chrom5=NC_018727.3
Chrom6=NC_018728.3
Chrom7=NC_018729.3
Chrom8=NC_018730.3
Chrom9=NC_018731.3
Chrom10=NC_018732.3
Chrom11=NC_018733.3
Chrom12=NC_018734.3
Chrom13=NC_018735.3
Chrom14=NC_018736.3
Chrom15=NC_018737.3
Chrom16=NC_018738.3
Chrom17=NC_018739.3
Chrom18=NC_018740.3

java -cp ${GATK} org.broadinstitute.gatk.tools.CatVariants \
-R ${REFERENCE} \
-V ${indir}/${prefix}${Chrom1}${suffix} \
-V ${indir}/${prefix}${Chrom2}${suffix} \
-V ${indir}/${prefix}${Chrom3}${suffix} \
-V ${indir}/${prefix}${Chrom4}${suffix} \
-V ${indir}/${prefix}${Chrom5}${suffix} \
-V ${indir}/${prefix}${Chrom6}${suffix} \
-V ${indir}/${prefix}${Chrom7}${suffix} \
-V ${indir}/${prefix}${Chrom8}${suffix} \
-V ${indir}/${prefix}${Chrom9}${suffix} \
-V ${indir}/${prefix}${Chrom10}${suffix} \
-V ${indir}/${prefix}${Chrom11}${suffix} \
-V ${indir}/${prefix}${Chrom12}${suffix} \
-V ${indir}/${prefix}${Chrom13}${suffix} \
-V ${indir}/${prefix}${Chrom14}${suffix} \
-V ${indir}/${prefix}${Chrom15}${suffix} \
-V ${indir}/${prefix}${Chrom16}${suffix} \
-V ${indir}/${prefix}${Chrom17}${suffix} \
-V ${indir}/${prefix}${Chrom18}${suffix} \
-out ${outdir}/${prefix}'autosomes.vcf.gz' \
-assumeSorted

