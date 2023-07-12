#!/bin/bash
#$ -l highp,h_rt=16:00:00,h_data=8G
#$ -pe shared 4
#$ -N subset_ROH
#$ -cwd
#$ -m bea
#$ -o /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/analysis/ROH/bcftools/jobfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/caracal_pipeline/scripts/analysis/ROH/bcftools/jobfiles
#$ -M ckyriazi



## This script is for subsetting bcftools roh output by individual, since the output files are 
## very large (20g for 9 inds)
## The script also compresses the files, as they can be read into R when gzipped

cd /u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/ROH/ 

file=32Caracals_round2_roh_bcftools_G30_noNCM01.out

tail -n +6 ${file} > tmp.txt



awk '$2 == "CRTB08" { print }' tmp.txt > CRTB08_${file}
awk '$2 == "CRTB18" { print }' tmp.txt > CRTB18_${file}
awk '$2 == "CRTB20" { print }' tmp.txt > CRTB20_${file}
awk '$2 == "CRTB24" { print }' tmp.txt > CRTB24_${file}
awk '$2 == "MD07" { print }' tmp.txt > MD07_${file}
awk '$2 == "MD08" { print }' tmp.txt > MD08_${file}
awk '$2 == "MD10" { print }' tmp.txt > MD10_${file}
awk '$2 == "MD16" { print }' tmp.txt > MD16_${file}
awk '$2 == "MD17" { print }' tmp.txt > MD17_${file}
awk '$2 == "MD18" { print }' tmp.txt > MD18_${file}
awk '$2 == "C23" { print }' tmp.txt > C23_${file}
awk '$2 == "CM04" { print }' tmp.txt > CM04_${file}
awk '$2 == "CM05" { print }' tmp.txt > CM05_${file}
awk '$2 == "CM32" { print }' tmp.txt > CM32_${file}
awk '$2 == "TMC02" { print }' tmp.txt > TMC02_${file}
awk '$2 == "TMC06" { print }' tmp.txt > TMC06_${file}
awk '$2 == "TMC07" { print }' tmp.txt > TMC07_${file}
awk '$2 == "TMC12" { print }' tmp.txt > TMC12_${file}
awk '$2 == "TMC16" { print }' tmp.txt > TMC16_${file}
awk '$2 == "CM09" { print }' tmp.txt > CM09_${file}
awk '$2 == "CM12" { print }' tmp.txt > CM12_${file}
awk '$2 == "CM18" { print }' tmp.txt > CM18_${file}
awk '$2 == "CM29" { print }' tmp.txt > CM29_${file}
awk '$2 == "CM33" { print }' tmp.txt > CM33_${file}
awk '$2 == "TMC20" { print }' tmp.txt > TMC20_${file}
awk '$2 == "TMC30" { print }' tmp.txt > TMC30_${file}
awk '$2 == "NCF01" { print }' tmp.txt > NCF01_${file}
awk '$2 == "NCF02" { print }' tmp.txt > NCF02_${file}
awk '$2 == "NCF03" { print }' tmp.txt > NCF03_${file}
awk '$2 == "NCF11" { print }' tmp.txt > NCF11_${file}
#awk '$2 == "NCM01" { print }' tmp.txt > NCM01_${file}
awk '$2 == "NCM08" { print }' tmp.txt > NCM08_${file}




wait

gzip CRT*
gzip MD*
gzip C23*
gzip CM*
gzip TMC*
gzip NCF*
gzip NCM*
gzip ${file}
rm tmp.txt



