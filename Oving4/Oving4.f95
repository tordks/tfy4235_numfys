MODULE m_precision
  ! defines standard precision 
  

  ! --- single
  integer, parameter :: sp  = kind(1.0)
  ! --- double
  integer, parameter :: dp  = kind(1.0d0)
  
  ! --- working precision 
  integer, parameter :: wp  = dp
  
end module m_precision

! -----
MODULE constants
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
!	integer, intent(in) :: array(0:n);
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
	real(wp), intent(out) :: r(0:n);
	integer , intent(in) :: n;
	integer :: i;
	
	call init_random_seed();
	do i = 0, n
			call random_number(r(i));
	enddo

END  SUBROUTINE

!-----
! Printer et Array med n elementer.
  SUBROUTINE printList(toPrint, n)
	implicit none
	
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
 
  
	!------------------------------------
	!Jacobi method
	!------------------------------------
	
    SUBROUTINE Jacobi(A,x,b,n,error,cond)
	implicit none
	
	integer , intent(in) 	::	n;
	real(wp), intent(in)	::	error;
	real(wp), intent(in)	::	cond(0:n);
	real(wp), intent(in) ::	A(0:n,0:n);
	real(wp), intent(in)	::	b(0:n);
	real(wp), intent(inout)	::	x(0:n);
	
	real(wp)::	xnew(0:n);
	real(wp)::	D(0:n,0:n);
	real(wp)::	L(0:n,0:n);
	real(wp)::	U(0:n,0:n);
	
    integer :: i;
    integer :: j;
	
	xnew = x;
	do i = 0, 200000
		
		do j = 1, n-1
			xnew(j) = ((1 / (A(j,j)))*(b(j) + cond(j-1)*x(j-1) + cond(j)*x(j+1)))
		enddo!j
		
		if ( abs(sum(x - xnew)) < error ) then
			write(*,*) 'J iterations: '
			write(*,*) i;
			exit;
		endif;
		x = xnew;
		
	enddo!i
	
	
	END  SUBROUTINE
	
	!------------------------------------
	!Gauss-Seidel method
	!------------------------------------
	
    SUBROUTINE GaussSeidel(A,x,b,n,error,cond)
	implicit none
	
	integer , intent(in) 	::	n;
	real(wp), intent(in)	::	error;
	real(wp), intent(in)	::	cond(0:n);
	real(wp), intent(in) 	::	A(0:n,0:n);
	real(wp), intent(in)	::	b(0:n);
	real(wp), intent(inout)	::	x(0:n);
	
	real(wp)::	D(0:n,0:n);
	real(wp)::	L(0:n,0:n);
	real(wp)::	U(0:n,0:n);
	real(wp)::	xpast(0:n);
	
    integer :: i;
    integer :: j;
	
	do i = 0, 200000
		xpast = x;
		do j = 1, n-1
			x(j) = ((1 / (A(j,j)))*(b(j) + cond(j-1)*x(j-1) + cond(j)*x(j+1)))
		enddo!j
		
		if ( abs(sum(xpast - x)) < error ) then
			write(*,*) 'GS iterations: '
			write(*,*) i;
			exit;
		endif;		
	enddo!i
	
	END  SUBROUTINE

END MODULE functions


! -----
! -----
! -----

PROGRAM Oving3

use m_precision, only : wp;
use constants;
use functions;

implicit none
	integer, parameter		:: N = 1000;
	!real(wp) 				:: resistors(0:N-1); !# of resistors = N
	real(wp)				:: cond(0:N-1) !conductance
	real(wp)				:: V(0:N); !# of voltages = N+1
	real(wp)				:: V_0 = 1.0;
	real(wp)				:: V_N = 0.0;
	
	real(wp)				:: Pinv(0:N, 0:N);
	real(wp)				:: P(0:N, 0:N);
	real(wp)				:: A(0:N, 0:N);
	real(wp)				:: b(0:N);
	real(wp)				:: error;
	integer					:: r;
	integer					:: c;
	integer					:: ok;
	integer					:: pivot(0:N);
	
	
	!------------------------------------
	!Initializes all vectors and matrices
	!----------------------------------
	error = 1e-4;
	V = 0.5;
	V(0) = V_0;
	V(N) = V_N;
	!cond = (/0.2345,0.38337,0.131257,0.122235,0.99993,0.1234,0.8543, 0.78, 0.1952, 0.2789/); !J:227 , GS:14
	call randList(cond,N-1);
	!cond = 1/resistors;
	
	!write(*,*) '-----------------'
	!write(*,*) cond;
	!write(*,*) '-----------------'
	
	b = 0;
	b(0) = V_0;
	b(N) = V_N;
	
	A = 0;
	do c = 0, N
		do r = 1, N-1
			if(r == c) then
				A(r,c) = cond(r-1) + cond(r);
			else if( c == r-1) then
				A(r,c) = -cond(r-1);
			else if (c == r+1) then
				A(r,c) = -cond(r);
			endif
		enddo
	enddo
	A(0,0) = 1;
	A(N,N-1) = 0;
	A(N,N) = 1;
	
	!write(*,*) A
	!end Initialize ---------------------
	
	!------------------------------------
	!Preconditioning
	!------------------------------------
	do r = 0,N
		P(r,r) = A(r,r);
		Pinv(r,r) = 1/A(r,r);
	enddo
	
	!call printList(V,N);
	!A = matmul(A, Pinv) 
	!V = matmul(P,V);
	!call printList(V,N);
	
	
	!------------------------------------
	!Solving with the Jacobi method
	!------------------------------------
	write(*,*) 'Result from Jacobi method: '
	call Jacobi(A,V,b,N,error, cond);
	!call printList(V,N);
	
	!------------------------------------
	!Solving with the Gauss-Seidel method
	!------------------------------------
	V = 0.5;
	V(0) = V_0;
	V(N) = V_N;
	
	write(*,*) 'Result from Gauss-Seidel method: '
	call GaussSeidel(A,V,b,N,error, cond);
	!call printList(V,N);
	
	!------------------------------------
	!Solving with LU-decomposition (DEGSV)
	!------------------------------------
	write(*,*) '--------------'
	write(*,*) 'Result from LU-decomposition (DGESV): '
	V = b;
	call DGESV(N+1, 1, A, N+1, pivot, V, N+1, ok)
	!call printList(V,N);
	!write(*,*) ok;
	!end LU
	
	!------------------------------------
	!Checking LU solution
	!------------------------------------
	!call SGEMV('n', N, N, 1.0, A, N, b, 1.0, 0.0,y, 1.0 ))

END PROGRAM Oving3
