#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=fastp_AH                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=fastp_AH_HW10-%j.out
#SBATCH --error=fastp_AH_HW10-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
conda activate admixture

plink2 \
  --vcf /home/t31d817/bioe-591-genomics/course-materials/data/structure_data/squirrels.vcf \
  --allow-extra-chr \
  --make-bed \
  --out species

awk 'BEGIN{OFS="\t"} {if(!($1 in a)) a[$1]=++i; $1=a[$1]; print}' species.bim > species.int.bim
cp species.bed species.int.bed
cp species.fam species.int.fam