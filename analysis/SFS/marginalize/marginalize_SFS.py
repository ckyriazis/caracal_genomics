#!/usr/bin/env python

import dadi


file_exp="/u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/dadi/CP-GCT/2D.ConstantSize.Migration.fixedT/CP-GCT.dadi.inference.2D.ConstantSize.Migration.runNum.8.expSFS"

file_obs="/u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/SFS/projection/projection-hetFilter-0.75/CP-GCT.plusMonomorphic.autosomes.sfs"



exp_sfs=dadi.Spectrum.from_file(file_exp)
obs_sfs=dadi.Spectrum.from_file(file_obs)



#marginalize over GCT pop to get 1D CP SFS
CP_exp_sfs=exp_sfs.marginalize([1])
CP_obs_sfs=obs_sfs.marginalize([1])

print(CP_exp_sfs)
print(CP_obs_sfs)



#marginalize over CP pop to get 1D GCT SFS
GCT_exp_sfs=exp_sfs.marginalize([0])
GCT_obs_sfs=obs_sfs.marginalize([0])


print(GCT_exp_sfs)
print(GCT_obs_sfs)











# write output files
#print(L)

#outfile = open("/u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/SFS/projection/projection-hetFilter-0.75/"+pop+".totalSiteCount.L.withMonomorphic.txt", "w")
#outfile.write(str(pop)+"\t"+str(L))
#outfile.close()

#print(fs)
#fs.to_file("/u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/SFS/projection/projection-hetFilter-0.75/"+pop+".plusMonomorphic.autosomes.sfs")






