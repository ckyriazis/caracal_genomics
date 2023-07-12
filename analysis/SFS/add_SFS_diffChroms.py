#!/usr/bin/env python

import dadi


chrom_list=["NC_018723.3","NC_018724.3","NC_018725.3","NC_018726.3","NC_018727.3","NC_018728.3","NC_018729.3",
		 "NC_018730.3","NC_018731.3","NC_018732.3","NC_018733.3","NC_018734.3","NC_018735.3","NC_018736.3","NC_018737.3","NC_018738.3","NC_018739.3",
		"NC_018740.3"]


# set this for each pop and projection #
pop="CK-17"
sfs_file=pop+".plusMonomorphic.sfs"
L_file=pop + ".totalSiteCount.L.withMonomorphic.txt"
path = "/u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/SFS/projection/projection-hetFilter-0.75/" + chrom_list[0] + "/dadi-plusMonomorphic/"

# read in files for first chrom
file0 = path+sfs_file
fs=dadi.Spectrum.from_file(file0)

file1 = open(path+L_file, "r")
line = file1.readlines()[1]
L = int(line.split()[1]) # this should be 1 for 1D and 2 for 2D

# loop over other chroms and add SFS and L together
for chrom in chrom_list[1:]:
    path = "/u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/SFS/projection/projection-hetFilter-0.75/" + chrom + "/dadi-plusMonomorphic/"
    f = path+sfs_file
    fs_chrom=dadi.Spectrum.from_file(f)
    fs += fs_chrom

    f1 = open(path+L_file, "r")
    line = f1.readlines()[1]
    L_chrom = int(line.split()[1]) # this should be 1 for 1D and 2 for 2D
    L += L_chrom



# write output files
#print(L)

outfile = open("/u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/SFS/projection/projection-hetFilter-0.75/"+pop+".totalSiteCount.L.withMonomorphic.txt", "w")
outfile.write(str(pop)+"\t"+str(L))
outfile.close()

#print(fs)
fs.to_file("/u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/SFS/projection/projection-hetFilter-0.75/"+pop+".plusMonomorphic.autosomes.sfs")






