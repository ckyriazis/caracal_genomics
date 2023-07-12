# need to cat the files then get the average

cd '/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/12_GetCoverage'

#animals=(CM04 CM05 CM09 CM12 CM18 CM29 CM32 CM33 CRTB08 CRTB18 CRTB20 CRTB24 MD07 MD08 MD10 MD16 MD17 NCF01 NCF03 NCF11 NCM01 NCM08 TMC06 TMC07 TMC12 TMC16 TMC20 TMC30 C23 MD18 NCF02 TMC02)

animals=(NCF02 TMC02)

for i in "${animals[@]}"
do
	echo ${i}
	cat ${i}* > 'all_'${i}'_chrom.txt'
done
echo 'second loop'
for i in "${animals[@]}"
do
	echo ${i}
	awk '{sum+=$1} END {print sum/NR}' 'all_'${i}'_chrom.txt'
done
