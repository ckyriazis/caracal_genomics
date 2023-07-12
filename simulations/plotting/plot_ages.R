



setwd("~/Documents/UCLA/Caracals/Simulations/data")
age <- scan("ages.txt")

length(age)
#age <- sample(age, 8800, replace = F)


mean(age)
median(age)
max(age)

counts <- c(length(age[age==0]),length(age[age==1]),length(age[age==2]),length(age[age==3]),length(age[age==4]),length(age[age==5]),length(age[age==6]),length(age[age==7]),
            length(age[age==8]),length(age[age==9]),length(age[age==10]))




setwd("~/Documents/UCLA/Caracals/Simulations/plots")

pdf("survivorship.pdf", height=4, width=7)
par(mar = c(5,5,1.5,1))

barplot(counts/counts[1], col = "orange", xlab = "age", names.arg = seq(0,10, by = 1), cex.lab=1.5, ylab='probability of survival')

dev.off()




### plot distribution of litter size
setwd("~/Documents/UCLA/Caracals/Simulations/plots")

pdf("litter_size.pdf", height=5, width=8)
offspring <- c()

for(i in 1:10000){
  offspring <- c(offspring, min(rpois(n=1, lambda = 3), 6))
}
hist(offspring, col = 'grey', main = "Distribution of litter size", xlab = "# of offspring", cex.lab=1.5)

dev.off()





deaths<-c(11,6,7,5,7,6,8,13)
mean(deaths)


p_death <- rbinom(n = 50,size = 60,prob = 0.15)

mean(p_death)


hist(p_death, breaks=15)



sum(rpois(5000, 0.001))

rbinom(n = 100,size=60,prob = 0.01)



rpois(5000, 3)



ratio <- 2.37e-05/(4*6e-9)/2000
mean_fitness <- 0.94

35265/ratio/mean_fitness

28/ratio/mean_fitness

92/ratio/mean_fitness

80/ratio/mean_fitness

