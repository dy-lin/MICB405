#!/bin/bash
# set -uo pipefail


proj="/projects/micb405/project1/Team10/project2"

reads="/projects/micb405/resources/project_2/2019/Metatranscriptomes"

# prokka=$proj/Prokka_output/HQ_MAGs
prokka=$proj/Prokka_output/MedQ_MAGs

# bwa_out=$proj/bwa_output/HQ_MAGs
bwa_out=$proj/bwa_output/MedQ_MAGs

# rpkm_out=$proj/rpkm_output/HQ_MAGs
rpkm_out=$proj/rpkm_output/MedQ_MAGs

mkdir -p $rpkm_out

for mag in $prokka/*.ffn
do
	name=$(basename $mag ".ffn")
	/projects/micb405/resources/project_2/2019/rpkm -c $mag -a $bwa_out/$name.sam  -o $rpkm_out/$name.csv
done



