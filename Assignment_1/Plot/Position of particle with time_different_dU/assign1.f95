
!####################################
!PROGRAM
!####################################

PROGRAM Oving3

use mprecision, only : wp;
use constants;
use generic_functions;
use specific_functions;
use random, only: random_normal;

!implicit none

	real(wp)			:: t = 0;
	real(wp)			:: x1(0:N);		!Position of particles
	real(wp)			:: x2(0:N);		!Position of particles
	real(wp)			:: x3(0:N);		!Position of particles
	real(wp)			:: U;			!Potential
	
 	
	integer, parameter				:: out_unit 	= 20;
 	CHARACTER (LEN=*), parameter	:: pos1 		= 'pos_NoFlash_du=0.1kbT.txt';	
 	CHARACTER (LEN=*), parameter	:: pos2			= 'pos_NoFlash_du=0.5kbT.txt';
 	CHARACTER (LEN=*), parameter	:: pos3		 	= 'pos_NoFlash_du=10kbT.txt';
 	CHARACTER (LEN=*), parameter	:: posn		 	= 'pos_potential.txt';
 	CHARACTER (LEN=*), parameter	:: time 		= 'time.txt';
	integer							:: i; 
	integer							:: j; 
	real(wp)						:: test(0:N);
	
	CHARACTER (LEN=*), parameter	:: potential 		= 'potentialenergy.txt';
	integer, parameter				:: maxJ = 1;
	real(wp)						:: xn(0:N);		!Position of particles
	real(wp)						:: pot(0:N);
	real(wp)						:: ddt = 1;		!Dimensionless timestep
	real(wp)						:: check;
	
	call init_random_seed();
	
	!Plotter posisjon av en partikkel sfa tid med varierende potensial
	x1 = 0;
	dU = 0.01*kbT;
	w  = dU/(g1*L**2)
	t = 3*tau*w/4
	ddt = dt*w !gjør dt dimensjonsløs
	
	!Sjekker om tidssteget er lite nok.
	timecheck = 5*dt*w+4*sqrt(2*kbT*dt*w/dU)
	if (timecheck > a) then
		write(*,*) 'FAIL1'
	endif
	
	do i = 1,N
			x1(i) = updatePos(x1(i-1),t, ddt);
	enddo
	call toFile(x1,N, pos1)
	
	x2 = 0;
	dU = 0.5_wp*kbT;
	w  = dU/(g1*L**2)
	t = 3*tau*w/4
	ddt = dt*w
	
	timecheck = 5*dt*w+4*sqrt(2*kbT*dt*w/dU)
	if (timecheck > a) then
		write(*,*) 'FAIL2'
	endif
	
	do i = 1,N
			x2(i) = updatePos(x2(i-1),t, ddt);
	enddo
	call toFile(x2,N, pos2)
	
	x3 = 0;
	dU = 10*kbT;
	w  = dU/(g1*L**2)
	t = 3*tau*w/4
	ddt = dt*w
	
	timecheck = 5*ddt+4*sqrt(2*kbT*ddt/dU)
	
	if (timecheck > a) then
		write(*,*) 'FAIL3'
	endif

	!t = 0;
	do i = 1,N
			!t = t+ddt;
			x3(i) = updatePos(x3(i-1),t, ddt);
	enddo
	call toFile(x3,N, pos3)
	
	
	
	!Skal teste om okkupert potensiell energi er boltzmann-fordelt.
	
	xn = 0;
	dU = 10*kbT;
	w  = dU/(g1*L**2)
	ddt = dt*w
	t = 3*tau*w/4
	
	timecheck = 5*ddt+4*sqrt(2*kbT*ddt/dU)
	if (timecheck > a) then
		write(*,*) 'FAIL4'
	endif
	
	do i = 1,N
		xn(i) = updatePos(xn(i-1),t, ddt);
		pot(i) = V(xn(i),t);
	enddo
	
	call toFile(pot, N, potential);
	call toFile(xn, N, posn);
	
	
	!x1 = 0;
	!x1 = gaussianlist(N);
	!call tofile('random.txt')
 	
END PROGRAM Oving3
