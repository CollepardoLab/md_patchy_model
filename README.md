# md_patchy_model

Tutorial on using the MD Patch Model of JR Espinosa et al.

--------------------------------------------
Reference
--------------------------------------------

For full details on the model see: (INCLUDE CITATION)


--------------------------------------------
Software and Packages
--------------------------------------------
1. **LAMMPS** (Large-scale atomiic/molecular massively parallel 
   simulator)
   
   1.1. **Install LAMMPS with mpi** - for more information on how to obtain and install LAMMPS 
        see: https://lammps.sandia.gov/doc/Install.html 
       
   1.2. **Example installation on HPC** (Cambridge users) \
        Download lammps source from github \
           > git clone --depth https://github.com/lammps/lammps.git \
           > cd lammps \
           > module purge \
           > module load rhel7/default-peta4 \
           > cd lammps/src \
           > make purge \
           > make package-update \
           > make mpi \
           You should obtain the executable: lmp_mpi 
           
   1.3.  **Add lammps packages** (RIGID, KOKKOS, USER-SMD, MOLECULE) required for MD patchy simulations \
          > make yes-rigid \
          > make mpi \
          > make yes-kokkos \
          > make mpi KOKKOS_DEVICES=OpenMP \
          > make yes-user-smd \
          > make lib-smd args="-b" \
          > make yes-molecule \
          > make mpi  

-----------------------------------------------------------
Procedure: MD simulation with patchy particles and polymer
-----------------------------------------------------------
We will prepare a box containing a given number of patchy particles (hard spheres with patches on them) and a polymer chain. Then we will simulate the system in the NVT ensemble. The following explains the contents of each directory in this tutorial and the steps taken to carry out the simulation. 

**STEP 1: replicate** \
1.1. **replicate/conf1.xyz**: xyz coordinates for one patchy particle in the correct format for lammps (ie input configuration) \
1.2. **replicate/in.replicate**: simulation parameters for replicating conf1.xyz. Gives a multiple of orginal patchy particle based on      parameters given to "replicate" keyword \
1.3. **replicate/table_gas_idel.xvg**: ideal gas potential for interactions between patches and hard spheres in tabular form \
1.4. **replicate/table_PHS.xvg**: potential for hard sphere-hard sphere interactions in tabular form \
1.5. **replicate/table_12KT.xvg**: potential for patchy-patchy interactions in tabular form


