# script for plotting PCA modified from Annabel's github page, accessed 8-28-18: https://github.com/ab08028/OtterExomeProject/blob/master/scripts/scripts_20180521/analyses/PCA/20180806/PCA_Step_1_PlotPCA.20180806.R
## code for plotting running and plotting PCA using SNPrelate

#load R packages
library(gdsfmt)
library(SNPRelate)



#open the gds file
setwd("~/Documents/UCLA/Caracals/Analysis/SNPrelate/Data")
genofile <- snpgdsOpen("32Caracals_joint_FilterB_Round2_autosomes_SNPs_PASS.gds")

# 20180802: adding LD snp pruning: (1min); r2 threshold : 0.2; recommended by SNPRelate tutorial
# https://bioconductor.org/packages/devel/bioc/vignettes/SNPRelate/inst/doc/SNPRelateTutorial.html#ld-based-snp-pruning
ld_thres=0.2
snpset <- snpgdsLDpruning(genofile, ld.threshold=ld_thres,autosome.only = F, remove.monosnp=T)
#head(snpset)

# Get all selected snp id
snpset.id <- unlist(snpset)
head(snpset.id)


#population information
sample.id = read.gdsn(index.gdsn(genofile, "sample.id"))
pop_code = c("CP","CP","CP", "GCT", "GCT", "GCT","GCT","CP","GCT","CK","CK","CK","CK","CK","CK","CK","CK","CK","CK","NMQ","NMQ","NMQ","NMQ","NMQ","CP","CP","CP","CP","CP","GCT","GCT")

# for subsetting - to use, enter in "sample.id"
remove_NCM01 <- c("C23","CM04", "CM05", "CM09", "CM12", "CM18", "CM29", "CM32", "CM33", "CRTB08", "CRTB18", "CRTB20", "CRTB24", "MD07", "MD08", "MD10", "MD16", "MD17", "MD18", "NCF01","NCF02","NCF03","NCF11","NCM08","TMC02","TMC06","TMC07","TMC12","TMC16","TMC20","TMC30")


#pca (fast)
maf=0.05 # make sure MAF>(1/2n) to avoid singletons
pca <- snpgdsPCA(genofile,snp.id=snpset.id,autosome.only = F, maf=maf, missing.rate=0.2, sample.id=remove_NCM01)

#variance proportion (%)
pc.percent <- pca$varprop*100
pc = head(round(pc.percent, 2))
pc

#make a data.frame
tab <- data.frame(sample.id = pca$sample.id,
                  pop = factor(pop_code)[match(pca$sample.id, sample.id)],
                  EV1 = pca$eigenvect[,1],    # the first eigenvector
                  EV2 = pca$eigenvect[,2],    # the second eigenvector
                  EV3 = pca$eigenvect[,3],    # the third eigenvector
                  EV4 = pca$eigenvect[,4],    # the fourth eigenvector
                  stringsAsFactors = FALSE)
head(tab)




## PCA for all samples
setwd("~/Documents/UCLA/Caracals/Analysis/SNPrelate/Plots")
pdf(paste(genofile,"_ld",ld_thres,"_maf",maf,".pdf",sep=""),width=5.5, height=5.5)
par(mar=c(5,5,2,2))

col_all_samps = c("#D7191C","#D7191C","#D7191C","#FDAE61","#FDAE61","#FDAE61","#FDAE61","#D7191C","#FDAE61","#ABDDA4","#ABDDA4","#ABDDA4","#ABDDA4","#ABDDA4","#ABDDA4","#ABDDA4","#ABDDA4","#ABDDA4","#ABDDA4","#2B83BA","#2B83BA","#2B83BA","#2B83BA","#2B83BA","#D7191C","#D7191C","#D7191C","#D7191C","#D7191C","#FDAE61","#FDAE61")
col_all_samps_legend=c("#D7191C","#FDAE61","#2B83BA","#ABDDA4")
                
plot(tab$EV1, tab$EV2, col=col_all_samps, xlab=paste("PC1 (",pc[1],"%)",sep=""), ylab=paste("PC2 (",pc[2],"%)",sep=""), pch=19,cex.axis =1.1, cex.lab=1.5, main="", cex=1.9)
legend("bottomleft", legend=c("Cape Peninsula", "Greater Cape Town", "Namaqualand","Central Karoo"), pch=19,cex=1.3, col=col_all_samps_legend)
#text(tab$EV2~tab$EV1, labels=tab$sample.id)

dev.off()








#plot third EV
plot(tab$EV3, tab$EV4, col=col_all_samps, xlab=paste("PC3 (",pc[3],"%)",sep=""), 
     ylab=paste("PC4 (",pc[4],"%)",sep=""), pch=19,cex=1.5, main="")
legend("bottomleft", legend=c("Cape Peninsula", "Greater Cape Town", "Namaqua","Central Karoo"), pch=19,cex=1.3, col=col_all_samps_legend)
text(tab$EV4~tab$EV3, labels=tab$sample.id)


#close gds file
snpgdsClose(genofile)

