#! /bin/bash

# input: file paths to the read 1 and read 2

star_read_filepath="/projects/micb405/data/mouse/project_1/RNA-seq/"
star_index_file="/projects/micb405/resources/STAR_tutorial/STAR_index_musmusculus_mm10/"
outputFilePrefix="/projects/micb405/project1/Team10/STAR_output/"
j=8

for cellType in "Memory" "Naive" "Primary"; do
	for i in {1..3}; do
		dir="${outputFilePrefix}${cellType}_lib$i/"
		cd $dir
		read1="${star_read_filepath}${cellType}_1.${i}.fastq"
		read2="${star_read_filepath}${cellType}_2.${i}.fastq"
		STAR --runThreadN 8 --genomeDir $star_index_file --readFilesIn $read1 $read2 --outFileNamePrefix "${outputFilePrefix}${cellType}_lib${i}" --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes Standard 
	done
done
