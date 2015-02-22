
MODULE specific_functions
	use mprecision, only : wp;
	use constants;
	use generic_functions;
	
	CONTAINS
	
	
	
	!-------------------------
	!Potential V
	!-------------------------
	FUNCTION V(x,t) result(U)
		real(wp)	:: t;
		real(wp)	:: tt;
		real(wp)	:: x;
		real(wp)	:: xt;
		real(wp)	:: U;
		
		!Implements periodicity
		xt = mod(x,a)
		tt = mod(t,tau*w)
	
		IF( tt >= 0 .and. tt< 3*tau*w/4) then
			U = 0;
		ELSE IF ( tt >= 3*tau*w/4 .and. tt < tau*w) then
			
			if( xt >= 0 .and. xt<a) then
				U = xt/a;
			else if ( xt >= a .and. xt < 1) then
				U = (1-xt)/(1-a);;
			endif
		ENDIF
	
	END FUNCTION V
	
	
	!-------------------------
	!Force F on a particle = -del(V)
	!-------------------------
	FUNCTION F(x,t) result(Q)
		real(wp)		:: t;
		real(wp)		:: tt;
		real(wp)		:: x;
		real(wp)		:: xt;
		real(wp)		:: Q;
		
		!Implements periodicity
		xt = x - floor(x);
		tt = t - floor(t);
		
		IF( tt >= 0 .and. tt< 3*tau*w/4) then
			Q = 0;
			
		ELSE IF ( tt >= 3*tau*w/4 .and. tt < tau*w) then
			if( xt >= 0 .and. xt<a) then
				Q = -1/a;
			else if ( xt >= a .and. xt < 1) then
				Q = 1/(1-a);
			endif
		ENDIF
	END FUNCTION F
	
	
	!-------------------------
	!Euler scheme
	!-------------------------
	! One iteration
	! Ta inn array value
	FUNCTION updatePos(x_1,t) result(x_2)
		real(wp)		:: x_1;
		real(wp)		:: x_2;
		real(wp)		:: t;
		
		x_2 = x_1 - F(x_1,t)*dt + sqrt(2*kbT*dt/dU) * random_normal();		
	
	END FUNCTION updatePos
  
END MODULE specific_functions
