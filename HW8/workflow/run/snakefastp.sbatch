#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=snakemake                             
#SBATCH --partition=priority              
#SBATCH --nodes=1                     
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-00:30:00                 
#SBATCH --output=log/snakemake-%j.out
#SBATCH --error=log/snakemake-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"

snakemake --profile profile/slurm --use-conda

