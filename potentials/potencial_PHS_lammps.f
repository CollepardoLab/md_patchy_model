      dimension u(10000),rr(10000),deri(10000)
      dimension ucoulomb(10000),dericoulomb(10000)
      open(unit=3,file="table_PHS.xvg",status="unknown")
      sigma=3.405/10. 
      epsilon=0.996078
      rshift=50./49*sigma
c      epsilon=0.00000000000
      cero=0.000 
c
      do ir=1,6202
      rr(ir)=0.0+(ir-1)*0.0005
      if (rr(ir).lt.0.2) then 
      u(ir)=0.00
      deri(ir)=0.0
      ucoulomb(ir)=0.0
      dericoulomb(ir)=0.0
      else 
      xx=rr(ir)/sigma
      xx49=xx**49
      xx50=xx**50
      u(ir)= 50.*((50./49.)**49.)*epsilon*(1./xx50 -1./xx49) + epsilon
      deri(ir)=50.*((50./49.)**49.)*epsilon*(-50./sigma/(xx50*xx)
     & +49./sigma/(xx49*xx))
      ucoulomb(ir)=1./rr(ir)
      dericoulomb(ir)=-1./(rr(ir)**2)
c tipo WCA 
        if (rr(ir).gt.rshift) then 
        u(ir)=0.00
        deri(ir)=0.00
        endif 
      endif 
      enddo
!      write(3,200) cero,cero,cero,cero,cero
!     1           ,cero,cero 
c
      write(3,'(A)') "phs"
      write(3,*) "N",3601
      write(3,*) "  "

      do iz=1,3601
      derinum=(u(iz+1)-u(iz-1))/(rr(iz+1)-rr(iz-1))
      derinumcoulomb=(ucoulomb(iz+1)-ucoulomb(iz-1))/(rr(iz+1)-rr(iz-1))
c      deri=(u(iz+1)-u(iz-1))
c      fuerza=-deri
c
      ! Lammps does not like the distance for the potential to be
      ! exactly zero. Therefore, replace zero with a very small value.
      if (iz==1) then
        write(3,200) iz,0.1e-6,u(iz)/4.184,-deri(iz)/4.184/10.0
      else
        write(3,200) iz,rr(iz)*10.0,u(iz)/4.184,-deri(iz)/4.184/10.0
      endif
      enddo
 200  format(I4,2x,3(E15.8,4x))
c 100  format(2x,3(E15.8,5x))  
      stop 
      END

