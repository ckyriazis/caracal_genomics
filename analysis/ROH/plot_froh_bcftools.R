## This script is for filtering and plotting bcftools roh output
## Input is (optionally gzipped) .out files from bcftools ROH
## subsetted down to have one file for each individual
## as the total file size can be quite large

# Author: Chris Kyriazis


#### Set working directory, file names, individuals, etc ####

setwd("~/Documents/UCLA/Caracals/Analysis/ROH/Data/32Caracals_round2_noNCM01/")

# set filename excluding individual and ".out.gz"
file <- "_32Caracals_round2_roh_bcftools_G30_noNCM01"

## set array of individuals 

#individuals <- c("C23","CM04","CM05","CM32","TMC02","TMC06","TMC07","TMC12","TMC16","CM09","CM12","CM18","CM29","CM33","TMC20","TMC30","NCF01","NCF02","NCF03","NCF11","NCM01","NCM08","CRTB08","CRTB18","CRTB20","CRTB24","MD07","MD08","MD10","MD16","MD17","MD18")
#no NCM01
individuals <- c("C23","CM04","CM05","CM32","TMC02","TMC06","TMC07","TMC12","TMC16","CM09","CM12","CM18","CM29","CM33","TMC20","TMC30","NCF01","NCF02","NCF03","NCF11","NCM08","CRTB08","CRTB18","CRTB20","CRTB24","MD07","MD08","MD10","MD16","MD17","MD18")

## this is length of assembled autosomes from here: https://www.ncbi.nlm.nih.gov/assembly/GCA_000181335.5#/st
chroms <- c(242100913, 171471747, 143202405, 208212889, 155302638, 149751809, 144528695, 222790142, 161193150, 117648028, 90186660, 96884206, 96521652, 63494689, 64340295, 44648284, 71664243, 85752456)
sum(chroms)
genome_length <- 2329.694901

# min size allowable for ROHs - typically 100kb or 300kb
min_roh_length=100000


#### Define functions ####

## Define function that takes in data frame and divides it into three length classes
classify_roh <- function(roh_dataframe, min_roh_length){
  short_roh <- subset(roh_dataframe,length>min_roh_length & length<1000000) # roh_dataframe[length>100000 & length<1000000]
  med_roh <- subset(roh_dataframe, length>1000000 & length<10000000)
  long_roh <-  subset(roh_dataframe, length>10000000 & length<100000000)
  
  
  print(mean(long_roh$length))
  print(mean(c(med_roh$length, long_roh$length)))
  
  roh_age <- 100/(2*c(med_roh$length, long_roh$length)/1e6)
  print(roh_age)
  print(mean(roh_age))
  hist(roh_age, bins=100)
  abline(v = mean(roh_age))

  #sum each class and divide by 1000000 to convert to Mb
  sum_short_Mb <- sum(short_roh$length)/1000000
  sum_med_Mb <- sum(med_roh$length)/1000000
  sum_long_Mb <- sum(long_roh$length)/1000000
  
  print(paste("This individual has",dim(short_roh)[1],"short ROHs summing to",sum_short_Mb, "Mb",
              dim(med_roh)[1],"medium ROHs summing to",sum_med_Mb,"Mb, and",
              dim(long_roh)[1],"long ROHs summing to",sum_long_Mb, "Mb"))
  
  return(c(sum_short_Mb, sum_med_Mb, sum_long_Mb))
  #roh_matrix_Mb <- roh_matrix/1000000 #convert to Mb
  
}

## Define function to read in output files for each individual and filter out ROHs less than min_roh_length
read_filter_roh <- function(data, min_roh_length){
  output <- read.table(paste(data,".out.gz",sep=""), col.names=c("row_type","sample","chrom","start","end","length","num_markers","qual"), fill=T)
  output1 <- subset(output, row_type == "RG")
  output_class_sums <- classify_roh(output1, min_roh_length=min_roh_length)
  return(output_class_sums)
}



#### Read in data, filter, and classify ROHs ####

## initialize data frame
roh_size_df <- data.frame(matrix(nrow=3, ncol=length(individuals)))
colnames(roh_size_df) <- individuals
froh_1mb <- c()
froh_10mb <- c()

## read in data for each individaul
## note that this can be VERY slow - takes several min per individual
roh_size_df <- read.csv(file = "roh_size_df.csv", header=T)

## read in data for each individaul
## note that this can be VERY slow - takes several min per individual
for(i in 1:length(individuals)){
  #roh_size_df[,i] <- read_filter_roh(paste(individuals[i],file, sep=""), min_roh_length=min_roh_length)
  froh_1mb = c(froh_1mb,sum(roh_size_df[2:3,i])/genome_length) # sum ROHs > 1Mb and divide by genome length to estimate Froh
  froh_10mb = c(froh_10mb,sum(roh_size_df[3,i])/genome_length) # sum ROHs > 1Mb and divide by genome length to estimate Froh
}

#write.csv("roh_size_df.csv", x = roh_size_df, row.names=F)


#### Plot results ####


# stacked barplots of binned ROHs
setwd("~/Documents/UCLA/Caracals/Analysis/ROH/Plots/")
pdf(paste("barplot",file,".pdf",sep=""), width=8, height=4)

par(mar=c(5,5,2,1))

names <- c("C23","CM04","CM05","CM32","TMC02","TMC06","TMC07","TMC12","TMC16","CM09","CM12","CM18","CM29","CM33","TMC20","TMC30","CN01","CN02","CN03","CN11","CN08","CRTB08","CRTB18","CRTB20","CRTB24","MD07","MD08","MD10","MD16","MD17","MD18")

barplot(as.matrix(roh_size_df), names.arg = names, col=c("seashell","seashell3", "seashell4"), ylab="Summed ROH length (Mb)", xlab="", ylim=c(0,1000), las=2)
legend("topright",legend=c(paste(min_roh_length/1000000,"-1 Mb",sep=""), "1-10 Mb", "10-100 Mb"), col=c("red","orange", "yellow"), fill=c("seashell","seashell3", "seashell4"))

dev.off()



### FROH boxplots
setwd("~/Documents/UCLA/Caracals/Analysis/ROH/Plots/")
pdf(paste("boxplot_",file,".pdf",sep=""), width=1.5, height=3)
par(mar=c(2,2,1,0.1))


cols <- c("#D7191C","#FDAE61","#2B83BA","#ABDDA4")

froh_CP <- c(froh_1mb[1:9],NA)
froh_GCT <- c(froh_1mb[10:16],NA,NA,NA)
froh_NMQ <- c(froh_1mb[17:21],NA,NA,NA,NA,NA)
froh_CK <- froh_1mb[22:31]

froh_plot <- data.frame(froh_CP,froh_GCT,froh_NMQ,froh_CK)

boxplot(froh_plot, ylim=c(0,0.3), col = cols, ylab = "", cex.lab=1.2, cex.axis=1.1, names=c("","","",""))
#stripchart(froh_plot,add=TRUE, vertical=TRUE, pch=19, cex=0.9) 


dev.off()


froh_CP <- froh_1mb[1:9]
froh_GCT <- froh_1mb[10:16]
froh_NMQ <- froh_1mb[17:21]
froh_CK <- froh_1mb[22:31]

median(froh_CP)
median(froh_GCT)
median(froh_NMQ)
median(froh_CK)
mean(c(froh_GCT,froh_NMQ,froh_CK))

mean(froh_CP)
mean(froh_GCT)











