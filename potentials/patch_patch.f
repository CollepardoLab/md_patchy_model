      dimension u(10000),rr(10000)
      dimension ucoulomb(10000),dericoulomb(10000)
      dimension deri_analytical(10000),depth(20) 
      open(unit=1,file="table_0_00001kT.xvg",status="unknown")
      open(unit=2,file="table_0_02kT.xvg",status="unknown")
      open(unit=3,file="table_0_03kT.xvg",status="unknown")
      open(unit=4,file="table_5kT.xvg",status="unknown")
      open(unit=5,file="table_1kT.xvg",status="unknown")
      open(unit=6,file="table_1_25kT.xvg",status="unknown")
      open(unit=7,file="table_1_5kT.xvg",status="unknown")
      open(unit=8,file="table_7kT.xvg",status="unknown")
      open(unit=9,file="table_7_5kT.xvg",status="unknown")
      open(unit=10,file="table_8_5kT.xvg",status="unknown")
      open(unit=11,file="table_8_1kT.xvg",status="unknown")
      open(unit=12,file="table_8_2kT.xvg",status="unknown")
      open(unit=13,file="table_5_9kT.xvg",status="unknown")
      open(unit=14,file="table_6_15kT.xvg",status="unknown")
      open(unit=15,file="table_10_5kT.xvg",status="unknown")
      open(unit=16,file="table_10_75kT.xvg",status="unknown")
      open(unit=17,file="table_11kT.xvg",status="unknown")
c

      open(unit=88,file="profundidades_de_pozo.dat",status="unknown")
c      
c      open(1001,file="welldepth.dat")
      width_well_sigma=0.12
      width_interfase_sigma=0.005
      rgas=8.314
      temp=179.71
      rhog=0.000
      depth(1)=0.00001
      depth(2)=0.02
      depth(3)=0.03
      depth(4)=5.0
      depth(5)=1.0
      depth(6)=1.25
      depth(7)=1.5
      depth(8)=7.0
      depth(9)=7.5
      depth(10)=8.5
      depth(11)=8.1
      depth(12)=8.2
      depth(13)=5.9
      depth(14)=6.15
      depth(15)=10.5
      depth(16)=10.75
      depth(17)=11.0
c
      npocillos=3054
c 
      do it=1,17
      depth_kT=depth(it) 
c Depth of the well in kJ/mol
      epsilon_well=depth_kT*rgas*temp/1000. 
      rhol=epsilon_well
c Well size 0.35 sigma in nm 
      z_0=width_well_sigma*3.405/10.
c Width of the interfase in nm 
      d=width_interfase_sigma*3.405/10.
c
      cero=0.000
c
      do iz=1,6000
      z=0.00000001+(iz-1)*0.0005
      rr(iz)=z
      ucoulomb(iz)=0.0
      dericoulomb(iz)=0.0
      auxi=(z-z_0)/d 

c To avoid NaN in the hyperbolic funcion 
c at large distances  
      if (rr(iz).le.0.5) then
      senoh=(exp(auxi)-exp(-auxi))/2.
      coseh=(exp(auxi)+exp(-auxi))/2.
      tangenh=senoh/coseh
      rho=0.5*(rhol+rhog)-0.5*(rhol-rhog)*tangenh
      u(iz)=-rho/4.184
      der_rho=-0.5*(rhol-rhog)/(coseh**2)/d
      deri_analytical(iz)=-der_rho/4.184/10.0
      else
      u(iz)=0.0000
      deri_analytical(iz)=0.00000
      endif
c
      enddo  
c
      write(it,'(A)') "poci"
      write(it,*) "N",3601
      write(it,*) "  "
      do iz=1,6000
      if (iz.eq.1) then 
c      write(88,500) depth(it),-epsilon_pozo,u(iz),u(iz)*npocillos 
      write(88,500) depth(it),u(iz),u(iz)*npocillos 
      endif 
c      deri=(u(iz+1)-u(iz-1))/(rr(iz+1)-rr(iz-1))
c      fuerza=-deri
      if (deri_analytical(iz) .lt. 0.1e-99) then 
      deri_analytical(iz)=0.00000
      write(it,200) iz,rr(iz)*10.0,u(iz),-deri_analytical(iz)
      else
      write(it,200) iz,rr(iz)*10.0,u(iz),-deri_analytical(iz)
      endif
c      write(3,200) rr(iz),u(iz),-deri,-deri_analytical(iz) 
      enddo
c a por otro valor de kT 
      enddo 
 200  format(I4,2x,3(E15.8,4x))
 500  format(2x,3(F17.10,3x)) 
      stop 
      END

