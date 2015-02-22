import numpy as np
import matplotlib.pyplot as plt  
from pylab import *             
ion()

f = open('toplotscatter.txt')
n = float(f.readline())	#Number of files to plot

for i in range(0,int(n)):
	infile = f.readline().rstrip('\n');
	g = open(infile)
	outfile = g.readline().rstrip('\n') + '.pdf';
	print outfile
	
	m = float(g.readline().rstrip('\n'));			# Number og points.
	
	x = np.linspace(0,m*0.05,m)
	print(x);
	y = np.zeros(int(m))


	for i in range(0,int(m)):
		y[i] = float(g.readline())

	plt.plot(x, y,'*');
	
	plt.title("Scatter" + " " + outfile.rstrip('.txt.pdf'))
	plt.savefig(outfile)
	g.close()

raw_input("Press enter to continue")



