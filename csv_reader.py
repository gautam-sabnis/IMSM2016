import pandas as pd

data =pd.read_csv('daily_site_PM25_WesternUS_2000.csv', sep = '|') 	#read PM2.5 file
data['sample_day']
days = data['sample_day'].str.replace('-','')				#change days to MATLAB readable format
data2 = pd.DataFrame(data,columns = ['latitude', 'longitude', 'daily_value'])
newdata = pd.concat([days, data2], axis=1)				#put files together with useful info
newdata.to_csv('test.csv')






