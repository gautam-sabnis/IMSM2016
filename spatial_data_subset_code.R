rm(list = ls())
setwd("~/Documents/IMSM16EPA")
aod_data = read.csv("~/Documents/IMSM16EPA/New_AOD.txt", sep = "")
attach(aod_data)
colnames = c("Year","Month","Date","Latitude","Longitude","AOD_Value")
names(aod_data) <- colnames

# chop data per year
freq_year <- data.frame(table(aod_data$Year))
# assumes data is sorted according to Year in acsending order
cutoffindex <- c(sum(freq_year[1:1,2]),sum(freq_year[1:2,2]),sum(freq_year[1:3,2]),sum(freq_year[1:4,2]),sum(freq_year[1:5,2]))
aod_data2009 <- aod_data[(cutoffindex[4]+1):cutoffindex[5],]
write.csv(aod_data2009, file = "aod_data2009.csv", row.names = F)
head(aod_data2009)
tail(aod_data2009)

#lat north 70.4260754 
#lat south 1.357207, 
#long cal  -121.087520
#long china 119.768714