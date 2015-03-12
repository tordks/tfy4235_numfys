MODULE m_precision
  ! defines standard precision 
  

  ! --- single
  integer, parameter :: sp  = kind(1.0)
  ! --- double
  integer, parameter :: dp  = kind(1.0d0)
  
  ! --- working precision 
  integer, parameter :: wp  = sp
  
end module m_precision

! -----
! -----
! -----

MODULE constants

END MODULE

! -----
! -----
! -----

MODULE functions

use m_precision;
use constants;

CONTAINS

!-----
! Printer et Array med n elementer.
  SUBROUTINE printList(toPrint, n)
	implicit none
	
	integer , intent(in) :: n;
	integer , intent(in) :: toPrint(0:n);
    integer :: i;
	
	do i = 0, n
		if (i>n) then
			exit;
		else
			write (*,*) toPrint(i);
		end if
	enddo

  END  SUBROUTINE

!-----

! -----
!Converts an integer to bit form
SUBROUTINE intToBit(inn, ut)

	integer, intent(in)  	:: inn;
	integer, intent(out) 	:: ut(0:31);
	integer 				:: rest;
	i = 31;
	
	rest = inn;
	
	do while( rest > 0)
	ut(i) = MOD(rest,2);
	rest = rest/2;
	i = i-1;
	enddo
	
END SUBROUTINE intToBit

! -----
!Converts a single precision number to bit form;
SUBROUTINE realToBit(inn, ut)
	! inn = (s,m,e)
	
	real, intent(in)  		:: inn;
	integer, intent(out) 	:: ut(0:31);
	
	real 					:: num;
	real					:: dec;
	integer					:: neg;
	
	IF (inn < 0) THEN
		neg = 1;
	ELSE 
		neg = 0;
	ENDIF
	
	num = floor(inn);
	dec = inn - num;
	
	write(*,*) inn, num, dec, num+dec;

END SUBROUTINE realToBit

END MODULE functions


! -----
! -----
! -----

PROGRAM Oving2

	use m_precision, only : wp;
	use constants;
	use functions;

	integer :: intBit(0:31) = 0;  !array med 32 elementer for å lagre bitsekvensen til et heltall;
	integer :: spBit(0:31)  = 0;  !array med 32 elementer for å lagre bitsekvensen til et single precision flyttall;
	integer :: dpBit(0:61)  = 0;  !array med 62 elementer for å lagre bitsekvensen til et double precision flyttall;

	integer :: a = 53;
	real	:: b = 20.751234567;
	
	!converting an int to bitform
	!call intToBit(a, intBit);
	!call printList(intBit, 32);
	
	call realToBit(b,spBit);


END PROGRAM Oving2
