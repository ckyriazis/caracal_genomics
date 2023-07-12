 

### this function takes in a directory with simulation output files
### reads in the data and creates/saves a plot

read_plot_data <- function(directory){
  
  setwd(paste("~/Documents/UCLA/Caracals/Simulations/data/", directory, sep=""))
  datafiles <- list.files(pattern="3.o")

  ## read in data
  data_frame <- data.frame(matrix(nrow = 0, ncol = 21))
  
  for(rep in seq_along(datafiles)){
    tmp <- read.table(datafiles[rep], sep=",", header=T, skip = 19819)
    data_frame <- rbind(data_frame,cbind(tmp,rep))
  }
  

  ## get mean of all reps
  gens <- unique(data_frame$gen)
  means <- data.frame(matrix(nrow = 0, ncol = 22))
  
  for(gen in gens){
    data_this_gen <- data_frame[which(data_frame$gen==gen),]
    means <- rbind(means,colMeans(data_this_gen))
    
  }
  colnames(means) <- colnames(data_frame)
  
  
  ## set plot settings
  setwd("~/Documents/UCLA/Caracals/Simulations/plots/")
  pdf(paste("plot_",directory,".pdf"), height=10, width=5)
  par(mfrow=c(5,1),mar = c(4,5,1.5,1), bty = "n")
  library(RColorBrewer)
  colors = brewer.pal(n = 6, name = "Blues")[2:6]
  
  xmin <- 5001
  xmax <- 5131
  lab=1.6
  axis=1.2
  lwd=3
  
  data_frame <- data_frame[which(data_frame$gen >= xmin & data_frame$gen <= xmax),]
  means <- means[which(means$gen >= xmin & means$gen <= xmax),]
  
  start_year <- 1940
  end_year <- 2070
  
  ## plot pop size
  plot(means$gen, means$popSize, xlim=c(xmin,xmax), ylim=c(0,65), type = 'l',xaxt="n", ylab = "Population size", xlab = 'Year', col = 'black', lwd=lwd, cex.axis=axis, cex.lab=lab)
  axis(1, at=seq(xmin,xmax, by=10), labels=c(seq(start_year, end_year, by = 10)), cex.axis=axis)
  
  popsize_start <- c()
  popsize_2020 <- c()
  popsize_end <- c()
  for(file in seq_along(datafiles)){
    data <- data_frame[which(data_frame$rep==file),]
    lines(data$gen,data$popSize, col=colors[1])
    popsize_start <- c(popsize_start, data$popSize[which(data$gen==xmin)])
    popsize_2020 <- c(popsize_2020, data$popSize[which(data$gen==xmin+80)])
    popsize_end <- c(popsize_end, data$popSize[which(data$gen==xmax)])
    # add 0 if pop went extinct before end of sim
    if(length(data$popSize[which(data$gen==xmax)])==0){
      popsize_end <- c(popsize_end,0)
    }
  }
  lines(means$gen, means$popSize, col = 'black', lwd=lwd)

  ## plot FROH
  plot(means$gen, means$FROH_1Mb, xlim=c(xmin,xmax), type = 'l',xaxt="n", ylab = expression('F'[ROH]), xlab = 'Year',ylim=c(0,0.6), col = 'black', lwd=lwd, cex.axis=axis, cex.lab=lab)
  axis(1, at=seq(xmin,xmax, by=10), labels=c(seq(start_year, end_year, by = 10)), cex.axis=axis)
  
  froh_start <- c()
  froh_2020 <- c()
  froh_end <- c()
  for(file in seq_along(datafiles)){
    data <- data_frame[which(data_frame$rep==file),]
    lines(data$gen,data$FROH_1Mb, col=colors[2])
    froh_start <- c(froh_start, data$FROH_1Mb[which(data$gen==xmin)])
    froh_2020 <- c(froh_2020, data$FROH_1Mb[which(data$gen==xmin+80)])
    froh_end <- c(froh_end, data$FROH_1Mb[which(data$gen==xmax)])
    # add NA if pop went extinct before end of sim
    if(length(data$FROH_1Mb[which(data$gen==xmax)])==0){
      froh_end <- c(froh_end,NA)
    }
  }
  lines(means$gen, means$FROH_1Mb, col = 'black', lwd=lwd)
  points(x = 5075, y=0.1997243, pch=19, cex=1.5)
  #abline(h =0.21, lty=2)
  
  ## plot FST
  plot(means$gen, means$fst_GCT, type = "l", xlim=c(xmin,xmax),xaxt="n",ylab = expression('F'[ST]), xlab = 'Year', ylim = c(0,0.25), col = 'black', lwd=lwd, cex.axis=axis, cex.lab=lab)
  axis(1, at=seq(xmin,xmax, by=10), labels=c(seq(start_year, end_year, by = 10)), cex.axis=axis)
  
  fst_start <- c()
  fst_2020 <- c()
  fst_end <- c()
  for(file in seq_along(datafiles)){
    data <- data_frame[which(data_frame$rep==file),]
    lines(data$gen,data$fst_GCT, col=colors[3])
    fst_start <- c(fst_start, data$fst_GCT[which(data$gen==xmin)])
    fst_2020 <- c(fst_2020, data$fst_GCT[which(data$gen==xmin+80)])
    fst_end <- c(fst_end, data$fst_GCT[which(data$gen==xmax)])
    # add NA if pop went extinct before end of sim
    if(length(data$fst_GCT[which(data$gen==xmax)])==0){
      fst_end <- c(fst_end,NA)
    }
  }
  lines(means$gen, means$fst_GCT, col = 'black', lwd=lwd)
  points(x = 5075, y=0.053, pch=19, cex=1.5)
  #abline(h =0.053, lty=2)
  print(means$fst_CK[which(means$gen==5075)])
  
  ## plot genetic load
  plot(means$gen, 1-means$meanFitness, xlim=c(xmin,xmax), type= 'l', ylim = c(0,0.25),xaxt="n", ylab = "Genetic load", xlab = 'Year', col = 'black', lwd=lwd, cex.axis=axis, cex.lab=lab)
  axis(1, at=seq(xmin,xmax, by=10), labels=c(seq(start_year, end_year, by = 10)), cex.axis=axis)
  
  genLoad_start <- c()
  genLoad_2020 <- c()
  genLoad_end <- c()
  for(file in seq_along(datafiles)){
    data <- data_frame[which(data_frame$rep==file),]
    lines(data$gen,1-data$meanFitness, col=colors[4])
    genLoad_start <- c(genLoad_start, 1-data$meanFitness[which(data$gen==xmin)])
    genLoad_2020 <- c(genLoad_2020, 1-data$meanFitness[which(data$gen==xmin+80)])
    genLoad_end <- c(genLoad_end, 1-data$meanFitness[which(data$gen==xmax)])
    # add NA if pop went extinct before end of sim
    if(length(data$meanFitness[which(data$gen==xmax)])==0){
      genLoad_end <- c(genLoad_end,NA)
    }
  }
  lines(means$gen, 1-means$meanFitness, col = 'black', lwd=lwd)
  

  ## plot inbreeding load
  plot(means$gen, means$B_year, type = "l", xlim=c(xmin,xmax),xaxt="n",ylab = "Inbreeding load", xlab = 'Year', ylim = c(0,3), col = 'black', lwd=lwd, cex.axis=axis, cex.lab=lab)
  axis(1, at=seq(xmin,xmax, by=10), labels=c(seq(start_year, end_year, by = 10)), cex.axis=axis)
  
  inbLoad_start <- c()
  inbLoad_2020 <- c()
  inbLoad_end <- c()
  for(file in seq_along(datafiles)){
    data <- data_frame[which(data_frame$rep==file),]
    lines(data$gen,data$B_year, col=colors[5])
    inbLoad_start <- c(inbLoad_start,data$B_year[which(data$gen==xmin)])
    inbLoad_2020 <- c(inbLoad_2020,data$B_year[which(data$gen==xmin+80)])
    inbLoad_end <- c(inbLoad_end,data$B_year[which(data$gen==xmax)])
    # add NA if pop went extinct before end of sim
    if(length(data$B_year[which(data$gen==xmax)])==0){
      inbLoad_end <- c(inbLoad_end,NA)
    }
  }
  lines(means$gen, means$B_year, col = 'black', lwd=lwd)
  

  dev.off()

  output_df <- data.frame(cbind(popsize_start,popsize_2020,popsize_end,froh_start,froh_2020,froh_end,fst_start,fst_2020,fst_end,genLoad_start,genLoad_2020,genLoad_end,inbLoad_start,inbLoad_2020,inbLoad_end))
  return(output_df)

}



### make plots

# vary migration rate
data_mig0.5 <- read_plot_data("caracals_K76000_mig0.5_041323")
length(data_mig0.5$popsize_end[data_mig0.5$popsize_end<40])/length(data_mig0.5$popsize_end)
mean(data_mig0.5$popsize_end)

data_mig2.0 <- read_plot_data("caracals_K76000_mig2.0_041323")
length(data_mig2.0$popsize_end[data_mig2.0$popsize_end<2])/length(data_mig2.0$popsize_end)
mean(data_mig2.0$popsize_end)

data_mig0.0 <- read_plot_data("caracals_K76000_mig0.0_041323")
length(data_mig0.0$popsize_end[data_mig0.0$popsize_end<2])/length(data_mig0.0$popsize_end)
mean(data_mig0.0$popsize_end)

# genetic rescue scenario
data_mig0.5_rescue <- read_plot_data("caracals_K76000_mig0.5_rescue_041323")
length(data_mig0.5_rescue$popsize_end)
length(data_mig0.5_rescue$popsize_end[data_mig0.5_rescue$popsize_end<2])/length(data_mig0.5_rescue$popsize_end)
mean(data_mig0.5_rescue$popsize_end)

data_mig0.5_rescueCK <- read_plot_data("caracals_K76000_mig0.5_rescueCK_041323")
length(data_mig0.5_rescueCK$popsize_end)
length(data_mig0.5_rescueCK$popsize_end[data_mig0.5_rescueCK$popsize_end<2])/length(data_mig0.5_rescueCK$popsize_end)
mean(data_mig0.5_rescueCK$popsize_end)

# vary p_death
data_mig0.5_pdeath0.1 <- read_plot_data("caracals_K76000_mig0.5_pmort0.1_041323")
length(data_mig0.5_pdeath0.1$popsize_end)
length(data_mig0.5_pdeath0.1$popsize_end[data_mig0.5_pdeath0.1$popsize_end<2])/length(data_mig0.5_pdeath0.1$popsize_end)
mean(data_mig0.5_pdeath0.1$popsize_end)

data_mig0.5_pdeath0.2 <- read_plot_data("caracals_K76000_mig0.5_pmort0.2_041323")
length(data_mig0.5_pdeath0.2$popsize_end)
length(data_mig0.5_pdeath0.2$popsize_end[data_mig0.5_pdeath0.2$popsize_end<2])/length(data_mig0.5_pdeath0.2$popsize_end)
mean(data_mig0.5_pdeath0.2$popsize_end)



# vary gene length
data_gene2100 <- read_plot_data("caracals_K76000_mig0.5_gene2100_041323")
length(data_gene2100$popsize_end)
length(data_gene2100$popsize_end[data_gene2100$popsize_end<2])/length(data_gene2100$popsize_end)
mean(data_gene2100$popsize_end)

data_gene1250<- read_plot_data("caracals_K76000_mig0.5_gene1250_041323")
length(data_gene1250$popsize_end)
length(data_gene1250$popsize_end[data_gene1250$popsize_end<2])/length(data_gene1250$popsize_end)
mean(data_gene1250$popsize_end)

# vary dominance
data_mig0.5_dominance <- read_plot_data("caracals_K76000_mig0.5_dominance_041323")
length(data_mig0.5_dominance$popsize_end)
length(data_mig0.5_dominance$popsize_end[data_mig0.5_dominance$popsize_end<2])/length(data_mig0.5_dominance$popsize_end)
mean(data_mig0.5_dominance$popsize_end)


# reduced ancestral pop size
data_small_NA <- read_plot_data("caracals_K7600_mig0.5_041323")
length(data_small_NA$popsize_end[data_small_NA$popsize_end<2])/length(data_small_NA$popsize_end)
mean(data_small_NA$popsize_end)




### boxplots of stats at end - migration and pmort parameters
setwd("~/Documents/UCLA/Caracals/Simulations/plots/")
pdf("end_of_sim_boxplots_migration.pdf", height=10, width=9)

library(RColorBrewer)
colors = brewer.pal(n = 6, name = "Blues")[2:6]

lab=1.6
axis=1.2

mar1=c(3,4.5,1,1)
mar2=c(3,0,1,1)


### plot population size 
# migration rate scenarios
par(bty="n",  mfrow=c(5,3), mar=mar1)
data_popsize_mig <- cbind(data_mig0.0$popsize_end, data_mig0.5$popsize_end, data_mig2.0$popsize_end)
boxplot(data_popsize_mig, col =colors[1], names = c("0.0mig", "0.5mig*", "2.0mig"), ylab = "Population size", ylim = c(0,65), main="vary migration rate", cex.lab=lab, cex.axis=axis, cex.names=lab, cex.main=1.5)
data_popsize_mig_start <- data.frame(mean(data_mig0.0$popsize_start), mean(data_mig0.5$popsize_start), mean(data_mig2.0$popsize_start))
stripchart(data_popsize_mig_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# rescue scenarios
par(mar=mar2)
data_popsize_rescue <- cbind(data_mig0.5$popsize_end,data_mig0.5_rescue$popsize_end, data_mig0.5_rescueCK$popsize_end)                                                                
boxplot(data_popsize_rescue, col =colors[1], yaxt = "n", names = c("no rescue*", "rescue", "rescue_div"),ylim = c(0,65), main="genetic rescue", cex.lab=lab, cex.axis=axis, cex.names=lab, cex.main=1.5)
data_popsize_rescue_start <- data.frame(mean(data_mig0.5$popsize_start), mean(data_mig0.5_rescue$popsize_start), mean(data_mig0.5_rescueCK$popsize_start))
stripchart(data_popsize_rescue_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# pmort scenarios
par(mar=mar2)
data_popsize_pmort <- cbind(data_mig0.5_pdeath0.1$popsize_end, data_mig0.5$popsize_end, data_mig0.5_pdeath0.2$popsize_end)                                                                   
boxplot(data_popsize_pmort, col =colors[1],names = c("pmort0.1", "pmort0.15*", "pmort0.2"), ylim = c(0,65), main="vary mortality rate", cex.lab=lab, cex.axis=axis, cex.names=lab,yaxt = "n", cex.main=1.5)
data_popsize_pmort_start <- data.frame(mean(data_mig0.5_pdeath0.1$popsize_start), mean(data_mig0.5$popsize_start), mean(data_mig0.5_pdeath0.2$popsize_start))
stripchart(data_popsize_pmort_start,add=TRUE, vertical=TRUE, pch=4, cex=2)



### plot Froh 
# migration rate scenarios
par(bty="n", mar=mar1)
data_froh_mig <- cbind(data_mig0.0$froh_end, data_mig0.5$froh_end, data_mig2.0$froh_end)
boxplot(data_froh_mig, col =colors[2], names = c("0.0mig", "0.5mig*", "2.0mig"), ylab = expression('F'[ROH]), ylim = c(0,0.6), cex.lab=lab, cex.axis=axis, cex.names=lab)
data_froh_mig_start <- data.frame(mean(data_mig0.0$froh_start), mean(data_mig0.5$froh_start), mean(data_mig2.0$froh_start))
stripchart(data_froh_mig_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# rescue scenarios
par(mar=mar2)
data_froh_rescue <- cbind(data_mig0.5$froh_end,data_mig0.5_rescue$froh_end, data_mig0.5_rescueCK$froh_end)                                                                
boxplot(data_froh_rescue, col =colors[2], yaxt = "n", names = c("no rescue*", "rescue", "rescue_div"),ylim = c(0,0.6), cex.lab=lab, cex.axis=axis, cex.names=lab)
data_froh_rescue_start <- data.frame(mean(data_mig0.5$froh_start), mean(data_mig0.5_rescue$froh_start), mean(data_mig0.5_rescueCK$froh_start))
stripchart(data_froh_rescue_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# pmort scenarios
par(mar=mar2)
data_froh_pmort <- cbind(data_mig0.5_pdeath0.1$froh_end, data_mig0.5$froh_end, data_mig0.5_pdeath0.2$froh_end)                                                                   
boxplot(data_froh_pmort, col =colors[2],names = c("pmort0.1", "pmort0.15*", "pmort0.2"), ylim = c(0,0.6), cex.lab=lab, cex.axis=axis, cex.names=lab,yaxt = "n")
data_froh_pmort_start <- data.frame(mean(data_mig0.5_pdeath0.1$froh_start), mean(data_mig0.5$froh_start), mean(data_mig0.5_pdeath0.2$froh_start))
stripchart(data_froh_pmort_start,add=TRUE, vertical=TRUE, pch=4, cex=2)



### plot Fst
# migration rate scenarios
par(bty="n", mar=mar1)
data_fst_mig <- cbind(data_mig0.0$fst_end, data_mig0.5$fst_end, data_mig2.0$fst_end)
boxplot(data_fst_mig, col =colors[3], names = c("0.0mig", "0.5mig*", "2.0mig"), ylab = expression('F'[ST]), ylim = c(0,0.25), cex.lab=lab, cex.axis=axis, cex.names=lab)
data_fst_mig_start <- data.frame(mean(data_mig0.0$fst_start), mean(data_mig0.5$fst_start), mean(data_mig2.0$fst_start))
stripchart(data_fst_mig_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# rescue scenarios
par(mar=mar2)
data_fst_rescue <- cbind(data_mig0.5$fst_end,data_mig0.5_rescue$fst_end, data_mig0.5_rescueCK$fst_end)                                                                
boxplot(data_fst_rescue, col =colors[3], yaxt = "n", names = c("no rescue*", "rescue", "rescue_div"),ylim = c(0,0.25), cex.lab=lab, cex.axis=axis, cex.names=lab)
data_fst_rescue_start <- data.frame(mean(data_mig0.5$fst_start), mean(data_mig0.5_rescue$fst_start), mean(data_mig0.5_rescueCK$fst_start))
stripchart(data_fst_rescue_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# pmort scenarios
par(mar=mar2)
data_fst_pmort <- cbind(data_mig0.5_pdeath0.1$fst_end, data_mig0.5$fst_end, data_mig0.5_pdeath0.2$fst_end)                                                                   
boxplot(data_fst_pmort, col =colors[3],names = c("pmort0.1", "pmort0.15*", "pmort0.2"), ylim = c(0,0.25), cex.lab=lab, cex.axis=axis, cex.names=lab,yaxt = "n")
data_fst_pmort_start <- data.frame(mean(data_mig0.5_pdeath0.1$fst_start), mean(data_mig0.5$fst_start), mean(data_mig0.5_pdeath0.2$fst_start))
stripchart(data_fst_pmort_start,add=TRUE, vertical=TRUE, pch=4, cex=2)




### plot genetic load
# migration rate scenarios
par(bty="n", mar=mar1)
data_genLoad_mig <- cbind(data_mig0.0$genLoad_end, data_mig0.5$genLoad_end, data_mig2.0$genLoad_end)
boxplot(data_genLoad_mig, col =colors[4], names = c("0.0mig", "0.5mig*", "2.0mig"), ylab = "Genetic load", ylim = c(0,0.25), cex.lab=lab, cex.axis=axis, cex.names=lab)
data_genLoad_mig_start <- data.frame(mean(data_mig0.0$genLoad_start), mean(data_mig0.5$genLoad_start), mean(data_mig2.0$genLoad_start))
stripchart(data_genLoad_mig_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# rescue scenarios
par(mar=mar2)
data_genLoad_rescue <- cbind(data_mig0.5$genLoad_end,data_mig0.5_rescue$genLoad_end, data_mig0.5_rescueCK$genLoad_end)                                                                
boxplot(data_genLoad_rescue, col =colors[4], yaxt = "n", names = c("no rescue*", "rescue", "rescue_div"),ylim = c(0,0.25), cex.lab=lab, cex.axis=axis, cex.names=lab)
data_genLoad_rescue_start <- data.frame(mean(data_mig0.5$genLoad_start), mean(data_mig0.5_rescue$genLoad_start), mean(data_mig0.5_rescueCK$genLoad_start))
stripchart(data_genLoad_rescue_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# pmort scenarios
par(mar=mar2)
data_genLoad_pmort <- cbind(data_mig0.5_pdeath0.1$genLoad_end, data_mig0.5$genLoad_end, data_mig0.5_pdeath0.2$genLoad_end)                                                                   
boxplot(data_genLoad_pmort, col =colors[4],names = c("pmort0.1", "pmort0.15*", "pmort0.2"), ylim = c(0,0.25), cex.lab=lab, cex.axis=axis, cex.names=lab,yaxt = "n")
data_genLoad_pmort_start <- data.frame(mean(data_mig0.5_pdeath0.1$genLoad_start), mean(data_mig0.5$genLoad_start), mean(data_mig0.5_pdeath0.2$genLoad_start))
stripchart(data_genLoad_pmort_start,add=TRUE, vertical=TRUE, pch=4, cex=2)




### plot inbreeding load 
# migration rate scenarios
par(bty="n", mar=mar1)
data_inbLoad_mig <- cbind(data_mig0.0$inbLoad_end, data_mig0.5$inbLoad_end, data_mig2.0$inbLoad_end)
boxplot(data_inbLoad_mig, col =colors[5], names = c("0.0mig", "0.5mig*", "2.0mig"), ylab = "Inbreeding load", ylim = c(0,3), cex.lab=lab, cex.axis=axis, cex.names=lab)
data_inbLoad_mig_start <- data.frame(mean(data_mig0.0$inbLoad_start), mean(data_mig0.5$inbLoad_start), mean(data_mig2.0$inbLoad_start))
stripchart(data_inbLoad_mig_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# rescue scenarios
par(mar=mar2)
data_inbLoad_rescue <- cbind(data_mig0.5$inbLoad_end,data_mig0.5_rescue$inbLoad_end, data_mig0.5_rescueCK$inbLoad_end)                                                                
boxplot(data_inbLoad_rescue, col =colors[5], yaxt = "n", names = c("no rescue*", "rescue", "rescue_div"),ylim = c(0,3), cex.lab=lab, cex.axis=axis, cex.names=lab)
data_inbLoad_rescue_start <- data.frame(mean(data_mig0.5$inbLoad_start), mean(data_mig0.5_rescue$inbLoad_start), mean(data_mig0.5_rescueCK$inbLoad_start))
stripchart(data_inbLoad_rescue_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# pmort scenarios
par(mar=mar2)
data_inbLoad_pmort <- cbind(data_mig0.5_pdeath0.1$inbLoad_end, data_mig0.5$inbLoad_end, data_mig0.5_pdeath0.2$inbLoad_end)                                                                   
boxplot(data_inbLoad_pmort, col =colors[5],names = c("pmort0.1", "pmort0.15*", "pmort0.2"), ylim = c(0,3), cex.lab=lab, cex.axis=axis, cex.names=lab,yaxt = "n")
data_inbLoad_pmort_start <- data.frame(mean(data_mig0.5_pdeath0.1$inbLoad_start), mean(data_mig0.5$inbLoad_start), mean(data_mig0.5_pdeath0.2$inbLoad_start))
stripchart(data_inbLoad_pmort_start,add=TRUE, vertical=TRUE, pch=4, cex=2)



dev.off()







### boxplots of stats at end - genomic and demographic parameters
setwd("~/Documents/UCLA/Caracals/Simulations/plots/")
pdf("end_of_sim_boxplots_genomic_demographic.pdf", height=10, width=9)

library(RColorBrewer)
colors = brewer.pal(n = 6, name = "Blues")[2:6]

lab=1.6
axis=1.2

mar1=c(3,4.5,1,1)
mar2=c(3,0,1,1)


### plot population size 
# mutation rate scenarios
par(bty="n",  mfrow=c(5,3), mar=mar1)
data_popsize_murate <- cbind(data_gene1250$popsize_end, data_mig0.5$popsize_end, data_gene2100$popsize_end)                                                                   
boxplot(data_popsize_murate, col =colors[1],names = c("U=0.3", "U=0.4*", "U=0.5"), ylim = c(0,65), main="vary mutation rate", cex.lab=lab, cex.axis=axis, cex.names=lab, cex.main=1.5, ylab = "Population size")
data_popsize_murate_start <- data.frame(mean(data_gene1250$popsize_start), mean(data_mig0.5$popsize_start), mean(data_gene2100$popsize_start))
stripchart(data_popsize_murate_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# dominance scenarios
par(mar=mar2)
data_popsize_dominance <- cbind(data_mig0.5$popsize_end,data_mig0.5_dominance$popsize_end)                                                             
boxplot(data_popsize_dominance, col =colors[1], yaxt = "n", names = c("more recessive*", "less recessive"),ylim = c(0,65), main="vary dominance", cex.lab=lab, cex.axis=axis, cex.names=lab, cex.main=1.5)
data_popsize_dominance_start <- data.frame(mean(data_mig0.5$popsize_start), mean(data_mig0.5_dominance$popsize_start))
stripchart(data_popsize_dominance_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# ancestral pop size scenarios
par(mar=mar2)
data_popsize_smallKa <- cbind(data_mig0.5$popsize_end, data_small_NA$popsize_end)                                                                   
boxplot(data_popsize_smallKa, col =colors[1],names = c("Ka=76000*", "Ka=7600"), ylim = c(0,65), main="vary ancestral carrying capacity", cex.lab=lab, cex.axis=axis, cex.names=lab,yaxt = "n", cex.main=1.5)
data_popsize_smallKa_start <- data.frame(mean(data_mig0.5$popsize_start), mean(data_small_NA$popsize_start))
stripchart(data_popsize_smallKa_start,add=TRUE, vertical=TRUE, pch=4, cex=2)



### plot Froh
# mutation rate scenarios
par(bty="n", mar=mar1)
data_froh_murate <- cbind(data_gene1250$froh_end, data_mig0.5$froh_end, data_gene2100$froh_end)                                                                   
boxplot(data_froh_murate, col =colors[2],names = c("U=0.3", "U=0.4*", "U=0.5"), ylim = c(0,0.6), cex.lab=lab, cex.axis=axis, cex.names=lab, ylab = expression('F'[ROH]))
data_froh_murate_start <- data.frame(mean(data_gene1250$froh_start), mean(data_mig0.5$froh_start), mean(data_gene2100$froh_start))
stripchart(data_froh_murate_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# dominance scenarios
par(mar=mar2)
data_froh_dominance <- cbind(data_mig0.5$froh_end,data_mig0.5_dominance$froh_end)                                                             
boxplot(data_froh_dominance, col =colors[2], yaxt = "n", names = c("more recessive*", "less recessive"),ylim = c(0,0.6), cex.lab=lab, cex.axis=axis, cex.names=lab)
data_froh_dominance_start <- data.frame(mean(data_mig0.5$froh_start), mean(data_mig0.5_dominance$froh_start))
stripchart(data_froh_dominance_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# ancestral pop size scenarios
par(mar=mar2)
data_froh_smallKa <- cbind(data_mig0.5$froh_end, data_small_NA$froh_end)                                                                   
boxplot(data_froh_smallKa, col =colors[2],names = c("Ka=76000*", "Ka=7600"), ylim = c(0,0.6), cex.lab=lab, cex.axis=axis, cex.names=lab,yaxt = "n")
data_froh_smallKa_start <- data.frame(mean(data_mig0.5$froh_start), mean(data_small_NA$froh_start))
stripchart(data_froh_smallKa_start,add=TRUE, vertical=TRUE, pch=4, cex=2)



### plot fst
# mutation rate scenarios
par(bty="n", mar=mar1)
data_fst_murate <- cbind(data_gene1250$fst_end, data_mig0.5$fst_end, data_gene2100$fst_end)                                                                   
boxplot(data_fst_murate, col =colors[3],names = c("U=0.3", "U=0.4*", "U=0.5"), ylim = c(0,0.25), cex.lab=lab, cex.axis=axis, cex.names=lab,ylab = expression('F'[ST]))
data_fst_murate_start <- data.frame(mean(data_gene1250$fst_start), mean(data_mig0.5$fst_start), mean(data_gene2100$fst_start))
stripchart(data_fst_murate_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# dominance scenarios
par(mar=mar2)
data_fst_dominance <- cbind(data_mig0.5$fst_end,data_mig0.5_dominance$fst_end)                                                             
boxplot(data_fst_dominance, col =colors[3], yaxt = "n", names = c("more recessive*", "less recessive"),ylim = c(0,0.25), cex.lab=lab, cex.axis=axis, cex.names=lab)
data_fst_dominance_start <- data.frame(mean(data_mig0.5$fst_start), mean(data_mig0.5_dominance$fst_start))
stripchart(data_fst_dominance_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# ancestral pop size scenarios
par(mar=mar2)
data_fst_smallKa <- cbind(data_mig0.5$fst_end, data_small_NA$fst_end)                                                                   
boxplot(data_fst_smallKa, col =colors[3],names = c("Ka=76000*", "Ka=7600"), ylim = c(0,0.25), cex.lab=lab, cex.axis=axis, cex.names=lab,yaxt = "n")
data_fst_smallKa_start <- data.frame(mean(data_mig0.5$fst_start), mean(data_small_NA$fst_start))
stripchart(data_fst_smallKa_start,add=TRUE, vertical=TRUE, pch=4, cex=2)



### plot genetic load
# mutation rate scenarios
par(bty="n", mar=mar1)
data_genLoad_murate <- cbind(data_gene1250$genLoad_end, data_mig0.5$genLoad_end, data_gene2100$genLoad_end)                                                                   
boxplot(data_genLoad_murate, col =colors[4],names = c("U=0.3", "U=0.4*", "U=0.5"), ylim = c(0,0.25), cex.lab=lab, cex.axis=axis, cex.names=lab, ylab = 'Genetic load')
data_genLoad_murate_start <- data.frame(mean(data_gene1250$genLoad_start), mean(data_mig0.5$genLoad_start), mean(data_gene2100$genLoad_start))
stripchart(data_genLoad_murate_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# dominance scenarios
par(mar=mar2)
data_genLoad_dominance <- cbind(data_mig0.5$genLoad_end,data_mig0.5_dominance$genLoad_end)                                                             
boxplot(data_genLoad_dominance, col =colors[4], yaxt = "n", names = c("more recessive*", "less recessive"),ylim = c(0,0.25), cex.lab=lab, cex.axis=axis, cex.names=lab)
data_genLoad_dominance_start <- data.frame(mean(data_mig0.5$genLoad_start), mean(data_mig0.5_dominance$genLoad_start))
stripchart(data_genLoad_dominance_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# ancestral pop size scenarios
par(mar=mar2)
data_genLoad_smallKa <- cbind(data_mig0.5$genLoad_end, data_small_NA$genLoad_end)                                                                   
boxplot(data_genLoad_smallKa, col =colors[4],names = c("Ka=76000*", "Ka=7600"), ylim = c(0,0.25), cex.lab=lab, cex.axis=axis, cex.names=lab,yaxt = "n")
data_genLoad_smallKa_start <- data.frame(mean(data_mig0.5$genLoad_start), mean(data_small_NA$genLoad_start))
stripchart(data_genLoad_smallKa_start,add=TRUE, vertical=TRUE, pch=4, cex=2)




### plot inbreeding load 
# mutation rate scenarios
par(bty="n", mar=mar1)
data_inbLoad_murate <- cbind(data_gene1250$inbLoad_end, data_mig0.5$inbLoad_end, data_gene2100$inbLoad_end)                                                                   
boxplot(data_inbLoad_murate, col =colors[5],names = c("U=0.3", "U=0.4*", "U=0.5"), ylim = c(0,3), cex.lab=lab, cex.axis=axis, cex.names=lab, ylab = "Inbreeding load")
data_inbLoad_murate_start <- data.frame(mean(data_gene1250$inbLoad_start), mean(data_mig0.5$inbLoad_start), mean(data_gene2100$inbLoad_start))
stripchart(data_inbLoad_murate_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# dominance scenarios
par(mar=mar2)
data_inbLoad_dominance <- cbind(data_mig0.5$inbLoad_end,data_mig0.5_dominance$inbLoad_end)                                                             
boxplot(data_inbLoad_dominance, col =colors[5], yaxt = "n", names = c("more recessive*", "less recessive"),ylim = c(0,3), cex.lab=lab, cex.axis=axis, cex.names=lab)
data_inbLoad_dominance_start <- data.frame(mean(data_mig0.5$inbLoad_start), mean(data_mig0.5_dominance$inbLoad_start))
stripchart(data_inbLoad_dominance_start,add=TRUE, vertical=TRUE, pch=4, cex=2)

# ancestral pop size scenarios
par(mar=mar2)
data_inbLoad_smallKa <- cbind(data_mig0.5$inbLoad_end, data_small_NA$inbLoad_end)                                                                   
boxplot(data_inbLoad_smallKa, col =colors[5],names = c("Ka=76000*", "Ka=7600"), ylim = c(0,3), cex.lab=lab, cex.axis=axis, cex.names=lab,yaxt = "n")
data_inbLoad_smallKa_start <- data.frame(mean(data_mig0.5$inbLoad_start), mean(data_small_NA$inbLoad_start))
stripchart(data_inbLoad_smallKa_start,add=TRUE, vertical=TRUE, pch=4, cex=2)


dev.off()





### plot burnin
setwd("~/Documents/UCLA/Caracals/Simulations/data")
data <- read.csv("burnin.csv")
setwd("~/Documents/UCLA/Caracals/Simulations/plots/")
pdf("burnin.pdf", height=8, width=5)

library(RColorBrewer)
colors = brewer.pal(n = 6, name = "Blues")[2:6]

par(mfrow=c(4,1),mar = c(4,5,2,1), bty = "n")
xmin <- 0
xmax <- 5000
lab=1.6
axis=1.2
lwd=4

plot(data$gen, data$popSize, xlim=c(xmin,xmax), type = 'l', ylab = "N", xlab = 'Year', col = colors[1], lwd=lwd, cex.axis=axis, cex.lab=lab, ylim = c(0,80000))

plot(data$gen, data$FROH_1Mb, xlim=c(xmin,xmax), type = 'l', ylab = expression('F'[ROH]), xlab = 'Year',ylim=c(0,1), col = colors[2], lwd=lwd, cex.axis=axis, cex.lab=lab)

plot(data$gen, 1-data$meanFitness, xlim=c(xmin,xmax), type= 'l', ylim = c(0,0.1), ylab = "Genetic load", xlab = 'Year', col = colors[4], lwd=lwd, cex.axis=axis, cex.lab=lab)

plot(data$gen, data$B_year, type = "l", xlim=c(xmin,xmax), ylab = "Inbreeding load", xlab = 'Year', ylim = c(0,3), col = colors[5], lwd=lwd, cex.axis=axis, cex.lab=lab)


dev.off()








### test plot 

setwd("~/Documents/UCLA/Caracals/Simulations/data")
data <- read.csv("caracals_test.csv")

par(mfrow=c(5,1),mar = c(4,5,2,1), bty = "n")
xmin <- 5000
xmax <- 5130
lab=1.6
axis=1.2
lwd=4

start_year <- 1940
end_year <- 2070

library(RColorBrewer)
colors = brewer.pal(n = 6, name = "YlOrRd")[2:6]


plot(data$gen, data$popSize, xlim=c(xmin,xmax), ylim=c(0,65), type = 'l',xaxt="n", ylab = "N", xlab = 'Year', col = colors[1], lwd=lwd, cex.axis=axis, cex.lab=lab)
axis(1, at=seq(xmin,xmax, by=10), labels=c(seq(start_year, end_year, by = 10)), cex.axis=axis)


plot(data$gen, data$FROH_1Mb, xlim=c(xmin,xmax), type = 'l',xaxt="n", ylab = "FROH", xlab = 'Year',ylim=c(0,0.5), col = colors[2], lwd=lwd, cex.axis=axis, cex.lab=lab)
axis(1, at=seq(xmin,xmax, by=10), labels=c(seq(start_year, end_year, by = 10)), cex.axis=axis)
points(x = 5075, y=0.1997243, pch=4, cex=3)

plot(data$gen, data$fst_GCT, type = "l", xlim=c(xmin,xmax),xaxt="n",ylab = "Fst", xlab = 'Year', ylim = c(0,0.25), col = colors[3], lwd=lwd, cex.axis=axis, cex.lab=lab)
axis(1, at=seq(xmin,xmax, by=10), labels=c(seq(start_year, end_year, by = 10)), cex.axis=axis)
points(x = 5075, y=0.053, pch=4, cex=3)

plot(data$gen, 1-data$meanFitness, xlim=c(xmin,xmax), type= 'l', ylim = c(0,0.3),xaxt="n", ylab = "Genetic load", xlab = 'Year', col = colors[4], lwd=lwd, cex.axis=axis, cex.lab=lab)
axis(1, at=seq(xmin,xmax, by=10), labels=c(seq(start_year, end_year, by = 10)), cex.axis=axis)

plot(data$gen, data$B_year, type = "l", xlim=c(xmin,xmax),xaxt="n",ylab = "Inbreeding load", xlab = 'Year', ylim = c(0,4), col = colors[5], lwd=lwd, cex.axis=axis, cex.lab=lab)
axis(1, at=seq(xmin,xmax, by=10), labels=c(seq(start_year, end_year, by = 10)), cex.axis=axis)

data$fst_CK[which(data$gen==5076)]




### plot p1
par(mfrow=c(5,1),mar = c(4,5,2,1), bty = "n")
xmin <- 5000
xmax <- 5130
lab=1.6
axis=1.2
lwd=4

start_year <- 1940
end_year <- 2070

plot(data$gen, data$popSize, xlim=c(xmin,xmax), ylim=c(0,200), type = 'l',xaxt="n", ylab = "N", xlab = 'Year', col = colors[1], lwd=lwd, cex.axis=axis, cex.lab=lab)
axis(1, at=seq(xmin,xmax, by=10), labels=c(seq(start_year, end_year, by = 10)), cex.axis=axis)


plot(data$gen, data$FROH_1Mb, xlim=c(xmin,xmax), type = 'l',xaxt="n", ylab = "FROH", xlab = 'Year',ylim=c(0,0.5), col = colors[2], lwd=lwd, cex.axis=axis, cex.lab=lab)
axis(1, at=seq(xmin,xmax, by=10), labels=c(seq(start_year, end_year, by = 10)), cex.axis=axis)
points(x = 5076, y=0.1261081, pch=4, cex=3)

plot(data$gen, data$Fst, type = "l", xlim=c(xmin,xmax),xaxt="n",ylab = "Fst", xlab = 'Year', ylim = c(0,0.25), col = colors[3], lwd=lwd, cex.axis=axis, cex.lab=lab)
axis(1, at=seq(xmin,xmax, by=10), labels=c(seq(start_year, end_year, by = 10)), cex.axis=axis)
points(x = 5076, y=0.053, pch=4, cex=3)

plot(data$gen, 1-data$meanFitness, xlim=c(xmin,xmax), type= 'l', ylim = c(0,0.3),xaxt="n", ylab = "Genetic load", xlab = 'Year', col = colors[4], lwd=lwd, cex.axis=axis, cex.lab=lab)
axis(1, at=seq(xmin,xmax, by=10), labels=c(seq(start_year, end_year, by = 10)), cex.axis=axis)

plot(data$gen, data$B, type = "l", xlim=c(xmin,xmax),xaxt="n",ylab = "Inbreeding load", xlab = 'Year', ylim = c(0,4), col = colors[5], lwd=lwd, cex.axis=axis, cex.lab=lab)
axis(1, at=seq(xmin,xmax, by=10), labels=c(seq(start_year, end_year, by = 10)), cex.axis=axis)






### plot neutral het during burnin

setwd("~/Documents/UCLA/Caracals/Simulations/data")
data <- read.csv("caracals_test.csv")
xmin <- 0
xmax <- 50000
lab=1.6
axis=1.2
lwd=4

par(mfrow=c(1,1),mar = c(4,5,2,1), bty = "n")

plot(data$gen, data$meanHet, xlim=c(xmin,xmax), type = 'l', ylab = "N", xlab = 'Year', col = colors[1], lwd=lwd, cex.axis=axis, cex.lab=lab)

mean(tail(data$meanHet))








