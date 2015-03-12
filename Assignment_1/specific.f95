
MODULE specific_functions
	use mprecision, only : wp;
	use constants;
	use generic_functions;
	
	CONTAINS
	
	
	
	!-------------------------
	!Potential V
	!-------------------------
	FUNCTION V(x,t,ww) result(U)
		real(wp)	:: t;
		real(wp)	:: ww;
		real(wp)	:: tt;
		real(wp)	:: x;
		real(wp)	:: xt;
		real(wp)	:: U;
		
		!Implements periodicity
		xt = dmod(x,1.0_wp);
		
		!Pga potensialet ikke symmetrisk om origo. Plusser på perioden for å få xt positiv.
		if(xt < 0) then
			xt = xt+1;
		endif
		
		tt = mod(t,tau*ww)
		
		IF( tt >= 0.0_wp .and. tt< 3.0_wp*tau*ww/4.0_wp) then
			U = 0.0_wp;
		ELSE IF ( tt >= 3.0_wp*tau*ww/4.0_wp .and. tt < tau*ww) then
			
			if( xt >= 0.0_wp .and. xt<a) then
				U = xt/a;
			else if ( xt >= a .and. xt < 1.0_wp) then
				U = (1.0_wp-xt)/(1.0_wp-a);
			endif
		ENDIF
	
	END FUNCTION V
	
	
	!-------------------------
	!Force F on a particle = -del(V)
	!-------------------------
	FUNCTION F(x,t, ww) result(Q)
		real(wp)		:: ww;
		real(wp)		:: t;
		real(wp)		:: tt;
		real(wp)		:: x;
		real(wp)		:: xt;
		real(wp)		:: Q;
		
		!Implements periodicity
		xt = dmod(x,1.0_wp);
		tt = mod(t,tau*ww)
		
		!Pga potensialet ikke symmetrisk om origo. Plusser på perioden for å få xt positiv.
		if(xt < 0) then
			xt = xt+1;
		endif
		
		IF( tt >= 0 .and. tt< 3*tau*ww/4) then
			Q = 0;
			!write(*,*) 'fail'
			
		ELSE IF ( tt >= 3.0_wp*tau*ww/4.0_wp .and. tt < tau*ww) then
			if( xt >= 0 .and. xt<a) then
				Q = -1/a;
			else if ( xt >= a .and. xt < 1.0_wp) then
				Q = 1/(1-a);
			endif
		ENDIF
	END FUNCTION F
	
	
	!-------------------------
	!Euler scheme
	!-------------------------

	FUNCTION updatePos(x_1,t, ww, dtt) result(x_2)
		real(wp)		:: ww;
		real(wp)		:: dtt;
		real(wp)		:: x_1;
		real(wp)		:: x_2;
		real(wp)		:: t;
		
		x_2 = x_1 + F(x_1,t, ww)*dtt + sqrt(2*kbT*dtt/dU) * random_normal();
	
	END FUNCTION updatePos
	
	SUBROUTINE check()
		write(*,*) ''
	END SUBROUTINE check
	
	
	
END MODULE specific_functions
