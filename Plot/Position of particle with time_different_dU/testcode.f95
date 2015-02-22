!Plotter posisjon av en partikkel sfa tid med varierende potensial.
 	x1 = 0;
 	t = 3*tau*w/4
 	dU = 0.1;
 	do i = 1,N
			x1(i) = updatePos(x1(i-1),t);
	enddo
 	call toFile(x1,N, pos1)
 	
 	x1 = 0;
 	dU = 0.5;
 	do i = 1,N
			x1(i) = updatePos(x1(i-1),t);
	enddo
 	call toFile(x1,N, pos2)
 	
 	x1 = 0;
 	dU = 10;
	do i = 1,N
			x1(i) = updatePos(x1(i-1),t);
	enddo
 	call toFile(x1,N, pos3)
