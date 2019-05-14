! potential parameters for ideal gas interactionss ie interactions
! between hard sphere and patch paticles
! we are setting all the energies and derivatives equal to zero
      dimension u(10000),rr(10000),deri(10000)
      open(unit=3,file="table_gas_ideal.xvg",status="unknown")
      cero=0.000 
c
      do ir=1,6202
         rr(ir)=0.0+(ir-1)*0.0005
      enddo 

      write(3,'(A)') "gas"
      write(3,*) "N",3601
      write(3,*) "  "

      ! stopping at N=3601 ie at 18 angstrom (i.e., not considering
      ! interactions beyond that distance)
      do iz=1,3601
      ! Lammps does not like the distance for the potential to be
      ! exactly zero. Therefore, replace zero with a very small value.
      if (iz==1) then
        write(3,200) iz,0.1e-6,cero,cero
      else
        write(3,200) iz,rr(iz)*10.0,cero,cero
      endif
      enddo
 200  format(I4,2x,3(E15.8,4x))
c 100  format(2x,3(E15.8,5x))  
      stop 
      END
