#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=index_AH                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=align1_AH_HW5-%j.out
#SBATCH --error=align1_AH_HW5-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your fastp environment
conda activate align

bwa mem -t 4 hemoglobin_references.fasta ~/bioe-591-genomics/students/ashlynhemmah/HW4-/trimmed_reads/Diglossa_baritula_77283_R1_001_trimmed.fastq.gz ~/bioe-591-genomics/students/ashlynhemmah/HW4-/trimmed_reads/Diglossa_baritula_77283_R2_001_trimmed.fastq.gz > Diglossa_baritula_77283.sam