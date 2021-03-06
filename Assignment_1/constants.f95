!####################################
!Constants
!####################################

MODULE constants
	 use mprecision, only : wp;
	 real(wp), parameter	::	pi		= 3.141592653589793238! 4_wp*atan(1_wp);
	 real(wp), parameter	::	kbT		= 0.026 * 1.602176565E-19; ![J]
	 real(wp), parameter 	::  m1 		= 5;![kg]
	 real(wp), parameter	::	m2 		= 100;![kg]
	 real(wp), parameter	::	r1 		= 12E-9;![m]
	 real(wp), parameter	::	r2 		= 3*r1;![m]
	 real(wp), parameter	::	eta		= 0.001
	 real(wp), parameter	::	g1		= 6 * pi * eta*r1;	!gamma i oppgaveteksten
	 real(wp), parameter	::	g2		= 6 * pi * eta*r2;	!gamma i oppgaveteksten
	 real(wp), parameter	::	a		= 0.2;![1]
	 real(wp), parameter	::	L		= 20E-6;![m]
	 
	 real(wp), parameter	::  dU		= 80 * 1.602176565E-19;![J]
	 real(wp), parameter 	::	tau		= 0.51;![s] Gjøres dimensjonsløs i F og V
	 real(wp), parameter	::  tid		= 100![s] 	!Kjøretid
	 real(wp), parameter	::	dt		= 0.0001![s]	!tidssteg
	 integer, parameter		::	N		= 1200;		 !Antall partikkler
	 integer, parameter		::  M		= 1;		 !Antall ganger programmet kjøres. (# tau)
	 integer, parameter		:: 	Nt		= floor(tid/dt); !Antall tidssteg
	 real(wp), parameter	::	w		= dU/(g1*L**2);! [1/s]
	 real(wp), parameter	::	w2		= dU/(g2*L**2);
	 real(wp), parameter	::  ddt		= dt*w;![1]
	 real(wp), parameter	::  ddt2	= dt*w2;![1]
	 real(wp), parameter	::  D1		= kbT/g1;
	 real(wp), parameter	::  D2		= kbT/g1;
	 integer, parameter		::	p 		= 500!perioden til elementene som lagres til fil feks. p=2, A = [0,1,2,3,4,5,6,7,8] gjør at [0,2,4,6,8] skrives til fil.
	 
	 integer, parameter		:: num_consts = 21 ! # of consts to be plotted.
	 
END MODULE constants
