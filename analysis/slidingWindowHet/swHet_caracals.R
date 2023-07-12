# Script for plotting heterozygosity in sliding windows across the genome
# Uses text files containing the following columns (for example):
# chromo	window_start		sites_total	sites_unmasked	sites_passing	sites_variant	calls_sample1	calls_sample2	calls_sample3	hets_sample1	hets_sample2		hets_sample3


library(plyr)

file <- "SWhet_32Caracals_joint_FilterB_Round2"
window_size=1000000

setwd(paste("~/Documents/UCLA/Caracals/Analysis/slidingWindowHet/Data/", file, sep=""))

# All files have *step.txt naming convention. Get list of files:
winfiles=list.files(pattern="step.txt")

# This is here to reorder the chromosomes and exclude the X
winfiles=winfiles[1:18] #make sure this is excluding X and mt
nchr=length(winfiles)

# Read in chromosome 1
hetdata=read.table(winfiles[1], header=T, sep='\t')

# Add subsequent chromosomes
for (i in 2:nchr){ 
	temp=read.table(winfiles[i], header=T, sep='\t')
	hetdata=rbind(hetdata,temp)
}

# Get chromosome position info needed for plotting later:
# Get the start positions of each chromosome
pos=as.numeric(rownames(unique(data.frame(hetdata $chromo)[1])))

# Add the end position
pos=append(pos,length(hetdata $chromo))

# Get the midpoints to center chromosome labels on x-axis
numpos=NULL
for (i in 1:length(pos)-1){numpos[i]=(pos[i]+pos[i+1])/2}


# Move out of data files folder
setwd("~/Documents/UCLA/Caracals/Analysis/slidingWindowHet/Plots")

# Get the number of samples. Here, the number of columns is 6 + 2*number of samples. Change if necessary.
numsamps=(length(names(hetdata))-6)/2

# Which columns contain the numbers of calls and the numbers of hets?
callcols=seq(7,6+numsamps)
hetcols=seq(7+numsamps,length(names(hetdata)))


# Filter out windows with low number of calls, as these windows often have high variance
total_calls <- rowSums(hetdata[callcols])
hist(total_calls)
thresh <- quantile(total_calls, probs = 0.05) #filter out smallest 5% of tail
abline(v=thresh)
hetdata=subset(hetdata, rowSums(hetdata[callcols])>thresh) 
total_calls <- rowSums(hetdata[callcols])
hist(total_calls)


# Get the sample names
sampnames=gsub("calls_", "", names(hetdata)[callcols])

# Which individuals to plot?
samp1="C23"
samp2="CM04"
samp3="CM05"
samp4="CM32"
samp5="TMC02"
samp6="TMC06"
samp7="TMC07"
samp8="TMC12"
samp9="TMC16"
samp10="CM09"
samp11="CM12"
samp12="CM18"
samp13="CM29"
samp14="CM33"
samp15="TMC20"
samp16="TMC30"
samp17="NCF01"
samp18="NCF02"
samp19="NCF03"
samp20="NCF11"
samp21="NCM08"
samp22="CRTB08"
samp23="CRTB18"
samp24="CRTB20"
samp25="CRTB24"
samp26="MD07"
samp27="MD08"
samp28="MD10"
samp29="MD16"
samp30="MD17"
samp31="MD18"



# Use alternating colors to distinguish chromosomes
#mycols=rep(c("#E69F00"), 18)

library(RColorBrewer)
brewer.pal(4, "Spectral")   

col_all_samps <- c("#D7191C","#D7191C","#D7191C","#D7191C","#D7191C","#D7191C","#D7191C","#D7191C","#D7191C",
                   "#FDAE61","#FDAE61","#FDAE61","#FDAE61","#FDAE61","#FDAE61","#FDAE61",
                   "#2B83BA","#2B83BA","#2B83BA","#2B83BA","#2B83BA",
                   "#ABDDA4" ,"#ABDDA4" ,"#ABDDA4" ,"#ABDDA4" ,"#ABDDA4","#ABDDA4" ,"#ABDDA4" ,"#ABDDA4" ,"#ABDDA4" ,"#ABDDA4")

hetplot=function(sampname, ymax, title, xlab, ylab, size, color){
	# Start an empty plot, change ylim as needed
	plot(0,0, type="n", xlim=c(0,pos[length(pos)]), ylim=c(0,ymax), axes=FALSE, xlab="", ylab=ylab, main=title, cex.lab=size, cex.main=size+0.1)
	
	# Add lines for chromosome data
	aa=which(sampnames==sampname)
	for (i in 1:nchr){
	  temp=hetdata[which(hetdata$chromo==unique(hetdata$chromo)[i]),]
	 
	  x <- as.numeric(rownames(temp))
	  y <- temp[,hetcols[aa]]/temp[,callcols[aa]]
	  
    
	  for(j in 1:length(x)){
	    lines(x=c(x[j],x[j]),c(0,y[j]), col=color, lwd=1.1)
	  }
	  
		#lines(as.numeric(rownames(temp)),temp[,hetcols[aa]]/temp[,callcols[aa]], col=mycols[i], lwd=1.5)
		
	}
	
	#draw line of mean genome-wide heterozygosity
	mean_het=mean(hetdata[,hetcols[aa]]/hetdata[,callcols[aa]], na.rm=T)
	#abline(h=mean_het, col="red", lty=2)
	print(mean_het)

	# Add y-axis
	axis(2, cex.axis=size)
	
	# Add x-axis and labels
	title(xlab=xlab, line=2,cex.lab=size)
	axis(side=1, at=pos, labels=FALSE)
	axis(side=1, at=numpos, tick=FALSE, labels=1:nchr, las=3, cex.axis=size, line=-.2)
	return(na.omit(hetdata[,hetcols[aa]]/hetdata[,callcols[aa]]))
}






# Save as file
setwd("~/Documents/UCLA/Caracals/Analysis/slidingWindowHet/Plots")
pdf(paste(file,"_4samps.pdf",sep=""), width=10, height=2)

# Plot four plots as 1x4
par(mfrow=c(1,4))

# Set figure margins
par(mar=c(3.5,2.5,2,1))

ymax=0.004
size=1.4

het_5 <- hetplot(samp5, ymax, samp5, "Chromosome", "Heterozygosity",size=size, col_all_samps[2])
het_10 <- hetplot(samp10, ymax, samp10, "Chromosome", "Heterozygosity",size=size, col_all_samps[10])
het_17 <- hetplot(samp17, ymax, "CN01", "Chromosome", "Heterozygosity",size=size, col_all_samps[17])
het_31 <- hetplot(samp31, ymax, samp31, "Chromosome", "Heterozygosity",size=size, col_all_samps[31])


# Close figure file
dev.off()




# Save as file
setwd("~/Documents/UCLA/Caracals/Analysis/slidingWindowHet/Plots")
pdf(paste(file,"_all_samps.pdf",sep=""), width=14, height=18)

# Plot four plots as 1x4
par(mfrow=c(8,4))

# Set figure margins
par(mar=c(4,5,4,1))

ymax=0.004

size=1.4

het_1 <- hetplot(samp1, ymax, samp1, "Chromosome", "Heterozygosity", size=size, col_all_samps[1])
het_2 <- hetplot(samp2, ymax, samp2, "Chromosome", "Heterozygosity",size=size, col_all_samps[2])
het_3 <- hetplot(samp3, ymax, samp3, "Chromosome", "Heterozygosity",size=size, col_all_samps[3])
het_4 <- hetplot(samp4, ymax, samp4, "Chromosome", "Heterozygosity",size=size, col_all_samps[4])
het_5 <- hetplot(samp5, ymax, samp5, "Chromosome", "Heterozygosity",size=size, col_all_samps[5])
het_6 <- hetplot(samp6, ymax, samp6, "Chromosome", "Heterozygosity",size=size, col_all_samps[6])
het_7 <- hetplot(samp7, ymax, samp7, "Chromosome", "Heterozygosity",size=size, col_all_samps[7])
het_8 <- hetplot(samp8, ymax, samp8, "Chromosome", "Heterozygosity",size=size, col_all_samps[8])
het_9 <- hetplot(samp9, ymax, samp9, "Chromosome", "Heterozygosity",size=size, col_all_samps[9])
het_10 <- hetplot(samp10, ymax, samp10, "Chromosome", "Heterozygosity",size=size, col_all_samps[10])
het_11 <- hetplot(samp11, ymax, samp11, "Chromosome", "Heterozygosity",size=size, col_all_samps[11])
het_12 <- hetplot(samp12, ymax, samp12, "Chromosome", "Heterozygosity",size=size, col_all_samps[12])
het_13 <- hetplot(samp13, ymax, samp13, "Chromosome", "Heterozygosity",size=size, col_all_samps[13])
het_14 <- hetplot(samp14, ymax, samp14, "Chromosome", "Heterozygosity",size=size, col_all_samps[14])
het_15 <- hetplot(samp15, ymax, samp15, "Chromosome", "Heterozygosity",size=size, col_all_samps[15])
het_16 <- hetplot(samp16, ymax, samp16, "Chromosome", "Heterozygosity",size=size, col_all_samps[16])
het_17 <- hetplot(samp17, ymax, "CN01", "Chromosome", "Heterozygosity",size=size, col_all_samps[17])
het_18 <- hetplot(samp18, ymax, "CN02", "Chromosome", "Heterozygosity",size=size, col_all_samps[18])
het_19 <- hetplot(samp19, ymax, "CN03", "Chromosome", "Heterozygosity",size=size, col_all_samps[19])
het_20 <- hetplot(samp20, ymax, "CN11", "Chromosome", "Heterozygosity",size=size, col_all_samps[20])
het_21 <- hetplot(samp21, ymax, "CN08", "Chromosome", "Heterozygosity",size=size, col_all_samps[21])
het_22 <- hetplot(samp22, ymax, samp22, "Chromosome", "Heterozygosity",size=size, col_all_samps[22])
het_23 <- hetplot(samp23, ymax, samp23, "Chromosome", "Heterozygosity",size=size, col_all_samps[23])
het_24 <- hetplot(samp24, ymax, samp24, "Chromosome", "Heterozygosity",size=size, col_all_samps[24])
het_25 <- hetplot(samp25, ymax, samp25, "Chromosome", "Heterozygosity",size=size, col_all_samps[25])
het_26 <- hetplot(samp26, ymax, samp26, "Chromosome", "Heterozygosity",size=size, col_all_samps[26])
het_27 <- hetplot(samp27, ymax, samp27, "Chromosome", "Heterozygosity",size=size, col_all_samps[27])
het_28 <- hetplot(samp28, ymax, samp28, "Chromosome", "Heterozygosity",size=size, col_all_samps[28])
het_29 <- hetplot(samp29, ymax, samp29, "Chromosome", "Heterozygosity",size=size, col_all_samps[29])
het_30 <- hetplot(samp30, ymax, samp30, "Chromosome", "Heterozygosity",size=size, col_all_samps[30])
het_31 <- hetplot(samp31, ymax, samp31, "Chromosome", "Heterozygosity",size=size, col_all_samps[31])

# Close figure file
dev.off()





### boxplot of hets by pop 
setwd("~/Documents/UCLA/Caracals/Analysis/slidingWindowHet/Plots")
pdf(paste("pop_means_",file,".pdf",sep=""), width=5.5, height=4.5)

cols <- c("#D7191C","#FDAE61","#2B83BA","#ABDDA4")

hets_CP <- c(mean(het_1, na.rm=T),mean(het_2, na.rm=T),mean(het_3, na.rm=T),mean(het_4, na.rm=T),mean(het_5, na.rm=T),mean(het_6, na.rm=T),mean(het_7, na.rm=T),mean(het_8, na.rm=T),mean(het_9, na.rm=T), NA)
hets_GCT <- c(mean(het_10, na.rm=T),mean(het_11, na.rm=T),mean(het_12, na.rm=T),mean(het_13, na.rm=T),mean(het_14, na.rm=T),mean(het_15, na.rm=T),mean(het_16, na.rm=T), NA, NA, NA)
hets_NMQ <- c(mean(het_17, na.rm=T),mean(het_18, na.rm=T), mean(het_19, na.rm=T),mean(het_20, na.rm=T),mean(het_21, na.rm=T),NA, NA, NA,NA, NA)
hets_CK <- c(mean(het_22, na.rm=T), mean(het_23, na.rm=T),mean(het_24, na.rm=T),mean(het_25, na.rm=T),mean(het_26, na.rm=T),mean(het_27, na.rm=T),mean(het_28, na.rm=T), mean(het_29, na.rm=T),mean(het_30, na.rm=T),mean(het_31, na.rm=T))

hets1 <- data.frame(hets_CP,hets_GCT,hets_NMQ,hets_CK)

boxplot(hets1, ylim=c(0.0005,0.0015), names = c("CP", "GCT", "NMQ", "CK"), col = cols, ylab = "Heterozygosity", cex.lab=1.1, cex.axis=1)

stripchart(hets1,add=TRUE, vertical=TRUE, pch=19, cex=0.9) 


dev.off()
           



### scatterplot of het vs froh
setwd("~/Documents/UCLA/Caracals/Analysis/slidingWindowHet/Plots")
pdf("scatterplot_het_froh_1mb.pdf", width=3.5, height=3)
par(mar=c(4,4.5,1,1))


hets2 <- c(hets_CP,hets_GCT,hets_NMQ,hets_CK)

froh_1mb <- c(0.21268637, 0.26309011, 0.24715735, 0.05913005, 0.26837544, 0.09227608, 0.18300973,0.24487127,0.22692220,0.14192748,0.15028760,0.08946150,0.08754848,0.19722783,0.10121521,0.11508885,0.10980489,0.01603729,0.11190208,0.12310501,0.29418467,0.12228847,0.12542709,0.11797408,0.14171229,0.08167555,0.08335232,0.15240863,0.08976828, 0.09642427, 0.07803238)

hets2 = hets2[!is.na(hets2)]
plot(hets2,froh_1mb, col=col_all_samps, pch=19, ylab = expression('F'[ROH]), xlab = 'Heterozygosity', ylim=c(0,0.3), cex.lab=1.1)
cols = c("#D7191C","#FDAE61","#2B83BA","#ABDDA4")
legend("bottomleft", legend=c("Cape Peninsula","Greater Cape Town","Namaqualand","Central Karoo"), fill=cols, cex=0.8, bty = "n")


dev.off()








# Draw plot of means
setwd("~/Documents/UCLA/Caracals/Analysis/slidingWindowHet/Plots")
pdf(paste("mean_",file,".pdf",sep=""), width=8, height=5)
par(mar=c(5,5,2,1))

hets_CP <- c(mean(het_1, na.rm=T),mean(het_2, na.rm=T),mean(het_3, na.rm=T),mean(het_4, na.rm=T),mean(het_5, na.rm=T),mean(het_6, na.rm=T),mean(het_7, na.rm=T),mean(het_8, na.rm=T),mean(het_9, na.rm=T))
hets_GCT <- c(mean(het_10, na.rm=T),mean(het_11, na.rm=T),mean(het_12, na.rm=T),mean(het_13, na.rm=T),mean(het_14, na.rm=T),mean(het_15, na.rm=T),mean(het_16, na.rm=T))
hets_NMQ <- c(mean(het_17, na.rm=T),mean(het_18, na.rm=T), mean(het_19, na.rm=T),mean(het_20, na.rm=T),mean(het_21, na.rm=T))
hets_CK <- c(mean(het_22, na.rm=T), mean(het_23, na.rm=T),mean(het_24, na.rm=T),mean(het_25, na.rm=T),mean(het_26, na.rm=T),mean(het_27, na.rm=T),mean(het_28, na.rm=T), mean(het_29, na.rm=T),mean(het_30, na.rm=T),mean(het_31, na.rm=T))


hets2 <- c(hets_CP,hets_GCT,hets_NMQ,hets_CK)
                  
barplot(hets2,names.arg = c(samp1,samp2,samp3,samp4,samp5,samp6,samp7,samp8,samp9,samp10,samp11,samp12,samp13,samp14,samp15,samp16,"CN01","CN02","CN03","CN011","CN08",samp22,samp23,samp24,samp25,samp26,samp27,samp28,samp29,samp30,samp31),
        ylim = c(0, 0.0015),ylab="",
        col = col_all_samps, las=2)

dev.off()



### relative differences

mean(hets_CP, na.rm=T)
mean(hets_GCT,na.rm=T)
mean(hets_CK,na.rm=T)
mean(hets_NMQ,na.rm=T)
mean(c(hets_GCT,hets_NMQ,hets_CK),na.rm=T)

(mean(hets_CP)-mean(hets_GCT))/mean(hets_GCT)

(mean(hets_CP)-mean(c(hets_GCT,hets_NMQ,hets_CK)))/mean(c(hets_GCT,hets_NMQ,hets_CK))






