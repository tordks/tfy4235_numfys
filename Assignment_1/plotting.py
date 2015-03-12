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
    t	= float(f.readline().rstrip('\n'));  #[s]
    dt  = float(f.readline().rstrip('\n'));  #[s]
    N   = int(float(f.readline().rstrip('\n')));    #[1] Antall partikler
    M   = int(float(f.readline().rstrip('\n')));	#[1] Antall ganger programmet er kjort
    Nt  = int(float(f.readline().rstrip('\n')));	#[1] Antall tidssteg
    w   = float(f.readline().rstrip('\n'));	#[]  
    w2  = float(f.readline().rstrip('\n'));	#[] 
    D1  = float(f.readline().rstrip('\n'));	#[]
    D2  = float(f.readline().rstrip('\n'));	#[] 
    f.close()
    return(dU,tau,tid,t, dt,N,M,Nt,w, w2, D1, D2)


#-----------------------------------------
#		plot_particledensity();
#-----------------------------------------
def plot_particledensity():
	plt.figure();
	
	pos = 10
	tt = pos*dt;
	
	#Simulated result
	data = np.loadtxt('Npartikler.dat')
	plt.title('Particle density')
	plt.ylabel('n')
	plt.xlabel('x')
	plt.hist(data[:,pos], 50);
	
	plt.savefig('particledensity.pdf')

#-----------------------------------------
#		plot_trajectory();
#-----------------------------------------
def plot_trajectory():
	
	y = linspace(0, Nt*dt, Nt)
	data = np.loadtxt('Npartikler.txt') #NxNt array
	plt.title('Trajectory')
	plt.ylabel('x')
	plt.xlabel('t')
	plt.plot(y,data[0,:]);
	
	plt.savefig('trajectoy.pdf')


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

[dU,tau,tid,t,dt,N,M,Nt,w,w2,D1, D2] = read_constants()

#plot_trajectory();
#plt.figure();

#plt.figure
#plot_avgDriftVelocity()

plt.figure();
plot_particledensity()

stop = time.time()
print("Plottime: %f seconds" %(stop-start))
#raw_input("Press enter to continue")



