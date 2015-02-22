import numpy as np
import matplotlib.pyplot as plt  
import pylab
from pylab import * 
ion()

#Skal plotte flere filer inn i samme plot.

f = open('toplotscatter.txt')
n = float(f.readline())	#Number of files to plot

w = 1;
L = 20*10**(-6);

for i in range(0,int(n)):
	infile = f.readline().rstrip('\n');
	g = open(infile)
	outfile = g.readline().rstrip('\n') + '.pdf';
	#print outfile
	
	m = float(g.readline().rstrip('\n'));			# Number og points.
	
	x = np.linspace(0,m*0.05,m)
	#print(x);
	y = np.zeros(int(m))

	for i in range(0,int(m)):
		y[i] = float(g.readline())
	
	
	y = y*L;
	#dt = 0.05 => t allerede med dimensjon.
	plt.plot(x, y);
	g.close()	

plt.ticklabel_format(style='sci', axis='y', scilimits=(0,0))
plt.ticklabel_format(style='sci', axis='x', scilimits=(0,0))
plt.xlabel("t")
plt.ylabel("x")
plt.title("Position of a particle with time.")
pylab.text(0.25, 0.7, '$dU = 0.1$', fontsize = 11, color = 'b')
pylab.text(0.25, 0.67, '$dU = 0.5$', fontsize = 11, color = 'g')
pylab.text(0.25, 0.64, '$dU = 10$', fontsize = 11, color = 'r')
pylab.text(0.25, 0.61, '$dt = 0.05$', fontsize = 11)
plt.savefig("Position of a particle with time.pdf")

raw_input("Press enter to continue")



