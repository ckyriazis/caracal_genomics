### Script for calculating Fst using SNPrelate ###

#load R packages
library(gdsfmt)
library(SNPRelate)


setwd("~/Documents/UCLA/Caracals/Analysis/SNPrelate/Data")
genofile <- snpgdsOpen("32Caracals_joint_FilterB_Round2_autosomes_SNPs_PASS.gds")
sample.id <- read.gdsn(index.gdsn(genofile, "sample.id"))


### calculate for all pops
pop_code <- c("CP","CP","CP", "GCT", "GCT", "GCT","GCT","CP","GCT","CK","CK","CK","CK","CK","CK","CK","CK","CK","CK","NMQ","NMQ","NMQ","NMQ","NMQ","CP","CP","CP","CP","CP","GCT","GCT")
remove_NCM01 <- c("C23","CM04", "CM05", "CM09", "CM12", "CM18", "CM29", "CM32", "CM33", "CRTB08", "CRTB18", "CRTB20", "CRTB24", "MD07", "MD08", "MD10", "MD16", "MD17", "MD18", "NCF01","NCF02","NCF03","NCF11","NCM08","TMC02","TMC06","TMC07","TMC12","TMC16","TMC20","TMC30")
group <- as.factor(pop_code)

v1 <- snpgdsFst(genofile, population=group, method="W&C84", autosome.only = F, sample.id=remove_NCM01) 
v1$Fst 
v1$MeanFst 
summary(v1$FstSNP)



## calculate for CP and GCT
pop_code <- c("CP","CP","CP", "GCT", "GCT", "GCT","GCT","CP","GCT","CP","CP","CP","CP","CP","GCT","GCT")
group <- as.factor(pop_code)
CP_GCT <- c("C23","CM04", "CM05", "CM09", "CM12", "CM18", "CM29", "CM32", "CM33","TMC02","TMC06","TMC07","TMC12","TMC16","TMC20","TMC30")

v2 <- snpgdsFst(genofile, population=group, method="W&C84", autosome.only = F, sample.id=CP_GCT) 
v2$Fst 
v2$MeanFst 
summary(v2$FstSNP)




## calculate for CK and GCT

pop_code <- c("GCT", "GCT", "GCT","GCT","GCT","CK","CK","CK","CK","CK","CK","CK","CK","CK","CK","GCT","GCT")
GCT_CK <- c("CM09", "CM12", "CM18", "CM29", "CM33", "CRTB08", "CRTB18", "CRTB20", "CRTB24", "MD07", "MD08", "MD10", "MD16", "MD17", "MD18","TMC20","TMC30")
group <- as.factor(pop_code)

v3 <- snpgdsFst(genofile, population=group, method="W&C84", autosome.only = F, sample.id=GCT_CK) 
v3$Fst 
v3$MeanFst 
summary(v3$FstSNP)




## calculate for CP and CK
pop_code <- c("CP","CP","CP", "CP","CK","CK","CK","CK","CK","CK","CK","CK","CK","CK","CP","CP","CP","CP","CP")
CP_CK <- c("C23","CM04", "CM05", "CM33", "CRTB08", "CRTB18", "CRTB20", "CRTB24", "MD07", "MD08", "MD10", "MD16", "MD17", "MD18", "TMC02","TMC06","TMC07","TMC12","TMC16")
group <- as.factor(pop_code)

v4 <- snpgdsFst(genofile, population=group, method="W&C84", autosome.only = F, sample.id=CP_CK) 
v4$Fst 
v4$MeanFst 
summary(v4$FstSNP)




## calculate for CP and NMQ
pop_code <- c("CP","CP","CP", "CP","NMQ","NMQ","NMQ","NMQ","NMQ","CP","CP","CP","CP","CP")
CP_NMQ <- c("C23","CM04", "CM05", "CM32", "NCF01","NCF02","NCF03","NCF11","NCM08","TMC02","TMC06","TMC07","TMC12","TMC16")

group <- as.factor(pop_code)

v5 <- snpgdsFst(genofile, population=group, method="W&C84", autosome.only = F, sample.id=CP_NMQ) 
v5$Fst 
v5$MeanFst 
summary(v5$FstSNP)




## calculate for CP and GCT - excluding CM32
pop_code <- c("CP","CP","CP", "GCT", "GCT", "GCT","GCT","GCT","CP","CP","CP","CP","CP","GCT","GCT")
group <- as.factor(pop_code)
CP_GCT_noCM32 <- c("C23","CM04", "CM05", "CM09", "CM12", "CM18", "CM29", "CM33","TMC02","TMC06","TMC07","TMC12","TMC16","TMC20","TMC30")

v3 <- snpgdsFst(genofile, population=group, method="W&C84", autosome.only = F, sample.id=CP_GCT_noCM32) 
v3$Fst 
v3$MeanFst 
summary(v3$FstSNP)



snpgdsClose(genofile)

