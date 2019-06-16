from csv import reader
import pandas as pd
from csv_with_pandas import *

#input a PM data file and this function creates, and stores a separate csv file for each date
def date_csv(filename):
	df = clean_csv(filename)

	#
	#manually collect all possible days
	days = ['0'+str(i) for i in range(1,10)]
	days+= [str(i) for i in range(11, 32)]

	months = ['0'+str(i) for i in range(1,10)]
	months+= [str(i) for i in range(11, 13)]


	#get list of the dates in order
	unique_dates = []
	for month in months:
		for day in days:
			unique_dates.append('2000'+month+day)


	#need to change for AOT!!!
	filenames = []
	for i in range(len(unique_dates)):
		df.loc[df['sample_day'] == unique_dates[i]].to_csv(unique_dates[i]+'.csv')
		filenames.append(unique_dates[i]+'.csv')
	return filenames


if __name__ == '__main__':
	filename = 'daily_site_PM25_WesternUS_2000.csv'
	print date_csv(filename)















