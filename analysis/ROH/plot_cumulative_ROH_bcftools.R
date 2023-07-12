

#### Set working directory, file names, individuals, etc ####

setwd("~/Documents/UCLA/Caracals/Analysis/ROH/Data/32Caracals_round2_noNCM01/")

# set filename excluding individual and ".out.gz"
file <- "_32Caracals_round2_roh_bcftools_G30_noNCM01"

## set array of individuals 

#individuals <- c("C23","CM04","CM05","CM32","TMC02","TMC06","TMC07","TMC12","TMC16","CM09","CM12","CM18","CM29","CM33","TMC20","TMC30","NCF01","NCF02","NCF03","NCF11","NCM01","NCM08","CRTB08","CRTB18","CRTB20","CRTB24","MD07","MD08","MD10","MD16","MD17","MD18")
#no NCM01
individuals <- c("C23","CM04","CM05","CM32","TMC02","TMC06","TMC07","TMC12","TMC16","CM09","CM12","CM18","CM29","CM33","TMC20","TMC30","NCF01","NCF02","NCF03","NCF11","NCM08","CRTB08","CRTB18","CRTB20","CRTB24","MD07","MD08","MD10","MD16","MD17","MD18")
#individuals <- c("C23","CM04")
CP_inds <- c("C23","CM04", "CM05","CM32", "TMC02","TMC06","TMC07",  "TMC12", "TMC16")
CK_inds <- c("CRTB08","CRTB18","CRTB20","CRTB24","MD07","MD08","MD10","MD16","MD17","MD18")
GCT_inds <- c("CM09","CM12","CM18","CM29","CM33","TMC20","TMC30")
NMQ_inds <- c("NCF01","NCF02","NCF03","NCF11","NCM08")




## this is length of assembled autosomes from here: https://www.ncbi.nlm.nih.gov/assembly/GCA_000181335.5#/st
chroms <- c(242100913, 171471747, 143202405, 208212889, 155302638, 149751809, 144528695, 222790142, 161193150, 117648028, 90186660, 96884206, 96521652, 63494689, 64340295, 44648284, 71664243, 85752456)
sum(chroms)
genome_length <- 2329.694901


#roh_data <- data.frame(matrix(nrow=0, ncol=2))
#colnames(roh_data) <- c("individual", "length")

#for(ind in seq_along(individuals)){
#  data <- read.table(paste(individuals[ind],file,".out.gz",sep=""),col.names=c("row_type","sample","chrom","start","end","length","num_markers","qual"), fill=T)
#  roh <- subset(data, length>1000000)
#  tmp <- data.frame(cbind(rep(individuals[ind], times=length(roh$length)), roh$length))
#  colnames(tmp) <- c("individual", "length")
#  roh_data <- rbind(roh_data, tmp)
#}


#write.csv("roh_df.csv", x = roh_data, row.names=F)
roh_data <- read.csv(file = "roh_df.csv", header=T)



### plot cumulative proportion of genome in ROH
setwd("~/Documents/UCLA/Caracals/Analysis/ROH/Plots/")
pdf("cumulative_ROH_plot.pdf", width=3.5, height=3)
par(mar=c(4,4,1,1))


col_all_samps <- c("#D7191C","#D7191C","#D7191C","#D7191C","#D7191C","#D7191C","#D7191C","#D7191C","#D7191C",
                   "#FDAE61","#FDAE61","#FDAE61","#FDAE61","#FDAE61","#FDAE61","#FDAE61",
                   "#2B83BA","#2B83BA","#2B83BA","#2B83BA","#2B83BA",
                   "#ABDDA4" ,"#ABDDA4" ,"#ABDDA4" ,"#ABDDA4" ,"#ABDDA4","#ABDDA4" ,"#ABDDA4" ,"#ABDDA4" ,"#ABDDA4" ,"#ABDDA4")

roh_data_sorted <- roh_data[with(roh_data, order(individual, length)), ]

data_C23 <- roh_data_sorted[which(roh_data_sorted$individual=="C23"),]
plot(data_C23$length/1000000,cumsum(data_C23$length)/(genome_length*1000000), type = 'l', col = col_all_samps[1], lwd=1.5, ylim = c(0,0.3), 
     xlim=c(1,60), xlab = "ROH length (Mb)", ylab ="fraction of genome in ROH")
cols = c("#D7191C","#FDAE61","#2B83BA","#ABDDA4")
legend("bottomright", legend=c("Cape Peninsula","Greater Cape Town","Namaqualand","Central Karoo"), fill=cols, cex=0.8, bty = "n")

for(i in length(individuals):2){
  data_this_ind <- roh_data_sorted[which(roh_data_sorted$individual==individuals[i]),]

  lines(data_this_ind$length/1000000,cumsum(data_this_ind$length)/(genome_length*1000000), col = col_all_samps[i], lwd=1.5)
  
  
}

dev.off()








roh_data_CP <- roh_data[roh_data$individual %in% CP_inds,]


long_ROH_CP <- as.numeric(roh_data_CP$length[which(roh_data_CP$length>10000000)])/1e6
long_ROH <- as.numeric(roh_data$length[which(roh_data$length>10000000)])/1e6

hist(long_ROH_CP)


hist(as.numeric(roh_data_CP$length)/1e6, breaks=100, xlab = "Length (Mb)")
hist(as.numeric(roh_data$length)/1e6, breaks=100, xlab = "Length (Mb)")


# calculate how old ROHs are on average in the CP
# g=100/(2*L) where L is mean length of ROH > 1Mb
avg_roh_length <- mean(as.numeric(roh_data_CP$length)/1e6)
avg_roh_length
avg_roh_age <- 100/(2*1.1*avg_roh_length)
avg_roh_age
avg_roh_age*3



# repeat for long ROH >10Mb
avg_roh_length_10Mb <- min(long_ROH_CP)
avg_roh_length_10Mb
avg_roh_age_10Mb <- 100/(2*1.1*avg_roh_length_10Mb)
avg_roh_age_10Mb
avg_roh_age_10Mb*3





