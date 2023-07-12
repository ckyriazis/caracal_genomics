# script to count number of genotypes called and number of heterozygotes per sample
# adapted by Jacqueline Robinson from a script by Zhenxin Fan
# input file is a multisample VCF file that has been filtered
# usage: python ./SlidingWindowHet.py input.vcf.gz 100000 10000 chr01

import sys
import pysam
import os
import gzip


# open input file (gzipped VCF file), make sure the VCF file is indexed (if not, create index)
filename = sys.argv[1]
VCF = gzip.open(filename, 'r')

if not os.path.exists("%s.tbi" % filename):
	pysam.tabix_index(filename, preset="vcf")
parsevcf = pysam.Tabixfile(filename)


# set variables
window_size = int(sys.argv[2])
step_size = int(sys.argv[3])
chromo = sys.argv[4]

#lengths from here https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/181/335/GCF_000181335.3_Felis_catus_9.0/GCF_000181335.3_Felis_catus_9.0_assembly_report.txt
chromo_size={'NC_018723.3':242100913,'NC_018724.3':171471747,'NC_018725.3':143202405,'NC_018726.3':208212889,'NC_018727.3':155302638,'NC_018728.3':149751809,'NC_018729.3':144528695,
             'NC_018730.3':222790142,'NC_018731.3':161193150,'NC_018732.3':117648028,'NC_018733.3':90186660,'NC_018734.3':96884206,'NC_018735.3':96521652,'NC_018736.3':63494689,'NC_018737.3':64340295,'NC_018738.3':44648284,'NC_018739.3':71664243,
	     'NC_018740.3':85752456}




# get list of samples
samples=[]
for line in VCF:
	if line.startswith('##'):
		pass
	else:
		for i in line.split()[9:]: samples.append(i)
		break


# get first and last positions in chromosome
for line in VCF:
	if line[0] != '#':
		start_pos = int(line.strip().split()[1])
		end_pos = chromo_size[chromo]
		break


# create output file
output = open('SWhet_' + filename + '_het_%swin_%sstep.txt' % (window_size, step_size), 'w')
output.write('chromo\twindow_start\tsites_total\tsites_unmasked\tsites_passing\tsites_variant\tcalls_%s\thets_%s\n' % ('\tcalls_'.join(samples), '\thets_'.join(samples)) )


# Fetch a region, ignore sites that fail filters, tally total calls and heterozygotes		
def snp_cal(chromo,window_start,window_end):

	rows = tuple(parsevcf.fetch(region="%s:%s-%s" % (chromo, window_start, window_end), parser=pysam.asTuple()))
	
	sites_total,sites_unmasked,sites_passing,sites_variant=0,0,0,0
	calls=[0]*len(samples)
	hets=[0]*len(samples)

	for line in rows:
		sites_total+=1
		if "CpGRep" in line[6]: continue
		sites_unmasked+=1
		if "FAIL" in line[6]: continue
		if "WARN" in line[6]: continue
		sites_passing+=1
		if line[4]!='.': sites_variant+=1
		for i in range(0,len(samples)):
			GT=line[i+9]
			if GT[:1]!='.': calls[i]+=1
			if GT[:3]=='0/1': hets[i]+=1
			if GT[:3]=='0|1': hets[i]+=1

	output.write('%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' % (chromo,window_start,sites_total,sites_unmasked,sites_passing,sites_variant,'\t'.join(map(str,calls)),'\t'.join(map(str,hets))) )

	
# initialize window start and end coordinates
window_start = start_pos
window_end = start_pos+window_size-1


# calculate stats for window, update window start and end positions, repeat to end of chromosome
while window_end <= end_pos:	
			
	if window_end < end_pos:
		snp_cal(chromo,window_start,window_end)

		window_start = window_start + step_size
		window_end = window_start + window_size - 1

	else:
		snp_cal(chromo,window_start,window_end)
		break	
		
else:
	window_end = end_pos
	snp_cal(chromo,window_start,window_end)


# close files and exit
VCF.close()
output.close()

exit()
