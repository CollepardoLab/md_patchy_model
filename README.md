# md_patchy_model

Tutorial on using the MD Patch Model of JR Espinosa et al.

--------------------------------------------
Reference
--------------------------------------------

For full details on the model see: (INCLUDE CITATION)


--------------------------------------------
Software and Packages
--------------------------------------------

1. LAMMPS (Large-scale atomiic/molecular massively parallel 
   simulator) 
   1.1. Install LAMMPS with mpi - for more information on how to obtain and install LAMMPS 
        see: https://lammps.sandia.gov/doc/Install.html
       
  1.2. Example installation on HPC (Cambridge users)
        Download lammps source from github
           > git clone --depth https://github.com/lammps/lammps.git \
           > cd lammps
           > module purge 
           > module load rhel7/default-peta4
           > cd lammps/src
           > make purge
           > make package-update
           > make mpi
           You should obtain the executable: lmp_mpi  
           
  1.3  Add lammps packages (RIGID, KOKKOS, USER-SMD, MOLECULE) required for MD patchy simulations
          > make yes-rigid
          > make mpi
          > make yes-kokkos
          > make mpi KOKKOS_DEVICES=OpenMP
          > make yes-user-smd
          > make lib-smd args="-b"
          > make yes-molecule
          > make mpi  

         
