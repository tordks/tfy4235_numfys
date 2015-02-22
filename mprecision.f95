!####################################
!Precision
!####################################

MODULE mprecision
  ! defines standard precision 
  

  ! --- single
  integer, parameter :: sp  = kind(1.0)
  ! --- double
  integer, parameter :: dp  = kind(1.0d0)
  
  ! --- working precision 
  integer, parameter :: wp  = dp;
  
end module mprecision
