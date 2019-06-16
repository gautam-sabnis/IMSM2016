from csv import reader
from pylab import *
import pandas as pd
from csv_with_pandas import *
from PM_25_plot import *
from PM_by_date import *
import re

'''
#test finding the csv files we want
filenames = ['20000103.csv', '20000114.csv', 'daily_site_PM25_WesternUS_2000.csv']
myre = '[0-9]{8}\.csv'
for item in filenames:
	print re.findall(myre, item)
'''

filename = 'daily_site_PM25_WesternUS_2000.csv'
PM_mapper(date_csv(filename)[0:4])














