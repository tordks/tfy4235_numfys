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
MODULE constants
 INTEGER,parameter  			:: populationSize = 64;
 INTEGER, parameter  			:: generations = 4000;
 integer, parameter 			:: out_unit=20
 CHARACTER (LEN=*), PARAMETER 	:: filename = 'results.txt'; 

END MODULE

!-----

MODULE functions

use m_precision, only : wp;
use constants;

CONTAINS

!-----
!Seeder randomgeneratoren.
!https://gcc.gnu.org/onlinedocs/gcc-4.9.1/gfortran/RANDOM_005fSEED.html
SUBROUTINE init_random_seed()
	use iso_fortran_env, only: int64
	implicit none
	integer, allocatable :: seed(:)
	integer :: i, n, un, istat, dt(8), pid
	integer(int64) :: t

	call random_seed(size = n)
	allocate(seed(n))
	! First try if the OS provides a random number generator
	open(newunit=un, file="/dev/urandom", access="stream", &
		 form="unformatted", action="read", status="old", iostat=istat)
	if (istat == 0) then
	   read(un) seed
	   close(un)
	else
	   ! Fallback to XOR:ing the current time and pid. The PID is
	   ! useful in case one launches multiple instances of the same
	   ! program in parallel.
	   call system_clock(t)
	   if (t == 0) then
		  call date_and_time(values=dt)
		  t = (dt(1) - 1970) * 365_int64 * 24 * 60 * 60 * 1000 &
		       + dt(2) * 31_int64 * 24 * 60 * 60 * 1000 &
		       + dt(3) * 24_int64 * 60 * 60 * 1000 &
		       + dt(5) * 60 * 60 * 1000 &
		       + dt(6) * 60 * 1000 + dt(7) * 1000 &
		       + dt(8)
	   end if
	   pid = getpid()
	   t = ieor(t, int(pid, kind(t)))
	   do i = 1, n
		  seed(i) = lcg(t)
	   end do
	end if
	call random_seed(put=seed)
	contains
	! This simple PRNG might not be good enough for real work, but is
	! sufficient for seeding a better PRNG.
	function lcg(s)
	  integer :: lcg
	  integer(int64) :: s
	  if (s == 0) then
		 s = 104729
	  else
		 s = mod(s, 4294967296_int64)
	  end if
	  s = mod(s * 279470273_int64, 4294967291_int64)
	  lcg = int(mod(s, int(huge(0), int64)), kind(0))
	end function lcg
	end subroutine init_random_seed

!-----
!First line is size of array.
!The rest the elements.
!SUBROUTINE toFile(array, n)
!	implicit none
!	integer, intent(in) :: array(0:populationSize);
!	integer , intent(in) :: n;
!	integer :: i;
!	integer, parameter :: out_unit=20
!	
!	open (unit=out_unit,file='results.txt',action="write",status="replace")
!	write(out_unit,*) generations
!
!	
!	do i = 0, n
!		if (i>n) then
!			close (out_unit)
!			exit;
!		else
!			write (out_unit,*) array(i);
!		end if
!	enddo
!	
!		close (out_unit)
!
!END  SUBROUTINE toFile

!-----

SUBROUTINE randList(r,n)
	implicit none
	real(wp), intent(out) :: r(0:populationSize);
	integer , intent(in) :: n;
	integer :: i;
	
	call init_random_seed();
	do i = 0, n
		if (i>n) then
			exit;
		else
			call random_number(r(i));
		end if
	enddo

END  SUBROUTINE

!-----
! Printer et Array med n elementer.
  SUBROUTINE printList(toPrint, n)
	implicit none
	
	integer , intent(in) :: n;
	integer, intent(in) :: toPrint(0:populationSize);
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
! Finner minste element i et array og gir det en ny tilfeldig verdi. Gir også naboelementene en ny verdi. Periodiske betingelser.
  SUBROUTINE update(population, populationSize, i)
	
	implicit none
	REAL(wp), intent(inout) :: population(0:populationSize);
	integer, intent(in) :: populationSize;
	integer :: minLocation;
	integer, intent(in) :: i;
	
	open (unit=out_unit,file="results.txt",action="write", position = 'append')
	minLocation = MINLOC(population, 1) - 1;
	write(out_unit,*) minLocation
	close (out_unit)
	
	IF (minLocation == 0) THEN
		call random_number(population(populationSize));
		call random_number(population(minLocation));
		call random_number(population(minLocation +1));			
		
	ELSE IF (minLocation == populationSize) THEN
		call random_number(population(minLocation-1));
		call random_number(population(minLocation));
		call random_number(population(0));
		!write (*,*) ' TEST: Hvor stort er arrayet som lages av population(0:populationSize). Skal minLoc == populationSize i if?
		
	ELSE
		call random_number(population(minLocation-1));
		call random_number(population(minLocation));
		call random_number(population(minLocation +1));
	ENDIF
	
	
			
  END SUBROUTINE

END MODULE functions


! -----
! -----
! -----

PROGRAM Oving1

use m_precision, only : wp;
use constants;
use functions;

implicit none
	REAL(wp) :: population(0:populationSize);		!Inneholder hele populasjonen
	REAL(wp) :: initialPopulation(0:populationSize);	!Startpopulasjon
	integer  :: i; !Iterasjonsvariabel

	call randList(initialPopulation,populationSize);
	population = initialPopulation;
	
	open (unit=out_unit,file='results.txt',action="write", position = 'append')
	write(out_unit,*) generations
	close (out_unit)

	do i = 0,generations,1
		call update(population, populationSize, i);
	enddo
	write(*,*) i 

	

	!TODO:
	!Skriv alle posisjonene til et array istedenfor å printe et og et...


END PROGRAM Oving1
