
import numpy as np
import matplotlib.pyplot as plt



import matplotlib.pyplot as plt  # Matplotlib's pyplot: MATLAB-like syntax
from pylab import *              # Matplotlib's pylab interface
ion()


f = open('results.txt')

n = float(f.readline())
x = np.linspace(-2,2,n)
y = np.zeros(int(n))
print(n)


for i in range(0,int(n)):
	y[i] = float(f.readline())
#	print x[i]

plt.plot(x, y,'*');

#plt.show()
raw_input("Press enter to continue")



