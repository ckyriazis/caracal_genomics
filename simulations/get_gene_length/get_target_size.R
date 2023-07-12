setwd("~/Documents/UCLA/Caracals/Simulations/get_gene_length")


CDS <- read.table("CDS.txt", header=FALSE, sep = "\t")
head(CDS)

#chroms <- unique(CDS$V1)
#autosomes <- chroms[1:18]
autosomes <- c("A1","A2","A3","B1","B2","B3","B4","C1","C2","D1","D2","D3","D4","E1","E2","E3","F1","F2")

longest_transcripts <- array(dim = c(0,2))


for(a in autosomes){
  this_chrom <-  CDS[which(CDS$V1==a),]
  this_chrom_ordered <- this_chrom[order(this_chrom$V4),]
  this_chrom_ordered_unique <- unique(this_chrom_ordered[,1:5])
  
  longest_trans_this_chrom <- array(dim = c(0,2))
  

  # start by getting the unique transcript starts
  # and picking the longest end for each start
  unique_trans_starts <- unique(this_chrom_ordered_unique$V4)
  longest_trans_this_chrom <- array(dim = c(0,2))
  
  for(trans_start in unique_trans_starts){
    transcripts <- this_chrom_ordered_unique[which(this_chrom_ordered_unique$V4 == trans_start),]
    trans_end <- max(transcripts$V5)
    
    longest_trans_this_chrom <- rbind(longest_trans_this_chrom, c(trans_start,trans_end))
  }
  
  #cat(dim(longest_trans_this_chrom),"\n")

  # next, get unique transcript ends
  # and pick longest start for each end
  unique_trans_ends <- unique(longest_trans_this_chrom[,2])

  for(trans_end in unique_trans_ends){
    transcripts <- longest_trans_this_chrom[which(longest_trans_this_chrom[,2] == trans_end),]
    trans_start <- min(transcripts)
    longest_transcripts <- rbind(longest_transcripts, c(trans_start,trans_end))
    
  }
}


dim(longest_transcripts)


# get length of each transcript
length <- longest_transcripts[,2]-longest_transcripts[,1]
sum(length)

median(length)
mean(length)

hist(length, xlim = c(0,2000), breaks =10000)

# get average 'gene length' assuming 19,748 genes
sum(length)/19748 

# determine percent of total genome covered by CDS
sum(length)/2371524154 


