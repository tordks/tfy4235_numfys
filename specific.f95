!####################################
!Constants
!####################################

MODULE constants
	 use m_precision, only : wp;
	 
	 real(wp) 	::  m1 		= 5;
	 real(wp)	::	m2 		= 100;
	 real(wp)	::	r1 		= 12**(-9);
	 real(wp)	::	r2 		= 0.000000012;
	 
	 real(wp)	::	L		= 20**(-6);
	 real(wp)	::  dU		= 80;
	 real(wp)	::	a		= 0.2;
	 real(wp)	::	tau		= 0.1;
	 real(wp)	::	J		= 0.001	!gamma in exercise
	 real(wp)	::	w		= 1;
	 real(wp)	::	dt		= 0.1;
	 
	 !real(wp)	::	D		= 0.026/dU;
	 
	 
END MODULE constants

!####################################
!Specific functions
!####################################

MODULE specific_functions
	use m_precision, only : wp;
	use constants;
	use generic_functions;
	
	CONTAINS
	
	
	
	!-------------------------
	!Potential V
	!-------------------------
	FUNCTION V(x,t) result(U)
		real(wp), intent(in)	:: t;
		real(wp), intent(in)	:: x;
		real(wp)				:: U;
	
		IF( t >= 0 .and. t< 3*tau*w/4) then
			U = 0;
		ELSE IF ( t >= 3*tau*w/4 .and. t < tau*w) then
			
			if( x >= 0 .and. x<a) then
				U = x/a;
			else if ( x >= a .and. x < 1) then
				U = (1-x)/(1-a);
			else
				write(*,*) 'x out of bounds';
			endif
		ELSE
			write(*,*) 't out of bounds';
		ENDIF
	
	END FUNCTION V
	
	
	!-------------------------
	!Force F on a particle = -del(V)
	!-------------------------
	FUNCTION F(x,t) result(Q)
		real(wp)		:: t;
		real(wp)		:: x;
		real(wp)		:: Q;
		
		IF( t >= 0 .and. t< 3*tau*w/4) then
			Q = 0;
		ELSE IF ( t >= 3*tau*w/4 .and. t < tau*w) then
			
			if( x >= 0 .and. x<a) then
				Q = -1/a;
			else if ( x >= a .and. x < 1) then
				Q = 1/(1-a);
			else
				write(*,*) 'x out of bounds';
			endif
		ELSE
			write(*,*) 't out of bounds';
		ENDIF
	
	
	END FUNCTION F
	
	
	!-------------------------
	!Euler scheme
	!-------------------------
	! One iteration
	
	FUNCTION updatePos(x1,t) result(x2)
		real(wp)		:: x1;
		real(wp)		:: x2;
		real(wp)		:: t;
		
		x2 = x1 - F(x1,t)*dt + sqrt(2*0.026*dt/dU) * gaussian();		
	
	END FUNCTION updatePos
  
END MODULE specific_functions
