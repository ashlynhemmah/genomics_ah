#!/bin/bash

#SBATCH --account=priority-bioe-591-genomics      
#SBATCH --job-name=iqtree                            
#SBATCH --partition=priority          
#SBATCH --nodes=1                      
#SBATCH --ntasks-per-node=1            
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-01:00:00              
#SBATCH --output=iqtree-%j.out
#SBATCH --error=iqtree-%j.err

module load Mamba/23.11.0-0 # load mamba module
eval "$(conda shell.bash hook)" # make conda / mamba executable
conda activate iqtree # load iqtree environment 
bcftools view -v snps ~/bioe-591-genomics/course-materials/data/phylogenetics/lemurs.vcf.gz -Oz -o ~/bioe-591-genomics/students/ashlynhemmah/HW13/lemurs.snps.vcf.gz # filter vcf to SNPs
bcftools index ~/bioe-591-genomics/students/ashlynhemmah/HW13/lemurs.snps.vcf.gz # index the vcf
python ~/bioe-591-genomics/students/ashlynhemmah/HW13/vcf2phylip/vcf2phylip.py -i ~/bioe-591-genomics/students/ashlynhemmah/HW13/lemurs.snps.vcf.gz # convert the vcf to phylip
iqtree -s ~/bioe-591-genomics/students/ashlynhemmah/HW13/lemurs.snps.min4.phy.contree -m GTR -bb 500 -nt AUTO # run iqtree