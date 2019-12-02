#!/bin/bash
# set -uo pipefail


proj="/projects/micb405/project1/Team10/project2"

reads="/projects/micb405/resources/project_2/2019/Metatranscriptomes"

# prokka=$proj/Prokka_output/HQ_MAGs
prokka=$proj/Prokka_output/MedQ_MAGs

# bwa_out=$proj/bwa_output/HQ_MAGs
bwa_out=$proj/bwa_output/MedQ_MAGs
mkdir -p $bwa_out

for mag in $prokka/*.ffn
do
	name=$(basename $mag ".ffn")
	bwa index $mag 2> $bwa_out/$name.bwa.index.log 
	bwa mem -t 8 -p $mag $reads/SI072_120m.qtrim.artifact.rRNA.clean.fastq.gz 2> $bwa_out/$name.bwa.mem.log > $bwa_out/$name.sam
done
