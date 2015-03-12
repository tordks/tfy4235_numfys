
import numpy as np
import matplotlib.pyplot as plt



import matplotlib.pyplot as plt  # Matplotlib's pyplot: MATLAB-like syntax
from pylab import *              # Matplotlib's pylab interface
ion()

with open('results.txt') as f:
	n = int(f.readline())
	x = np.zeros(int(n))
	y = np.zeros(int(n))

	for i in range(0,n):
		y[i] = i
		x[i] = int(f.readline())
		#print x[i]

print(y)
plt.plot(x, y,'*')
plt.show()
raw_input("Press enter to continue")



