rm(list = ls())
library(geoR)
library(fields)
library(maps)
library(mapproj)
library(tcltk)


#Pretty picture 1 (Hawaii data)
data <- read.csv("~/Documents/imsm16_epa/imsm2016_epa/Hawaii_closest.txt", sep="")
attach(data)

PM = data$pm; long = data$long_pm; lat = data$lat_pm;
df = data.frame(x = long, y = lat, PM = PM);
hawaii = get_map(location=c(-156,20),zoom=7,maptype="hybrid",color="color")
ggmap(hawaii, darken = c(0.5, "gray")) + geom_point(aes(x,y,color = PM, size = PM), data = df)

#Pretty picture 2(Mix California data)
data <- read.csv("~/Documents/imsm16_epa/imsm2016_epa/Mix.txt", sep="")
attach(data)

PM = data$pm; long = data$long_pm; lat = data$lat_pm;
coord = cbind(long,lat)
plot.field.points(coord, PM, map.border = "county", cex = 1.5)


#Variogram Analysis
data <- read.csv("~/Documents/imsm16_epa/imsm2016_epa/Mix.txt", sep="")
attach(data)

PM = data$pm; long = data$long_pm; lat = data$lat_pm;
resid_pm = lm(PM ~ long + lat)$residuals
resid_data = list(coords = cbind(long,lat), data = resid_pm)
s = mapproject(resid_data$coords[,1], resid_data$coords[,2], projection = 'mercator')
resid_data$coords = cbind(s$x, s$y)

bins = seq(0,20,0.5)
vg = variog(resid_data, uvec = bins)
