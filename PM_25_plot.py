from csv import reader
from pylab import *
import pandas as pd
from csv_with_pandas import *

#~~~~~~~~~~COLOR STUFF~~~~~~~~~~~~~~#
def rgbtohex( (r,g,b) ):
    s ='#'
    for x in [r,g,b]:
        i = int( 255*x )
        s += hex(i)[2:].zfill(2)
    return s
 #something weird here
def numbertocolor(t):
    a=(1.0-t,1.0-t,1.0-t)
    b=(t,0.0,0.0)
    return map(sum,zip(a,b))
#~~~~~~~~~~~~~~~~~~~~~~~~~#

def PM_mapper(filenames):

	for filename in filenames:
		data =pd.read_csv(filename)
		df = pd.DataFrame(data,columns = ['latitude', 'longitude', 'daily_value'])

		##use for csv file straight from site
		#df = clean_csv(filename) 
	
		lat_data = df['latitude'].values.tolist()
		long_data = df['longitude'].values.tolist()
		PM_data = df['daily_value'].values.tolist()

		#want to normalize the PM data for a nice plot
		#decide how best to normalize... (modify number to color?)
		normed_PM = [(max(PM_data)-i)/max(PM_data) for i in PM_data]
		colors = [rgbtohex(numbertocolor(PM)) for PM in normed_PM]

		#plot the long and lat with colors given by the PM reading
		fig, ax = plt.subplots()
		ax.set_color_cycle(colors)
		for i in range(len(lat_data)):
			plt.plot(long_data[i],lat_data[i], '.')
		plt.show()

	#fig.savefig("image2.png")
	return None

if __name__ == "__main__":
	PM_mapper(['20000101.csv','20000102.csv'])







