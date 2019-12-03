#! /bin/bash

# input: file paths to the read 1 and read 2

star_read_filepath="/projects/micb405/data/mouse/project_1/RNA-seq/"
star_index_file="/projects/micb405/resources/STAR_tutorial/STAR_index_musmusculus_mm10/"
outputFilePrefix="/projects/micb405/project1/Team10/STAR_output/"
j=8

for cellType in "Memory" "Naive" "Primary"; do
#for cellType in "Primary"; do
	for i in {1..3}; do
	#for i in {1..3}; do
		dir="${outputFilePrefix}${cellType}_lib$i/"
		cd $dir
		rawread1="${star_read_filepath}${cellType}_1.${i}.fastq"
		rawread2="${star_read_filepath}${cellType}_2.${i}.fastq"
		alignment="${cellType}_${i}Aligned.sortedByName.out.bam"
		gtf="${star_index_file}/mm10.gtf"
		java -jar /projects/micb405/project1/Team10/scripts/QoRTs-STABLE.jar QC --generatePlots --stranded --genomeFA "${star_index_file}mm10_genome.fa" --rawfastq $rawread1,$rawread2 $alignment $gtf "$dir/${cellType}${i}_QC/"
	done
done
