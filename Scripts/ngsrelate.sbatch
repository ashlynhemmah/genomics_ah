#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=ngsrelate                            
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=ngsrelate-%j.out
#SBATCH --error=ngsrelate-%j.err

module load Mamba/23.11.0-0;
module load bcftools
eval "$(conda shell.bash hook)"

# gzip the vcf
bcftools view -Oz -o inca.vcf.gz ~/bioe-591-genomics/course-materials/data/kinship/Inca_MaxMissing10.recode.vcf

# index the vcf
tabix -p vcf inca.vcf.gz

# generate a sample ID file 
bcftools query -l inca.vcf.gz > sample_ids.txt

# call ngsRelate
ngsRelate -h inca.vcf.gz -T GT -c 1 -O inca.ngsrelate.out -z sample_ids.txt