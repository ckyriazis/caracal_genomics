

### marginal SFSs outputted from marginalize_SFS.py script
CP_exp <- c(0.44097498410895186,0.3263644729590371,0.26239426045357117,0.21872851781751176,0.1863402289256264,0.16125008038341365,0.1413698057215483,0.12545217236716089,0.11273165522968764,0.10303122571483453,0.09793378957001805)
CP_exp_fold <- c(CP_exp[1]+CP_exp[11],CP_exp[2]+CP_exp[10],CP_exp[3]+CP_exp[9],CP_exp[4]+CP_exp[8],CP_exp[5]+CP_exp[7],+CP_exp[6])
CP_obs <- c(384752.7362637336,276616.4615384614,263182.36263736105,250085.34065934073,220233.85714285634,111638.92307692289)


#read in output and get theta
# header: nu1	nu2	m	Nanc_FromTheta_scaled_dip	nu1_scaled_dip	nu2_scaled_dip	migrationFraction	theta	LL	modelFunction	mu	L	maxiter	runNumber	rundate	initialParameters	upper_bound	lower_bound
setwd("~/Documents/UCLA/Caracals/Analysis/dadi/output/CP-GCT/2D.ConstantSize.Migration.fixedT/")
dadi_output <- read.table("CP-GCT.dadi.inference.2D.ConstantSize.Migration.fixedT.runNum.8.output",skip = 1 )
theta <- dadi_output$V8 # may need to change this
CP_exp_fold <- CP_exp_fold*theta

sfs_matrix <- rbind(CP_exp_fold,CP_obs)


#plot 
setwd("~/Documents/UCLA/Caracals/Analysis/dadi/plots")
pdf("CP_marginal_SFS.pdf", width = 11, height = 5)
par(mar = c(4,5,2,2))

barplot(sfs_matrix, beside=T,names.arg = seq(from=1, to=6), ylim = c(0,450000), ylab="number of variants", col = c("#0072B2","#007E73"), xlab="allele count", cex.lab = 2, cex.axis = 1.3, cex.names = 1.3)
legend(legend = c("data","model"), x = "topright", fill=c("#0072B2","#007E73"), cex=1.7)

dev.off()




###### Redo everything for GCT pop ########

### marginal SFSs outputted from marginalize_SFS.py script
GCT_exp <- c(0.632203637041654, 0.4360909825076955, 0.3209521782509242,0.24904815142744013, 0.20153180504007712, 0.1684067055334397, 0.14420768473976017, 0.1258131248370251,0.11143493811312447)
GCT_exp_fold <- c(GCT_exp[1]+GCT_exp[9],GCT_exp[2]+GCT_exp[8],GCT_exp[3]+GCT_exp[7],GCT_exp[4]+GCT_exp[6],GCT_exp[5])
GCT_obs <- c(514453.9242424286, 399175.86363635876, 336497.81818181626,274116.59090909024, 128313.31818181784)


#read in output and get theta
# header: nu1	nu2	m	Nanc_FromTheta_scaled_dip	nu1_scaled_dip	nu2_scaled_dip	migrationFraction	theta	LL	modelFunction	mu	L	maxiter	runNumber	rundate	initialParameters	upper_bound	lower_bound
setwd("~/Documents/UCLA/Caracals/Analysis/dadi/output/GCT-GCT/2D.ConstantSize.Migration.fixedT/")
dadi_output <- read.table("CP-GCT.dadi.inference.2D.ConstantSize.Migration.fixedT.runNum.8.output",skip = 1 )
theta <- dadi_output$V8 # may need to change this
GCT_exp_fold <- GCT_exp_fold*theta

sfs_matrix <- rbind(GCT_exp_fold,GCT_obs)


#plot 
setwd("~/Documents/UCLA/Caracals/Analysis/dadi/plots")
pdf("GCT_marginal_SFS.pdf", width = 11, height = 5)
par(mar = c(4,5,2,2))

barplot(sfs_matrix, beside=T,names.arg = seq(from=1, to=5), ylim = c(0,500000), ylab="number of variants", col = c("#0072B2","#007E73"), xlab="allele count", cex.lab = 2, cex.axis = 1.3, cex.names = 1.3)
legend(legend = c("data","model"), x = "topright", fill=c("#0072B2","#007E73"), cex=1.7)

dev.off()





