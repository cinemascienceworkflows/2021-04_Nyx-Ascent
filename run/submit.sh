#!/bin/bash

# Begin LSF Directives
#BSUB -P <compute_allocation>
#BSUB -J <pantheon_workflow_jid> 
#BSUB -W 0:10
#BSUB -nnodes 1
#BSUB -alloc_flags "gpumps"
#BSUB -o Nyx64_Test.%J
#BSUB -e Nyx64_Test.%J

date

module load gcc/6.4.0 
module load cuda/10.1.168

jsrun -n 6 -a 1 -g 1 -c 7 <pantheon_run_dir>/Nyx3d.gnu.TPROF.MTMPI.CUDA.ex inputs.rt  insitu.int=1 max_step=3 amr.max_grid_size=32 amr.regrid_on_restart=1
