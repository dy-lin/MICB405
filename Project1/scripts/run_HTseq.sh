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
		#posSortedAlignment="${cellType}_${i}Aligned.sortedByCoord.out.bam"
		nameSortedAlignment="${cellType}_${i}Aligned.sortedByName.out.bam"
		#samtools sort -n -o ${nameSortedAlignment} ${posSortedAlignment}
		gtf="${star_index_file}/mm10.gtf"
		htseq-count -s reverse -r name -f bam -o ${cellType}_${i}.HT_out.sam $nameSortedAlignment $gtf &> ${cellType}_lib${i}.HTSeq.count 
	done
done
