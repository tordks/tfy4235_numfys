
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
 	CHARACTER (LEN=*), parameter			:: posn_info	= 'Npartikler_info.txt';
 	CHARACTER (LEN=*), parameter			:: drift		= 'AvgDriftvelocity.txt';
 	CHARACTER (LEN=*), parameter			:: const 	 	= 'constants.txt';
	integer									:: i; 
	integer									:: j;
	integer									:: k;
	real(wp), dimension(0:N-1, 0:Nt-1)		:: xn;			!Position of particles [1]
	real(wp)								:: vd(0:N-1);	!Drift Velocity	[1]
	real(wp), dimension(0:2,0:M-1)			:: avgvd;!Avarege Vd med  tau og std.
	real(wp)								:: tauArr(0:M-1);
	real(wp)								:: std_Vd;
	real(wp)								:: consts(0:7)
	real(wp)								:: timecheck;
	real(wp) :: start, start2, finish, finish2
	
	call cpu_time(start)
	write(*,*) 'PROGRAM Assignment1: Begin'
	call init_random_seed();
	
	!-----------------------------------------
	!-----------------------------------------
	!Vil finne optimal drifthastighet sfa tau
	!-----------------------------------------
	!-----------------------------------------
	
	!Sjekker om tidssteget er lite nok.
	!MÅ REVIDERES
	timecheck = 5*dt*w+4*sqrt(2*kbT*dt*w/dU)

	if (timecheck > a) then
		write(*,*) 'ddt FAIL'
	else		
		avgvd = 0;
		do j = 0, M-1
			tauArr(j) = real(j,wp)*0.01_wp
		enddo
	
		do k = 0, M-1
	
		!--------------------
		!Lager en matrise med N partikler over Nt tidssteg
		!--------------------
	
			xn = 0;
			tau = tauarr(k);
	
			do j = 0,N-1
				t = 0;
				do i = 1,Nt-1
					t = t + ddt;
					xn(j,i) = updatePos(xn(j, i-1),t,w);
				enddo
			enddo
	
		!--------------------
		!Finner gjennomsnittlig driftshastighet.
		!--------------------
		
			vd = 0;
			do j = 0,N-1
				vd(j) = xn(j,Nt-1)*L / (t/w); !Gjør farten "dimensjonsfull"
			enddo
	
			avgvd(0,k) = tauArr(k);
			avgvd(1,k) = sum(Vd)/N;
			
			std_Vd = 0;
			do j =0, N-1
				std_Vd = std_Vd + (avgvd(1,k) - vd(j))**2
			enddo
			std_Vd = sqrt(std_Vd/(N))
			avgvd(2,k) = std_vd;
			
			
			write(*,*) k;
		enddo
		
		consts = [dU,tau,tid,dt,real(N,wp),real(M,wp), real(Nt,wp), w];
		
		call cpu_time(start2)
		call tofile(avgvd,3,M,drift,1);
		call tofile(consts,8,1, const,1);
		!call toFile(xn,N,Nt, posn,1);	
		call cpu_time(finish2)
		print '("Saving used = ",f10.3," seconds.")', (finish2-start2)

	endif
	
write(*,*) 'PROGRAM Assignment1: end';
call cpu_time(finish);
print '("Program used = ",f10.3," seconds.")', (finish-start)
END PROGRAM Assignment1
