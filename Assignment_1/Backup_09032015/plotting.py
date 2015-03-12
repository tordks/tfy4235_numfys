import time
import numpy as np
import matplotlib
matplotlib.use('Agg');
import matplotlib.pyplot as plt  
from matplotlib import rc
rc('font', **{'family': 'serif', 'serif': ['Computer Modern']})
rc('text', usetex=True)
import pylab
from pylab import * 

ion()


#-----------------------------------------
#		read_constants():
#-----------------------------------------
# Read the constants from the file "constants.txt"
def read_constants():
    f = open('constants.txt', 'r')
    
    dU 	= float(f.readline().rstrip('\n')); #[J]
    tau = float(f.readline().rstrip('\n')); #[s]
    tid = float(f.readline().rstrip('\n')); #[s]
    dt = float(f.readline().rstrip('\n'));  #[s]
    N = int(float(f.readline().rstrip('\n')));     #[1] Antall partikler
    M = int(float(f.readline().rstrip('\n')));		#[1] Antall ganger programmet er kjort (antall tau-verdier)
    Nt = int(float(f.readline().rstrip('\n')));	#[1] Antall tidssteg
    w = float(f.readline().rstrip('\n'));	#[]  
    f.close()
    return(dU,tau,tid,dt,N,M,Nt,w)



#-----------------------------------------
#		plot_avgDriftVelocity();
#-----------------------------------------
# Plots the avg. drift velocity as a function of tau
def plot_avgDriftVelocity():
	data = np.loadtxt('AvgDriftvelocity.txt') #2xM array
	
	print(data[0,:])
	print(data[1,:])
	
	plt.title('Average drift Velocity')
	plt.ylabel('Vd')
	plt.xlabel(r'$\tau$')
	plt.plot(data[0,:], data[1,:], '*')
	#plt.errorbar(data[0,:], data[1,:], yerr=data[2,:])
	
	x1,x2,y1,y2 = plt.axis()
	#plt.axis((x1,x2,-2E-11,8E-11))
	
	plt.savefig('avgDriftVelocity.pdf')
	
	print(max(data[1,:]))
	i = argmax(data[1,:])
	print(i)
	print(data[1,i])
	print(data[0,i])
	
	#print(data[0,i])




#-----------------------------------------#
#-----------------------------------------#
#					Main			      #
#-----------------------------------------#
#-----------------------------------------#
start = time.time()

read_constants()
plot_avgDriftVelocity()

stop = time.time()


print("Plottime: %f seconds" %(stop-start))
raw_input("Press enter to continue")



