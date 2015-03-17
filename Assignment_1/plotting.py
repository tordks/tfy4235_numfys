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
from mpl_toolkits.mplot3d import Axes3D

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
    p  = int(float(f.readline().rstrip('\n')));	#[] 
    
    L  = float(f.readline().rstrip('\n'));	#[m]
    a  = float(f.readline().rstrip('\n'));	#[]
    eta  = float(f.readline().rstrip('\n'));	#[]
    KbT  = float(f.readline().rstrip('\n'));
    g1  = float(f.readline().rstrip('\n'));
    g2  = float(f.readline().rstrip('\n'));
    r1  = float(f.readline().rstrip('\n'));
    r2  = float(f.readline().rstrip('\n'));
    f.close()
    return(dU,tau,tid,t, dt,N,M,Nt,w, w2, D1, D2,p, L, a, eta, KbT, g1, g2, r1, r2)


#-----------------------------------------
#		plot_particledensity();
#-----------------------------------------
def plot_particledensity():
	#DIRTY
	
	data = np.loadtxt('Npartikler.txt') #Kommer inn dimensjonslos.
	data = data*L#*10**6;				# Gjor dimensjonsfull og konverterer til mikrometer.
	
	#Setter antall posisjoner som skal plottes.
	nplots = 6
	pos = zeros(nplots);
	tt = zeros(nplots)
	for i in range(nplots):
		pos[i] = floor(i* (1/(float(nplots)-1.0))*(Nt/p));	#Gjor at det blir plottet posisjoner med jevnt mellomrom i tid.
		tt[i] = pos[i]*p*dt;	
	
	pos[nplots-1] = pos[nplots-1] -1;
	print(pos);
	
	
	#Gjor klar til a plotte 3d figur av partikkeltetthetene ved forskjellige posisjoner	
	start = np.floor(data.min()/L) - (1.0-a) 	#Gjor at hvert bin gaar fra et toppunkt til neste pga. det er der flest partikkler
	stop = np.ceil(data.max()/L) + a			#befinner seg til enhver tid.
	bins = (stop-start)
	xmin = start*L								#Setter intervallet som skal plottes
	xmax = stop*L
	
	ax = gca(projection = '3d')
	D1 = KbT/g1	
	
	for i in range(6):
	
		#Plotter barplot fra simulerte data
		hist, xedges = np.histogram(data[:, pos[i]], bins = bins, range=(xmin, xmax));	#Hist: Hoyden til hver bar. Xedge: Posisjon 
		xcenter = (xedges[:-1] + xedges[1:])/2												#til kanten. xcenter: senterposisjon	
		ax.bar(xcenter,hist,align='center', zs = tt[i], zdir='y', alpha=0.8, width = xcenter[1] - xcenter[0])
		
		#Teoretisk kurve for frie partikkler
		x = linspace(min(data[:,pos[i]]),max(data[:,pos[i]]), Nt)
		n = N/(np.sqrt(4*np.pi*D1*tt[i])) * np.exp(-x**2/(4*D1*tt[i])) * (xcenter[1] - xcenter[0]);
		print(max(n))
		#ax.plot(x, n, tt[i], zdir='y')
		
		
	ax.set_xlim3d(min(xcenter), max(xcenter));
	ax.set_ylim3d(min(tt), max(tt));
    
	ax.set_title('Particle density without flashing potential')
	ax.set_xlabel('x/m')
	ax.set_ylabel('t/s')
	ax.set_zlabel('n')
	
	
#-----------------------------------------
#		plot_trajectory();
#-----------------------------------------
def plot_trajectory():
	
	y = linspace(0, Nt*dt, Nt/p)
	data = np.loadtxt('Npartikler.txt') #NxNt array
	
	plt.title('Trajectory')
	plt.ylabel('x')
	plt.xlabel('t')
	plt.plot(y, data[1,:]);


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

print('\n');
print("PROGRAM plotting: Begin")
print('\n');

[dU,tau,tid,t,dt,N,M,Nt,w,w2,D1, D2, p, L, a, eta, KbT, g1, g2, r1, r2] = read_constants()
scaling_factor = 10**6;

#plot_trajectory();
#plt.savefig('trajectoy.pdf')

#plt.figure
#plot_avgDriftVelocity()
#plt.savefig('avgDriftVelocity.pdf')

plt.figure();
plot_particledensity()
print('Saving....')
plt.savefig('particledensity.pdf')

stop = time.time()
print('\n');
print("PROGRAM plotting: end")
print("Plottime: %f seconds" %(stop-start))
print('\n');
#raw_input("Press enter to continue")
