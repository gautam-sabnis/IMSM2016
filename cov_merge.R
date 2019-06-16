rm(list = ls())
library(R.matlab)

#Merging the wind speed data

setwd('/Users/Purfvfet/Documents/imsm16_epa')
wins2006 = readMat('windspeed_2006.mat')
wins2007 = readMat('windspeed_2007.mat')
wins2008 = readMat('windspeed_2008.mat')
wins2009 = readMat('windspeed_2009.mat')
w6 = wins2006$windspeed.2006
w7 = wins2007$windspeed.2007
w8 = wins2008$windspeed.2008
w9 = wins2009$windspeed.2009
wins = rbind(w6,w7,w8,w9)
date = seq(as.Date("2006/01/01"), as.Date("2009/12/31"), "days")
date = as.Date(date)
wins = data.frame(date,wins)
#wind$daten <- wind$date

pmdata <- read.csv("~/Documents/imsm16_epa/aod & pm site 40.80178.txt", sep="")
attach(pmdata)
pmdata$date = as.Date(pmdata$date)
#matchdates = intersect(date,Date)
windspeed = merge(pmdata,wins, by = "date")

calisite40.8 = windspeed[,c(1,2,3,4,5,6,7,12)]
colnames(calisite40.8)[8] = "winspeed"
#Merging the wind direction data

wind2006 = readMat('winddirection_2006.mat')
wind2007 = readMat('winddirection_2007.mat')
wind2008 = readMat('winddirection_2008.mat')
wind2009 = readMat('winddirection_2009.mat')
w6 = wind2006$winddirection.2006
w7 = wind2007$winddirection.2007
w8 = wind2008$winddirection.2008
w9 = wind2009$winddirection.2009
wind = rbind(w6,w7,w8,w9)
date = seq(as.Date("2006/01/01"), as.Date("2009/12/31"), "days")
date = as.Date(date)
wind = data.frame(date,wind)
#wind$daten <- wind$date

pmdata <- read.csv("~/Documents/imsm16_epa/aod & pm site 40.80178.txt", sep="")
attach(pmdata)
pmdata$date = as.Date(pmdata$date)
#matchdates = intersect(date,Date)
winddirection = merge(pmdata,wind, by = "date")
calisite40.8 = cbind(calisite40.8, winddirection[,12])
colnames(calisite40.8)[9] = "windirection"

#Merging the relative humidity data

hum2006 = readMat('rhum_2006.mat')
hum2007 = readMat('rhum_2007.mat')
hum2008 = readMat('rhum_2008.mat')
hum2009 = readMat('rhum_2009.mat')
h6 = hum2006$rhum.2006
h7 = hum2007$rhum.2007
h8 = hum2008$rhum.2008
h9 = hum2009$rhum.2009
humd = rbind(h6,h7,h8,h9)
date = seq(as.Date("2006/01/01"), as.Date("2009/12/31"), "days")
date = as.Date(date)
humd = data.frame(date,humd)
#wind$daten <- wind$date

pmdata <- read.csv("~/Documents/imsm16_epa/aod & pm site 40.80178.txt", sep="")
attach(pmdata)
pmdata$date = as.Date(pmdata$date)
#matchdates = intersect(date,Date)
humidity = merge(pmdata,humd, by = "date")
calisite40.8 = cbind(calisite40.8, humidity[,12])
colnames(calisite40.8)[10] = "hum"

#Merging the air temperature data

air2006 = readMat('air_2006.mat')
air2007 = readMat('air_2007.mat')
air2008 = readMat('air_2008.mat')
air2009 = readMat('air_2009.mat')
a6 = air2006$air.2006
a7 = air2007$air.2007
a8 = air2008$air.2008
a9 = air2009$air.2009
air = rbind(a6,a7,a8,a9)
date = seq(as.Date("2006/01/01"), as.Date("2009/12/31"), "days")
date = as.Date(date)
air = data.frame(date,air)
#wind$daten <- wind$date

pmdata <- read.csv("~/Documents/imsm16_epa/aod & pm site 40.80178.txt", sep="")
attach(pmdata)
pmdata$date = as.Date(pmdata$date)
#matchdates = intersect(date,Date)
air = merge(pmdata,air, by = "date")
calisite40.8 = cbind(calisite40.8, air[,12])
colnames(calisite40.8)[11] = "airtemp"

