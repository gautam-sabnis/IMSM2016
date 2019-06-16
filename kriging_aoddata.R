rm(list = ls())
library(rgdal)
library(maptools)
library(gstat)
library(sp)
library(maps)
library(geoR)
library(fields)

setwd("D:/samsi_summer2016/imsm2016_epa/PM25_1/PM25")
aod_data = read.csv("D:/samsi_summer2016/imsm2016_epa/PM25_1/PM25/aod_data2009.csv")
attach(aod_data)
colnames = c("Year","Month","Date","Latitude","Longitude","AOD_Value")
names(aod_data) <- colnames

filename1 = "D:/samsi_summer2016/imsm2016_epa/PM25_1/Krig_code_data_plots/Predicted_values_pictures/"
filename2 = "D:/samsi_summer2016/imsm2016_epa/PM25_1/Krig_code_data_plots/Standard_error_pictures/"


## chop data with dd-mm
unique_ddmm <- unique(aod_data[c("Month","Date")])
cutoff_ddmm <- as.numeric(row.names(unique_ddmm))
# cbind(unique_ddmm,cutoff_ddmm)

#for (i in 1:length(cutoff_ddmm)) {
i=4
rm("z", "s","vg", "pm", "ml","sp1","sp2","sp","inCA", "pred","plotname1","plotname2")
aod_data[cutoff_ddmm[i],c("Month", "Date")]
# Plot the data
z <- (aod_data[(cutoff_ddmm[i]:(cutoff_ddmm[i+1]-1)),4:6])
s <- cbind(z[,2],z[,1])
aod <- z[,3]
plot_field_points(s,aod,map.border="state",cex=0.1, pch= 8)
plot(s)
X11()


#Variogram analysis
vg <- variog(data=aod,coords=s)
plot(vg)
eyefit(vg)

#Estimate parameters by maximum likelihood:
ml <- likfit(data=aod,coords=s,
             fix.nugget=F,fix.kappa=F,cov.model="matern",
             ini = c(30,5),nugget=0.05,kappa=1.5)

#Create grid of prediction points:
sp1<-seq(min(s[,1]),max(s[,1]),length=100)
sp2<-seq(min(s[,2]),max(s[,2]),length=100)
sp<-expand.grid(sp1,sp2)
inCA<-map.where("state",x=sp[,1],y=sp[,2])


#Perform ordinary Kriging:
pred<-krige.conv(data= aod,coords=s,locations=sp,
                 krige=krige.control(cov.model="matern",
                                     beta=ml$beta,
                                     cov.pars=c(ml$sigmasq,ml$phi),
                                     kappa=ml$kappa,
                                     nugget=ml$tausq))

#Plot the predicted values:
plotname1 = paste("AOD_Interpolated_Values_", sprintf("%02d", aod_data$Date[cutoff_ddmm[i]]),sprintf("%02d", aod_data$Month[cutoff_ddmm[i]]),sprintf("%04d", aod_data$Year[cutoff_ddmm[i]]), sep= "")
png(filename = paste(filename1,"Interpolated_AOD2009_",sprintf("%02d",i),".png", sep = ""))

image.plot(sp1,sp2,matrix(pred$predict,100,100),zlim=range(aod), main = plotname1, xlab = "Longitude", ylab = "Latitude")
map("state",add=T)
points(s, pch = 8, cex = 0.1)
dev.off()

#Plot the standard errors:

plotname2 = paste("AOD_Standard_Error_", sprintf("%02d", aod_data$Date[cutoff_ddmm[i]]),sprintf("%02d", aod_data$Month[cutoff_ddmm[i]]),sprintf("%04d", aod_data$Year[cutoff_ddmm[i]]), sep= "")
png(filename = paste(filename2,"StandardError_AOD2009_",sprintf("%02d",i),".png", sep = ""))

image.plot(sp1,sp2,matrix(sqrt(pred$krige.var),100,100),main = plotname2, xlab = "Longitude", ylab = "Latitude")
map("state",add=T)
points(s,pch = 8, cex = 0.1)

dev.off()
#}