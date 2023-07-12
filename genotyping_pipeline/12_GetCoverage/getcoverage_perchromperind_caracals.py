import vcf
import sys
## this script writes to file the filered depth (from the genotype fields) for each individuual. i.e. there is one file for each individual/chromosome. I will then cat these per indiv to get sum.
## 
chromo=sys.argv[1]
filename='32Caracals_joint_'+ str(chromo) + '.vcf.gz'
indir='/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/08_GenotypeGVCFs/'
myvcffile=indir+filename
outd='/u/home/c/ckyriazi/kirk-bigdata/caracals/output/genotyping_pipeline/12_GetCoverage/'



ofC23=open(outd + 'C23_' + chromo + '.txt', 'a')
ofNCF02=open(outd + 'NCF02_' + chromo + '.txt', 'a')
ofTMC02=open(outd + 'TMC02_' + chromo + '.txt', 'a')
ofCM04=open(outd + 'CM04_' + chromo + '.txt', 'a')
ofCM05=open(outd + 'CM05_' + chromo + '.txt', 'a')
ofCM09=open(outd + 'CM09_' + chromo + '.txt', 'a')
ofCM12=open(outd + 'CM12_' + chromo + '.txt', 'a')
ofCM18=open(outd + 'CM18_' + chromo + '.txt', 'a')
ofMD18=open(outd + 'MD18_' + chromo + '.txt', 'a')
ofCM29=open(outd + 'CM29_' + chromo + '.txt', 'a')
ofCM32=open(outd + 'CM32_' + chromo + '.txt', 'a')
ofCM33=open(outd + 'CM33_' + chromo + '.txt', 'a')
ofCRTB08=open(outd + 'CRTB08_' + chromo + '.txt', 'a')
ofCRTB18=open(outd + 'CRTB18_' + chromo + '.txt', 'a')
ofCRTB20=open(outd + 'CRTB20_' + chromo + '.txt', 'a')
ofCRTB24=open(outd + 'CRTB24_' + chromo + '.txt', 'a') 
ofMD07=open(outd + 'MD07_' + chromo + '.txt', 'a')
ofMD08=open(outd + 'MD08_' + chromo + '.txt', 'a')
ofMD10=open(outd + 'MD10_' + chromo + '.txt', 'a')
ofMD16=open(outd + 'MD16_' + chromo + '.txt', 'a')
ofMD17=open(outd + 'MD17_' + chromo + '.txt', 'a')
ofNCF01=open(outd + 'NCF01_' + chromo + '.txt', 'a')
ofNCF11=open(outd + 'NCF11_' + chromo + '.txt', 'a')
ofNCM01=open(outd + 'NCM01_' + chromo + '.txt', 'a')
ofNCM08=open(outd + 'NCM08_' + chromo + '.txt', 'a')
ofTMC06=open(outd + 'TMC06_' + chromo + '.txt', 'a')
ofTMC07=open(outd + 'TMC07_' + chromo + '.txt', 'a')
ofTMC12=open(outd + 'TMC12_' + chromo + '.txt', 'a')
ofTMC16=open(outd + 'TMC16_' + chromo + '.txt', 'a')
ofNCF03=open(outd + 'NCF03_' + chromo + '.txt', 'a')
ofTMC20=open(outd + 'TMC20_' + chromo + '.txt', 'a')
ofTMC30=open(outd + 'TMC30_' + chromo + '.txt', 'a')





vcf_reader = vcf.Reader(open(myvcffile, 'r'))

	
for record in vcf_reader:
		# skip the sites that dont have DP - IMHO they all should but GATK is a buggy crap fest
		if 'DP' not in record.FORMAT:
			pass
		else:
			C23_DP=record.genotype('C23')['DP']
			if C23_DP > 0:
				ofC23.write(str(C23_DP) + '\n')

			NCF02_DP=record.genotype('NCF02')['DP']
			if NCF02_DP > 0:
				ofNCF02.write(str(NCF02_DP) + '\n')

			TMC02_DP=record.genotype('TMC02')['DP']
			if TMC02_DP > 0:
				ofTMC02.write(str(TMC02_DP) + '\n')

                        CM04_DP=record.genotype('CM04')['DP']
                        if CM04_DP > 0:
                                ofCM04.write(str(CM04_DP) + '\n')

                        CM05_DP=record.genotype('CM05')['DP']
                        if CM05_DP > 0:
                                ofCM05.write(str(CM05_DP) + '\n')

                        CM09_DP=record.genotype('CM09')['DP']
                        if CM09_DP > 0:
                                ofCM09.write(str(CM09_DP) + '\n')

                        CM12_DP=record.genotype('CM12')['DP']
                        if CM12_DP > 0:
                                ofCM12.write(str(CM12_DP) + '\n')

                        CM18_DP=record.genotype('CM18')['DP']
                        if CM18_DP > 0:
                                ofCM18.write(str(CM18_DP) + '\n')

                        MD18_DP=record.genotype('MD18')['DP']
                        if MD18_DP > 0:
                                ofMD18.write(str(MD18_DP) + '\n')

                        CM29_DP=record.genotype('CM29')['DP']
                        if CM29_DP > 0:
                                ofCM29.write(str(CM29_DP) + '\n')

                        CM32_DP=record.genotype('CM32')['DP']
                        if CM32_DP > 0:
                                ofCM32.write(str(CM32_DP) + '\n')

                        CM33_DP=record.genotype('CM33')['DP']
                        if CM33_DP > 0:
                                ofCM33.write(str(CM33_DP) + '\n')

                        CRTB08_DP=record.genotype('CRTB08')['DP']
                        if CRTB08_DP > 0:
                                ofCRTB08.write(str(CRTB08_DP) + '\n')

                        CRTB18_DP=record.genotype('CRTB18')['DP']
                        if CRTB18_DP > 0:
                                ofCRTB18.write(str(CRTB18_DP) + '\n')

                        CRTB20_DP=record.genotype('CRTB20')['DP']
                        if CRTB20_DP > 0:
                                ofCRTB20.write(str(CRTB20_DP) + '\n')

                        CRTB24_DP=record.genotype('CRTB24')['DP']
                        if CRTB24_DP > 0:
                                ofCRTB24.write(str(CRTB24_DP) + '\n')

                        MD07_DP=record.genotype('MD07')['DP']
                        if MD07_DP > 0:
                                ofMD07.write(str(MD07_DP) + '\n')

                        MD08_DP=record.genotype('MD08')['DP']
                        if MD08_DP > 0:
                                ofMD08.write(str(MD08_DP) + '\n')

                        MD10_DP=record.genotype('MD10')['DP']
                        if MD10_DP > 0:
                                ofMD10.write(str(MD10_DP) + '\n')

                        MD16_DP=record.genotype('MD16')['DP']
                        if MD16_DP > 0:
                                ofMD16.write(str(MD16_DP) + '\n')

                        MD17_DP=record.genotype('MD17')['DP']
                        if MD17_DP > 0:
                                ofMD17.write(str(MD17_DP) + '\n')

 			NCF01_DP=record.genotype('NCF01')['DP']
                        if NCF01_DP > 0:
                                ofNCF01.write(str(NCF01_DP) + '\n')

                        NCF11_DP=record.genotype('NCF11')['DP']
                        if NCF11_DP > 0:
                                ofNCF11.write(str(NCF11_DP) + '\n')

                        NCM01_DP=record.genotype('NCM01')['DP']
                        if NCM01_DP > 0:
                                ofNCM01.write(str(NCM01_DP) + '\n')

                        NCM08_DP=record.genotype('NCM08')['DP']
                        if NCM08_DP > 0:
                                ofNCM08.write(str(NCM08_DP) + '\n')

                        TMC06_DP=record.genotype('TMC06')['DP']
                        if TMC06_DP > 0:
                                ofTMC06.write(str(TMC06_DP) + '\n')

                        TMC07_DP=record.genotype('TMC07')['DP']
                        if TMC07_DP > 0:
                                ofTMC07.write(str(TMC07_DP) + '\n')

                        TMC12_DP=record.genotype('TMC12')['DP']
                        if TMC12_DP > 0:
                                ofTMC12.write(str(TMC12_DP) + '\n')

                        TMC16_DP=record.genotype('TMC16')['DP']
                        if TMC16_DP > 0:
                                ofTMC16.write(str(TMC16_DP) + '\n')

                        NCF03_DP=record.genotype('NCF03')['DP']
                        if NCF03_DP > 0:
                                ofNCF03.write(str(NCF03_DP) + '\n')

                        TMC20_DP=record.genotype('TMC20')['DP']
                        if TMC20_DP > 0:
                                ofTMC20.write(str(TMC20_DP) + '\n')

                        TMC30_DP=record.genotype('TMC30')['DP']
                        if TMC30_DP > 0:
                                ofTMC30.write(str(TMC30_DP) + '\n')

		

ofC23.close()
ofMD18.close()
ofNCF02.close()
ofTMC02.close()
ofCM04.close()
ofCM05.close()
ofCM09.close()
ofCM12.close()
ofCM18.close()
ofCM29.close()
ofCM32.close()
ofCM33.close()
ofCRTB08.close()
ofCRTB18.close()
ofCRTB20.close()
ofCRTB24.close()
ofMD07.close()
ofMD08.close()
ofMD10.close()
ofMD16.close()
ofMD17.close()
ofNCF01.close()
ofNCF03.close()
ofNCF11.close()
ofNCM01.close()
ofNCM08.close()
ofTMC06.close()
ofTMC07.close()
ofTMC12.close()
ofTMC16.close()
ofTMC20.close()
ofTMC30.close()



