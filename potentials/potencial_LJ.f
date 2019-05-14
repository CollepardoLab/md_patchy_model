      dimension u(10000),rr(10000),deri(10000)
      dimension ucoulomb(10000),dericoulomb(10000)
      open(unit=1,file="LJ_potential.dat",status="unknown")
      open(unit=2,file="coulomb_potential.dat",status="unknown")
      open(unit=3,file="table_LJ.xvg",status="unknown")
      sigma=3.405/10. 
      epsilon=4.50
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
      xx2=xx**2
      xx6=xx2*xx2*xx2
      xx12=xx6*xx6
      u(ir)= 4.*epsilon*(1./xx12-1./xx6)
      deri(ir)=4.*epsilon*(-12./sigma/(xx12*xx)+6./sigma/(xx6*xx)) 
      ucoulomb(ir)=1./rr(ir)
      dericoulomb(ir)=-1./(rr(ir)**2)
      endif 
      enddo

      write(3,'(A)') "LJ"
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

