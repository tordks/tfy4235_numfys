import numpy as np
import matplotlib.pyplot as plt  
import pylab
from pylab import * 
ion()

#Skal plotte flere filer inn i samme plot.

f = open('toplotscatter.txt')
n = float(f.readline())	#Number of files to plot

L  = 20*10**(-6);
g1 = 6 * np.pi * 0.001*12*10**(-9);
w  = [0.1/(g1*L**2) , 0.5/(g1*L**2) , 10/(g1*L**2)]

for i in range(0,int(n)):
	infile = f.readline().rstrip('\n');
	g = open(infile)
	outfile = g.readline().rstrip('\n') + '.pdf';
	#print outfile qw
	
	m = float(g.readline().rstrip('\n'));			# Number og points.
	
	dt = 0.001;
	x = np.linspace(0,m*dt,m)
	y = np.zeros(int(m))

	for j in range(0,int(m)):
		y[j] = float(g.readline())

	plt.plot(x, y); 
	g.close()
#Plotter streker for topp og bunnpunkt paa potensialet
plt.plot([x[0],x[m-1]], [0,0],'black')
for i in range(-6,6):
	plt.plot([x[0],x[m-1]], [i,i],'black')
	#plt.plot([x[0],x[m-1]], [i+0.2,i+0.2],'black')


plt.ticklabel_format(style='sci', axis='y', scilimits=(0,0))
plt.ticklabel_format(style='sci', axis='x', scilimits=(0,0))
plt.xlabel("t ")
plt.ylabel("x")
plt.title("Position of a particle with time.")
pylab.text(0.25, -0.5e-4, '$dU = 0.1$', fontsize = 11, color = 'b')
pylab.text(0.25, -0.55e-4, '$dU = 0.5$', fontsize = 11, color = 'g')
pylab.text(0.25, -0.6e-4, '$dU = 10$', fontsize = 11, color = 'r')
pylab.text(0.25, -0.65e-4, '$dt = 1e-5$', fontsize = 11)
plt.savefig("Position of a particle with time.pdf")

raw_input("Press enter to continue")



