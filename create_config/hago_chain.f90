program bola

implicit none

real :: x,y,z,sigma,rc,xsol(30000),ysol(30000),zsol(30000)
integer :: nsolido,i,c,b,a,j,nsites,kk,m, nstart, nmol, bond_type, angle_type, chain_len
real :: xdis,ydis,zdis,dist,aliq,bliq,cliq,rmax,rmin
CHARACTER(LEN=15) :: pene
!open(unit=7,file='trj_ordered',status='unknown')
open(unit=15,file='chain.g96',status='unknown')

xsol(:)=100.0
ysol(:)=0.0
zsol(:)=0.0
nstart=6337  ! first particle in chain
nsolido=6376 ! last particle in chain = total number of particles
!nsites=1
nmol=1585    ! chain  number
bond_type=1
angle_type=1
chain_len=nsolido-nstart+1
!rmin=10

!rmax=55.0
!m=nstart          ! PARTICLE NUMBER
!       do i=1,nsolido
!        do j=1,nsites
!       read(7,*) kk,kk,xsol(i,j),ysol(i,j),zsol(i,j)
!       enddo
!       enddo
       c=nmol  ! molecule number (same for chain)
       do i=nstart,nsolido
          

!         if (xsol(i,1) .gt. rmin) then
!         if (xsol(i,1) .lt. rmax) then
        ! c=c+1  
!         m=m+1       
         write(15,106) i,c,xsol(i),ysol(i),zsol(i) 
!         m=m+1       
!         write(15,102) m,c,xsol(i,2),ysol(i,2),zsol(i,2)
!         m=m+1       
!         write(15,102) m,c,xsol(i,3),ysol(i,3),zsol(i,3)
!         m=m+1       
!         write(15,102) m,c,xsol(i,4),ysol(i,4),zsol(i,4)
!         m=m+1       
!         write(15,105) m,c,xsol(i,5),ysol(i,5),zsol(i,5)
!         endif
!         endif 
         enddo
! Bonds 
        b=nstart
        write(15,*) " "
        write(15,*) "Bonds"
        write(15,*) " "
        do i=1,chain_len-1
           write(15,107) i,bond_type,b,b+1
           b=b+1
        enddo
! Angles
        a=nstart 
        write(15,*) " "
        write(15,*) "Angles"
        write(15,*) " "
        do i=1,chain_len-2
           write(15,108) i,angle_type,a,a+1,a+2
           a=a+1
        enddo

 
  101  format(T1,I5,2X,I4,2X,"1",4X,"0.00",5X,3(2x,F13.8)) 
  102  format(T1,I5,2X,I4,2X,"2",4X,"0.00",5X,3(2x,F13.8)) 
  103  format(T1,I5,2X,I4,2X,"9",4X,"0.00",5X,3(2x,F13.8)) 
  104  format(T1,I5,2X,I4,2X,"9",4X,"0.00",5X,3(2x,F13.8)) 
  105  format(T1,I5,2X,I4,2X,"5",4X,"0.00",5X,3(2x,F13.8)) 
  106  format(T1,I5,2X,I4,2X,"3",4X,"0.00",5X,3(2x,F13.8)) 
  107  format(T1,I5,2X,I3,2X,I7,2X,I7)
  108  format(T1,I5,2X,I3,2X,I7,2X,I7,2X,I7)


      stop
      end
