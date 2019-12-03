#!/bin/bash

set -euo pipefail

INDEX=/projects/micb405/resources/genomes/mouse/mm10/bwa_index/mm10.fa

READS=/projects/micb405/data/mouse/project_1/ChIP-seq

PROJECT=/projects/micb405/project1/Team10

OUT_DIR=$PROJECT/bwa_alignments

TEMP=$OUT_DIR/intermediates

THREADS=8

mkdir -p $OUT_DIR
mkdir -p $TEMP

TYPES=(Memory Naive Primary)
TRT=(H3K27ac Input)

for i in ${TYPES[@]}
do
	for j in ${TRT[@]}
	do
		name=${i}_${j}
		bwa mem -t $THREADS $INDEX $READS/${name}_*.fastq 2> $OUT_DIR/${name}.log > $OUT_DIR/${name}.sam
		sambamba view -t $THREADS -S -f bam -o $OUT_DIR/${name}.bam $OUT_DIR/${name}.sam
		sambamba sort -t $THREADS -o $OUT_DIR/${name}.sorted.bam $OUT_DIR/${name}.bam
		sambamba markdup -t $THREADS $OUT_DIR/${name}.sorted.bam $OUT_DIR/${name}.sorted.mkdup.bam
		mv $OUT_DIR/${name}.sam $OUT_DIR/${name}.bam $OUT_DIR/${name}.sorted.bam $TEMP

	done
done
