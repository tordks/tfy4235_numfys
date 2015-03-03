import numpy as np
import matplotlib.pyplot as plt  
from pylab import *             
ion()

#f = open('toplotboltz.txt')
#n = float(f.readline())	#Number of files to plot

g = open("potentialenergy.txt")

outfile = g.readline().rstrip('\n') + '.pdf';
m = float(g.readline().rstrip('\n'));			# Number og points.

bins = 500#np.floor(np.log2(m) + 1)*5		# Number of bins from Sturges formula.

y = np.zeros(int(m))
posx = np.zeros(int(m))
for i in range(0,int(m)):
	y[i] = float(g.readline())	


kbT = 0.026;
dU = 10*kbT;
#y = y*10*kbT;
plt.hist(y, bins, normed = 'True')
g.close()	
	
#Analytic result
xa = np.linspace(0,0.35,50)
ya = np.exp(-xa*dU/kbT)/ (kbT*(1-np.exp(-dU/kbT)))*dU
print( sum(ya) * (xa[2]-xa[1]));

plt.plot(xa,ya)
plt.title("Check for correspondance with the boltzmann distribution")
plt.xlabel("U")
plt.ylabel("Frequency")
#plt.show();

#plt.savefig(outfile)

raw_input("Press enter to continue")


