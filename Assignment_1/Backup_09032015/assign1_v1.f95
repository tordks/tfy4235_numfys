
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
	real(wp)			:: dt1 = 0;
	real(wp)			:: dt2 = 0;	
	real(wp)			:: dt3 = 0;	
	real(wp)			:: x1(0:N);		!Position of particles
	real(wp)			:: x2(0:N);		!Position of particles
	real(wp)			:: x3(0:N);		!Position of particles
	real(wp)			:: U;			!Potential
 	
	integer, parameter				:: out_unit 	= 20;
 	CHARACTER (LEN=*), parameter	:: pos1 		= 'pos_NoFlash_du=0.1kbT.txt';	
 	CHARACTER (LEN=*), parameter	:: pos2			= 'pos_NoFlash_du=0.5kbT.txt';
 	CHARACTER (LEN=*), parameter	:: pos3		 	= 'pos_NoFlash_du=10kbT.txt';
 	CHARACTER (LEN=*), parameter	:: time 		= 'time.txt';
	integer							:: i; 
	integer							:: j; 
	real(wp)						:: test(0:N);
	
	CHARACTER (LEN=*), parameter	:: potential 		= 'potentialenergy.txt';
	integer, parameter				:: maxJ = 1;
	real(wp)						:: xn(0:N*maxJ);		!Position of particles
	real(wp)						:: pot(0:N*maxJ);
	real(wp)						:: d;

	
	call init_random_seed();
	
	!Plotter posisjon av en partikkel sfa tid med varierende potensial
	x1 = 0;
	dU = 0.1*kbT;
	w  = dU/(g1*L**2)
	t = 3*tau*w/4
	!dt = dt*w;
	do i = 1,N
			x1(i) = updatePos(x1(i-1),t);
	enddo
	call toFile(x1,N, pos1)
	
	x2 = 0;
	dU = 0.5_wp*kbT;
	w  = dU/(g1*L**2)
	t = 3*tau*w/4
	!dt = dt*w;
	do i = 1,N
			x2(i) = updatePos(x2(i-1),t);
	enddo
	call toFile(x2,N, pos2)
	
	x3 = 0;
	dU = 10*kbT;
	w  = dU/(g1*L**2)
	t = 3*tau*w/4
	!dt = dt*w;
	do i = 1,N
			x3(i) = updatePos(x3(i-1),t);
	enddo
	call toFile(x3,N, pos3)
	
	
	
	!Skal teste om okkupert potensiell energi er boltzmann-fordelt.
	
	xn = 0;
	dU = 10*kbT;
	w  = dU/(g1*L**2)
	t = 3*tau*w/4
	
	!Lager et array med posisjonen til flere partikler. MaxJ betegner antall partikler. 3x3 matrise i 1xN*Jmax
	do j = 0,maxJ-1
		pot(j*N) = V(xn(j*N),t);
		do i = 1,N

			xn(j*N+i) = updatePos(xn(j*N+(i)),t);
			pot(j*N+i) = V(xn(j*N+i),t);
			!write(*,*) j*N+i
		enddo
		!write(*,*) j;
	enddo
	
	call toFile(xn,N, potential);	
	call toFile(pot, N, potential);
	
	
	!x1 = 0;
	!x1 = gaussianlist(N);
	!call tofile('random.txt')
 	
END PROGRAM Oving3
