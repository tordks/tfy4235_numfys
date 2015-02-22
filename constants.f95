!####################################
!Constants
!####################################

MODULE constants
	 use mprecision, only : wp;
	 real(wp), parameter	::	pi		= 3.14159265359! 4_wp*atan(1_wp);
	 real(wp), parameter	::	kbT		= 26E-3;
	 
	 real(wp), parameter 	::  m1 		= 5;
	 real(wp), parameter	::	m2 		= 100;
	 real(wp), parameter	::	r1 		= 12E-9;
	 real(wp), parameter	::	r2 		= 12E-9;
	 real(wp), parameter	::	g1		= 6 * pi * 0.001*r1;	!gamma i oppgaveteksten
	 real(wp), parameter	::	g2		= 6 * pi * 0.001*r2;	!gamma i oppgaveteksten
	 real(wp), parameter	::	a		= 0.3;
	 real(wp), parameter	::	L		= 20E-6;
	 
	 real(wp), parameter	::  dU		=1000*kbT;
	 real(wp), parameter	::	tau		= 0.01;
	 real(wp), parameter	::	w		= 1;
	 real(wp), parameter	::	dt		= 0.05;  !MED dimensjon
	 
	 !real(wp)	::	D		= 0.026/dU; 
END MODULE constants
