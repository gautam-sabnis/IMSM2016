rm(list = ls())
library(rgdal)
library(maptools)
library(gstat)
library(sp)
library(maps)
library(geoR)
library(fields)


setwd("D:/samsi_summer2016/imsm2016_epa/PM25_1/Krig_code_data_plots")
pm_data_all = read.csv("D:/samsi_summer2016/imsm2016_epa/PM25_1/Krig_code_data_plots/daily_site_PM25_WesternUS_2009.csv")
attach(pm_data_all)
pm_data<-pm_data_all[!(pm_data_all$state_name=="Alaska" | pm_data_all$state_name=="Hawaii"),]
rownames(pm_data) <- seq(length=nrow(pm_data))

filename1 = "D:/samsi_summer2016/imsm2016_epa/PM25_1/Krig_code_data_plots/Predicted_values_pictures/"
filename2 = "D:/samsi_summer2016/imsm2016_epa/PM25_1/Krig_code_data_plots/Standard_error_pictures/"

## chop data with dd-mm
unique_ddmm <- unique(pm_data[c("sample_month","sample_date")])
cutoff_ddmm <- as.numeric(row.names(unique_ddmm))
# cbind(unique_ddmm,cutoff_ddmm)


numdays <- c(0,29,60,91,121,152,182,213,243,274,304,335)
a1 = 1+numdays[6] - 1
af = 20 + numdays[7] - 1
c <- seq(a1, af, 2)
#for (i in c) {
rm("z", "s","vg", "pm", "ml","sp1","sp2","sp","inCA", "pred","plotname1","plotname2")
i= 4

pm_data[cutoff_ddmm[i],c("sample_month", "sample_date")]


# Plot the data
z <- (pm_data[(cutoff_ddmm[i]:(cutoff_ddmm[i+1]-1)),c("latitude", "longitude","daily_value")])
nrow(z)

s <- cbind(z[,2],z[,1])
pm <- z[,3]
plot_field_points(s,pm,map.border="state", cex=1.5)
points(s)
X11()


#Variogram analysis
vg <- variog(data=pm,coords=s)
plot(vg)
eyefit(vg)

#Estimate parameters by maximum likelihood:
ml <- likfit(data=pm,coords=s,
             fix.nugget=F,fix.kappa=F,cov.model="matern", 
             ini = c(30,5),nugget=0.05,kappa=1.5)

#Create grid of prediction points:
sp1<-seq((min(s[,1])-3),(max(s[,1])+3),length=100)
sp2<-seq((min(s[,2])-3),(max(s[,2])+3),length=100)
sp<-expand.grid(sp1,sp2)
inCA<-map.where("state",x= sp[,1],y=sp[,2])

#Perform ordinary Kriging:
pred<-krige.conv(data= pm,coords=s,locations=sp,
                 krige=krige.control(cov.model="matern",
                                     beta=ml$beta,
                                     cov.pars=c(ml$sigmasq,ml$phi),
                                     kappa=ml$kappa,
                                     nugget=ml$tausq))

#Plot the predicted values:
plotname1 = paste("PM_Interpolated_Values_", sprintf("%02d", pm_data$sample_date[cutoff_ddmm[i]]),sprintf("%02d", pm_data$sample_month[cutoff_ddmm[i]]),sprintf("%04d", pm_data$sample_year[cutoff_ddmm[i]]), sep= "")
png(filename = paste(filename1,"Interpolated_PM2008_", sprintf("%04d",i), ".png", sep = ""))

image.plot(sp1,sp2,matrix(pred$predict,100,100),zlim=range(pm), main = plotname1, xlab = "Longitude", ylab = "Latitude")
map("state",add=T)
points(s,pch = 8, cex = 0.5)

dev.off()

#Plot the standard errors:
plotname2 = paste("PM_Standard_Error_", sprintf("%02d", pm_data$sample_date[cutoff_ddmm[i]]),sprintf("%02d", pm_data$sample_month[cutoff_ddmm[i]]),sprintf("%04d", pm_data$sample_year[cutoff_ddmm[i]]), sep= "")
png(filename = paste(filename2,"Standard_Error_PM2008_",sprintf("%04d",i),".png", sep = "" ))

image.plot(sp1,sp2,matrix(sqrt(pred$krige.var),100,100), main = plotname2, xlab= "Longitude", ylab = "Latitude")
map("state",add=T)
points(s,pch = 8, cex = 0.5)

dev.off()

#}



