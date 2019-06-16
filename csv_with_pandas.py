import pandas as pd

def clean_csv(filename):
	data =pd.read_csv(filename, sep = '|')
	data['sample_day']
	days = data['sample_day'].str.replace('-','')

	data2 = pd.DataFrame(data,columns = ['latitude', 'longitude', 'daily_value'])
	newdata = pd.concat([days, data2], axis=1)
	return newdata

def write_clean_csv(filename):
	clean_csv(filename).to_csv('new_'+filename)
	return None
	
if __name__ == '__main__':
	clean_csv('daily_site_PM25_WesternUS_2000.csv')
	write_clean_csv('daily_site_PM25_WesternUS_2000.csv')

