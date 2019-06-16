#IMSM_EPA
#Chuanping Yu
#July 21, 2016

#getwd()
setwd("/Users/C.Yu/Desktop/imsm_awesome/AOT_PM")

data_aot = read.table("AOD.txt", header = F);
data_aot[,1] = as.Date(as.character(data_aot[,1]),format="%Y%m%d")
data_pm = read.table("pm2.5.txt", header = T);
data_pm[,1] = as.Date(as.character(data_pm[,1]))

findMatch <- function(P,radius){
    #P <- c(40.71528,	-124.20139)
    #radius <- 0.00999
	Cood <- data_aot[,2:3]
	D = (Cood[,1]-P[1])^2 + (Cood[,2]-P[2])^2
	aot_P = Cood[which(D == min(D)),]

	Data_P_aot <- data_aot[which(D == min(D)),]
	Data1 <- data_aot[D<radius,]
	colnames(Data1) <- c('date','lat_aot','long_aot','aot')
	#Data1 <- Data_P_aot
	if (nrow(Data1)!=0) {
		data_pm1 = data_pm[(data_pm[,2] == as.numeric(P[1]) & data_pm[,3] == as.numeric(P[2])), ]
		PM_match = data_pm1[data_pm1[,1] == Data1[1,1], ] 

		for (i in 2:nrow(Data1)){
			PM_match_tmp0 = data_pm1[data_pm1[,1] == Data1[i,1], ] 
		    PM_match = rbind(PM_match,PM_match_tmp0)
		}
		colnames(PM_match) <- c('date','lat_pm','long_pm','pm')
	}else
		PM_match = matrix(rep(0,4),1,4)
	return(PM_match)
}

findMatch(c(40.71528,	-124.20139),0.00999)
Mix = merge(PM_match, Data1, by = 'date')
plot(Mix$pm~Mix$aot)
#plot(Mix$aot~Mix$date,type='b')
cor(Mix$pm,Mix$aot)

