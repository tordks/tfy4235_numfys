!####################################
!Generic functions
!####################################
MODULE generic_functions
use constants
use mprecision, only : wp;
use random, only : random_normal;
CONTAINS

	!------------------------------------
	!random seed
	!------------------------------------
!Code taken from:
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

	!------------------------------------
	!toFile
	!------------------------------------
	
	!Name of outfile in plot.
	!Number of elements.
	!Array elements.
	SUBROUTINE toFile(array, n, filename)
		character(LEN=*), intent(in)	:: filename		
		real(wp), intent(in) 	:: array(0:n);
		integer , intent(in) 	:: n;
		integer 			 	:: i;	
		integer, parameter 		:: out_unit=20
	
		open (unit=out_unit,file=filename,action="write",status="replace")
		write(out_unit,*) filename;
		write(out_unit,*) n+1

	
		do i = 0, n
			if (i>n) then
				close (out_unit)
				exit;
			else
			write (out_unit,*) array(i);
			end if
		enddo
	
			close (out_unit)

	END  SUBROUTINE toFile

	!------------------------------------
	!randList
	!------------------------------------
	!Creates a uniform random list.
	SUBROUTINE randList(r,n)
		real(wp), intent(out) :: r(0:n);
		integer , intent(in) :: n;
		integer :: i;
	
		do i = 0, n
				call random_number(r(i));
		enddo

	END  SUBROUTINE
	
	!-------------------------
	!Gaussian random number (by polar Box-Müller)
	!-------------------------
	! Based on code from: http://www.design.caltech.edu/erik/Misc/Gaussian.html
	FUNCTION gaussian() result(g)
		real(wp)		::	x1, x2, w, y1, y2, g;
		integer			::	i;
		w = 2
		do while (w>=1.0)
			call random_number(x1);
			call random_number(x2);
			
			x1 = 2.0_wp * x1 - 1.0_wp;
			x2 = 2.0_wp * x2 - 1.0_wp;
			w = x1 * x1 + x2 * x2;
			
		end do
		w = sqrt( (-2.0_wp * log( w ) ) / w );
		g = x1 * w;
	
	END FUNCTION gaussian
	
	
	!-------------------------
	!Gaussian random number list
	!-------------------------
	FUNCTION gaussianList(n) result(gL)
		integer			::	n;
		real(wp)		::	gL(0:n);
		real(wp)		::	g(0:n);

		do i = 0, n
				g(i) = random_normal();
		enddo
		gL = g;
	END FUNCTION gaussianList

	!------------------------------------
	!printList
	!------------------------------------
	
  SUBROUTINE printList(toPrint, n)
	
	integer , intent(in) :: n;
	real(wp), intent(in) :: toPrint(0:n);
    integer :: i;
	
	do i = 0, n
		if (i>n) then
			exit;
		else
			write (*,*) toPrint(i);
		end if
	enddo
	write(*,*) ''
  END  SUBROUTINE 
 
  
END MODULE generic_functions
