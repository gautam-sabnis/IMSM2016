
setwd("D:/samsi_summer2016/imsm2016_epa/PM25_1/PM25") 

filename <- data.frame(daily_site_PM25_WesternUS_2000_2015)
#attach(filename)


# find the matrix index of a particular latitude
#lat = filename$latitude[5266] #insert index


# subset
cols <- c("latitude","longitude","sample_date","sample_month","sample_year","daily_value")
#subdata <- data.frame(filename[which(filename$latitude ==lat),cols])
subdata <- data.frame(filename[,cols])

# find day in julia calender 
numdays <- c(0,29,60,91,121,152,182,213,243,274,304,335)
juliaday = subdata$sample_date + numdays[subdata$sample_month];

# obtain pm values for a year in an array
subdata_array = as.list(rep(0, 366))
subdata_array[juliaday] = subdata$daily_value
plot(c(1:366),subdata_array)
write.csv(file = "cleanPM_2000_2015.csv", x = subdata, row.names = F)

