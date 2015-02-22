
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
	
	integer, parameter	:: N = 200;		!N+1 = number of particles
	real(wp)			:: t = 0;	
	real(wp)			:: x1(0:N);		!Position of particles
	real(wp)			:: x2(0:N);		!Position of particles
	real(wp)			:: U;			!Potential
 	
	integer, parameter				:: out_unit 	= 20;
 	CHARACTER (LEN=*), parameter	:: testing 		= 'test.txt';
 	CHARACTER (LEN=*), parameter	:: pos1 		= 'pos_NoFlash_du=0.1kbT.txt';	
 	CHARACTER (LEN=*), parameter	:: pos2			= 'pos_NoFlash_du=10kbT.txt';
 	CHARACTER (LEN=*), parameter	:: pos3		 	= 'pos_NoFlash_du=1000kbT.txt';
 	CHARACTER (LEN=*), parameter	:: time 		= 'time.txt';
 	
 	
 	
 	
 	
 	
 	
 	!------------
 	! Til testing
 	!------------
	real(wp)						:: test(0:N);
	integer							:: i; 
	integer							:: j; 
	real(wp)			:: x3(0:N);		!Endposition of N particles
	real(wp)			:: x4(0:N);		!Endposition of N particles
	real(wp)			:: x5(0:N);		!Endposition of N particles
	real(wp) :: std; 	!for testing av random
 	real(wp) :: d;		!for testing av random
	
	call init_random_seed();
	
	!Vil teste om partikkelen er fordelt etter boltzmannfordelingen. Vil ha en
	!mengde partikler som jeg plotter posisjonen til.
 	
 	
 	!-------------------
 	!Tester random_normal
 	!-------------------

 	!test = gaussianList(N);
 	!call toFile(test, N, 'randomtest.txt');
 	
 	!d = sum(test)/(N+1_wp);
 	!do i = 0, N
 	!	std = std + (test(i) - d)**2;
 	!enddo
 	!std = sqrt(std/N)
 	!write(*,*) d;		!Får typisk 1E-2
 	!write(*,*) std;		!Får typisk 0.99
 	
 	
 	

 	
END PROGRAM Oving3
