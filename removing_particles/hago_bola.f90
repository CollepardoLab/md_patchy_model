program bola

implicit none

real :: x,y,z,sigma,rc,xsol(30000,5),ysol(30000,5),zsol(30000,5)
integer :: nsolido,i,c,j,nsites,kk,m 
real :: xdis,ydis,zdis,dist,aliq,bliq,cliq,rmax,rmin
CHARACTER(LEN=15) :: pene
open(unit=7,file='trj_ordered',status='unknown')
open(unit=15,file='boli_final.g96',status='unknown')

nsolido=6048
nsites=4
rmin=10

rmax=55.0
m=0
       do i=1,nsolido
        do j=1,nsites
       read(7,*) kk,kk,xsol(i,j),ysol(i,j),zsol(i,j)
       enddo
       enddo
       c=0
       do i=1,nsolido
          

         if (xsol(i,1) .gt. rmin) then
         if (xsol(i,1) .lt. rmax) then
         c=c+1  
         m=m+1       
         write(15,101) m,c,xsol(i,1),ysol(i,1),zsol(i,1) 
         m=m+1       
         write(15,102) m,c,xsol(i,2),ysol(i,2),zsol(i,2)
         m=m+1       
         write(15,102) m,c,xsol(i,3),ysol(i,3),zsol(i,3)
         m=m+1       
         write(15,102) m,c,xsol(i,4),ysol(i,4),zsol(i,4)
!         m=m+1       
!         write(15,105) m,c,xsol(i,5),ysol(i,5),zsol(i,5)
         endif
         endif 
         enddo
       
  101  format(T1,I5,2X,I4,2X,"1",4X,"0.00",5X,3(2x,F13.8)) 
  102  format(T1,I5,2X,I4,2X,"2",4X,"0.00",5X,3(2x,F13.8)) 
  103  format(T1,I5,2X,I4,2X,"9",4X,"0.00",5X,3(2x,F13.8)) 
  104  format(T1,I5,2X,I4,2X,"9",4X,"0.00",5X,3(2x,F13.8)) 
  105  format(T1,I5,2X,I4,2X,"5",4X,"0.00",5X,3(2x,F13.8)) 


      stop
      end
