# script for plotting PCA modified from Annabel's github page, accessed 8-28-18: https://github.com/ab08028/OtterExomeProject/blob/master/scripts/scripts_20180521/analyses/PCA/20180806/PCA_Step_1_PlotPCA.20180806.R
## code for plotting running and plotting PCA using SNPrelate

#load R packages
library(gdsfmt)
library(SNPRelate)
library(ggplot2)



#open the gds file
setwd("~/Documents/UCLA/Caracals/Analysis/SNPrelate/Data")
genofile <- snpgdsOpen("32Caracals_joint_FilterB_Round2_autosomes_SNPs_PASS.gds")

# 20180802: adding LD snp pruning: (1min); r2 threshold : 0.2; recommended by SNPRelate tutorial
# https://bioconductor.org/packages/devel/bioc/vignettes/SNPRelate/inst/doc/SNPRelateTutorial.html#ld-based-snp-pruning
ld_thres=0.2
snpset <- snpgdsLDpruning(genofile, ld.threshold=ld_thres,autosome.only = F,remove.monosnp=T)
#head(snpset)

# Get all selected snp id
snpset.id <- unlist(snpset)
#head(snpset.id)

#population information
sample.id = read.gdsn(index.gdsn(genofile, "sample.id"))
pop_code = c("CP","CP","CP", "GCT", "GCT", "GCT","GCT","CP","GCT","CK","CK","CK","CK","CK","CK","CK","CK","CK","CK","NMQ","NMQ","NMQ","NMQ","NMQ","NMQ","CP","CP","CP","CP","CP","GCT","GCT")

remove_NCM01 <- c("C23","CM04", "CM05", "CM09", "CM12", "CM18", "CM29", "CM32", "CM33", "CRTB08", "CRTB18", "CRTB20", "CRTB24", "MD07", "MD08", "MD10", "MD16", "MD17", "MD18", "NCF01","NCF02","NCF03","NCF11","NCM08","TMC02","TMC06","TMC07","TMC12","TMC16","TMC20","TMC30")
CP_inds <- c("C23","CM04", "CM05","CM32", "TMC02","TMC06","TMC07",  "TMC12", "TMC16")
CP_GCT <- c("C23","CM04", "CM05", "CM09", "CM12", "CM18", "CM29", "CM32", "CM33","TMC02","TMC06","TMC07","TMC12","TMC16","TMC20","TMC30")


########### Relationship inference Using KING method of moments (all pops together) ########
# this approach might be preferable since it accounts for population structure 
# need to LD prune
# seems to be impacted a fair amount by MAF but not much by missing rate or monosnp
# negative kinship coefficients should be truncated to 0 (see Manichaikul et al 2010)
ibd.robust <- snpgdsIBDKING(genofile,autosome.only = F,remove.monosnp = T,missing.rate = 0.2, maf=0.1,snp.id=snpset.id, sample.id = CP_GCT) 

dat <- snpgdsIBDSelection(ibd.robust)
head(dat)

plot(dat$IBS0, dat$kinship, xlab="Proportion of Zero IBS",
     ylab="Estimated Kinship Coefficient (KING-robust)")

plot(dat$kinship, ylim = c(0,0.5))

# should replace all negative values with 0
dat$kinship[dat$kinship<0] <- 0

# plot kinship pairs
setwd("~/Documents/UCLA/Caracals/Analysis/SNPrelate/Plots")

pdf(paste(genofile,"_kinship_KING.pdf",sep=""),width=10, height=7)

p2 <- ggplot(dat,aes(x=ID1,y=ID2,fill=kinship))+
  geom_tile()

p2

dev.off()




########### IBS ################

ibs <- snpgdsIBS(genofile, num.thread=2, autosome.only = F, sample.id = remove_NCM01)

library(gplots)

#heatmap.2(1-ibs$ibs,Rowv=F,Colv=F,trace ="none", main= "IBS heatmap", cellnote=round(ibs$ibs,3), notecol='black', density.info='none', labRow=sample.id, labCol = remove_NCM01, key=F, cexRow=0.9, cexCol=0.9)

## Hierarchical clustering based on IBS results

hc <- snpgdsHCluster(ibs, sample.id=remove_NCM01)
rv <- snpgdsCutTree(hc)
rv


setwd("/Users/christopherkyriazis/Documents/UCLA/Moose/Analysis/SNPrelate/Plots/")
pdf("IBS_tree_31caracals.pdf", width=8, height=6)

plot(rv$dendrogram, main="", ylab="Individual dissimilarity", col=5, edgePar = list(lwd=2),leaflab = "perpendicular")

dev.off()


snpgdsDrawTree(rv, main = "Hierarchical clustering based on IBS", edgePar=list(col=rgb(0.5,0.5,0.5, 0.75)))
               

#close gds file
snpgdsClose(genofile)


