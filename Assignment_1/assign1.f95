
!####################################
!PROGRAM
!####################################

PROGRAM Assignment1

use mprecision, only : wp;
use constants;
use generic_functions;
use specific_functions;
use random, only: random_normal;
implicit none

	real(wp)								:: t = 0;
	integer, parameter						:: out_unit 	= 20;
 	CHARACTER (LEN=*), parameter			:: posn		 	= 'Npartikler.txt';
 	CHARACTER (LEN=*), parameter			:: posm		 	= 'Npartikler2.txt';
 	CHARACTER (LEN=*), parameter			:: drift		= 'AvgDriftvelocity.txt';
 	CHARACTER (LEN=*), parameter			:: const 	 	= 'constants.txt';
	integer									:: i; 
	integer									:: j;
	integer									:: k;
	real(wp), dimension(0:N-1, 0:Nt-1)		:: xn;			!Position of particles [1]
	real(wp), dimension(0:N-1, 0:Nt-1)			:: xm;			!Position of particle [1]
	real(wp)								:: tauArr(0:M-1);
	real(wp)								:: consts(0:num_consts-1)
	real(wp)								:: timecheck;
	real :: start, finish
	
	call cpu_time(start)
	write(*,*) 'PROGRAM Assignment1: Begin'
	call init_random_seed();
	
	!-----------------------------------------------------------
	!-----------------------------------------------------------
	!Vil simulere to partikler i potensialet og plotte tettheten
	!-----------------------------------------------------------
	!-----------------------------------------------------------
	
	!Sjekker om tidssteget er lite nok.
	timecheck = 5*dt*w+4*sqrt(2*kbT*dt*w/dU)

	if (timecheck > a) then
		write(*,*) 'ddt FAIL'
	else		
		do k = 0, M-1
	
			!--------------------
			!Lager en matrise med N partikler over Nt tidssteg
			!--------------------
			
			!Bør finne en metode å gå lengre i tid og lagre færre verdier.
			!	- Lage en 1x2 vektor som inneholder de to nyeste verdiene og at xn kun lagrer hver andre verdi feks.
			
			xn = 0
			t = 0
			
			do i = 0, N-1
				do j = 1,Nt-1
					t = t + ddt;
					xn(i,j) = updatePos(xn(i, j-1),t,w, ddt);
				enddo
			enddo
			
			
		write(*,*) k
		enddo
		xn = xn;
		consts = [dU,tau,tid,t,dt,real(N,wp),real(M,wp), real(Nt,wp), w, w2, D1, D2, real(p,wp), real(time(),wp)];
		call tofile(consts,num_consts,1, const,1);
		call toFile(xn,N,Nt, posn,p);
	endif
	
write(*,*) 'PROGRAM Assignment1: end';
call cpu_time(finish);
print '("Time used = ",f10.3," seconds.")', (finish-start)
END PROGRAM Assignment1
