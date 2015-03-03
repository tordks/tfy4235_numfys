!####################################
!Constants
!####################################

MODULE constants
	 use mprecision, only : wp;
	 real(wp), parameter	::	pi		= 3.141592653589793238! 4_wp*atan(1_wp);
	 real(wp), parameter	::	kbT		= 0.026 * 1.602176565E-19; ![J]
	 
	 real(wp), parameter 	::  m1 		= 5;
	 real(wp), parameter	::	m2 		= 100;
	 real(wp), parameter	::	r1 		= 12E-9;
	 real(wp), parameter	::	r2 		= 12E-9;
	 real(wp), parameter	::	eta		= 0.001
	 real(wp), parameter	::	g1		= 6 * pi * eta*r1;	!gamma i oppgaveteksten
	 real(wp), parameter	::	g2		= 6 * pi * eta*r2;	!gamma i oppgaveteksten
	 real(wp), parameter	::	a		= 0.2;
	 real(wp), parameter	::	L		= 20E-6;
	 
	 real(wp)	::  dU		= 10*kbT;
	 !real(wp), parameter	::	D		= kbT/dU; 
	 real(wp), parameter	::	tau		= 1;
	 real(wp)				::	w		= 10*kbT/(g1*L**2);
	 
	 real(wp), parameter		::  tid		= 20![s] 	!Kjøretid
	 real(wp), parameter		::	dt		= 0.001![s]	!tidssteg
	 integer, parameter			:: 	N		= floor(tid/dt);
	 
END MODULE constants
