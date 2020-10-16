# md_patchy_model

Tutorial on using the MD Patch Model of JR Espinosa et al.
     
     *In case of problems please email: jaj52@cam.ac.uk*
--------------------------------------------
Reference
--------------------------------------------
 
If you use any of this code please cite the reference below, which includes full details on the model:

J. Chem. Phys. 150, 224510 (2019)
https://aip.scitation.org/doi/10.1063/1.5098551?af=R&



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
           > git checkout origin/stable \
           > module purge \
           > module load rhel7/default-peta4 \
           > cd src 
  
   1.3.  **Install lammps packages** (RIGID, USER-SMD, MOLECULE) required for MD patchy simulations \
          > make yes-rigid \
          > make yes-user-smd \
          > make lib-smd args="-b" \
          > make yes-molecule \
          > make package-update \
          > make mpi  \
                 
     You should obtain the executable: lmp_mpi 

-----------------------------------------------------------
Procedure: MD simulation with patchy particles and polymer
-----------------------------------------------------------
We will prepare a box containing a given number of patchy particles (hard spheres with patches on them) and a polymer chain. Then we will simulate the system in the NVT ensemble. The following describes the files in each directory, in the order of usage.

**STEP 1: replicate/**\
*INPUT FILES*
  * **conf1.xyz**: xyz coordinates for one patchy particle in the correct format for lammps (ie input configuration) 
  * **in.replicate**: simulation parameters for replicating **conf1.xyz**. Gives a multiple of orginal patchy particle based on      parameters given to "replicate" keyword 
  * **table_gas_ideal.xvg**: ideal gas potential for interactions between patches and hard spheres in tabular form 
  * **table_PHS.xvg**: potential for hard sphere-hard sphere interactions in tabular form 
  * **table_12KT.xvg**: potential for patchy-patchy interactions in tabular form 

*RUN AND USEFUL OUTPUT*
 * **run.sh**: example script for running lammps on the command line with the input files descried above 
 * **replicas.lammpstrj**: lammps trajectory file with given number of frames. Each frame will contain a box of many patchy particles (number of particles = x*y*z specified by replicate keyword)

**STEP 2: removing_particles/** 
  * **replicas.lammpstrj**: edited version of **replicas.lammpstrj** in which the last configuration is saved and all other configurations are discarded.
  * **trj_config**: dumped coordinates from **replicas.lammpstrj**
  * **trj_ordered**: atoms from **trj_config** sorted sequentially
  * **halo_bola.f90**: selects a subset of particles between *rmin* and *rmax* from **trj_ordered** and formats coordinates \
 Compile and run as follows: 
   >gfortran -o halo_bola halo_bola.f90 \
   >./halo_bola 
  * **boli_final.g96**: formatted coordinates for subset (approx. 25%) of patchy particles obtained by compiling and running **halo_bola.f90** above.
  
 **STEP 3: create_config/** 
  * **boli_final.g96**: same as in step 2
  * **conf2.xyz**: same format as **conf1.xyz** above. The number of atoms is updated to total in **boli_final.g96** . The box information is obtained from **replicas.lammpstrj**. The last section of the file contains the contents of **boli_final.g96**. We now have a box containing 1584 patchy particles (equivalent to 6336 atoms).
  * **halo_chain.f90**: Compile and run to set up atom coordinates, bonds and angles for polymer
   >gfortran -o halo_chain halo_chain.f90 \
   >./halo_chain
  * **chain.g96**: formatted coordinates for polymer based on variables set in **halo_chain.f90**. Y and Z coordinates are edited manually for now.
  * **conf3.xyz**: (cat conf2.xyz chain.g96 > conf3.xyz). Updated total atoms, bonds, angles. Updated atom types, bond types, angle types, added mass for polymer particles.
  
  **STEP 4: potentials/** \
  *The final step before we can run our simulations is to create the potentials for our patchy-particles and polymer chain interactions.* 
  * Compile each file below with double precision
  >gfortran -fdefault-real-8 -o a.out ideal_gas.f \
  >./a.out
  * **ideal_gas.f**: produces **table_gas_ideal.xvg** which describes interactions between patches and hard spheres (atom types 1 and 2), and patches and polymer particles (2 and 3).
  * **potencial_LJ.f**: produces **table_LJ.xvg** which describes interactions between hard spheres and polymer particles (atom types 1 and 3).
   * **potencial_PHS_lammps.f**: produces **table_PHS.xvg** which describes interactions between hard spheres (1 and 1), and polymer particles (3 and 3)
   * **patch_patch.f**: produces **table_XKT.xvg** which describes interactions between patches (2 and 2) at a given temparature. 
   
 **STEP 5: simulate/** 
 
 *INPUT FILES*
   * **conf3.xyz**
   * potentials in tabular form: **table_gas_ideal.xvg**, **table_LJ.xvg**, **table_PHS.xvg**, **table_10_5KT.xvg**
   * **in.minimal**: lammps input file containing simulation parameters. A very short simulation.
   
*RUN and OUTPUT* 
   * **run.sh**: execute this script to obtain sample output.
   * **patchy_and_polymer.lammpstraj**: Lammps trajectory file.
   
 -----------------------------------------------------------
Visualisation: (Optional)
-----------------------------------------------------------  
* Load **patchy_and_polymer.lammpstraj** in VMD to visulalise box with polymer chain and patchy particles.
  
