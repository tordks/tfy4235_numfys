
import numpy as np
import matplotlib.pyplot as plt



import matplotlib.pyplot as plt  # Matplotlib's pyplot: MATLAB-like syntax
from pylab import *              # Matplotlib's pylab interface
ion()


f = open('resultsJ.txt')
g = open('resultsGS.txt')
h = open('resultsJ.txt')

n = float(f.readline())
x = np.zeros(int(n))
y = np.zeros(int(n))
print(n)


for i in range(0,int(n)):
	y[i] = i
	x[i] = float(f.readline())
#	print x[i]
plt.plot(x, y,'*')

n = float(g.readline())
for i in range(0,int(n)):
	y[i] = i
	x[i] = float(g.readline())
#	print x[i]
plt.plot(x, y, 'r*')
	
n = float(h.readline())
for i in range(0,int(n)):
	y[i] = i
	x[i] = float(h.readline())
#	print x[i]
plt.plot(x, y, 'g*')



#plt.show()
raw_input("Press enter to continue")



