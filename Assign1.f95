
!####################################
!PROGRAM
!####################################

PROGRAM Oving3

use m_precision, only : wp;
use constants;
use generic_functions;
use specific_functions;

implicit none

	integer, parameter	:: N = 1000;		!N+1 = number of particles
	real(wp)			:: t = 0.05;	
	real(wp)			:: x(0:N);		!Position of particles
	real(wp)			:: U;			!Potential
	
	integer, parameter 				:: out_unit = 20;
 	CHARACTER (LEN=*), PARAMETER 	:: filename = 'results.txt';
 	
 	real(wp)						:: test  	= 1.0_wp;
	real(wp)						:: test2;
	integer							:: i;
 	
 	
 	call init_random_seed();
 	
 	!write(*,*) PSI(1_wp);
 		
 	
 	test = 100_wp;
 	do  i = 0, N
 		test = updatePos(test, t);
 	enddo
 	!write(*,*) test;
 	
 	
 	
 	
END PROGRAM Oving3
