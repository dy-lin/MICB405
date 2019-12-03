#!/bin/bash

set -euo pipefail

PROJECT=/projects/micb405/project1/Team10
RNASEQ=/projects/micb405/data/mouse/project_1/RNA-seq
CHIPSEQ=/projects/micb405/data/mouse/project_1/ChIP-seq

TYPE=(Memory Naive Primary)
TRT=(H3K27ac Input)

THREADS=8

FASTQC=$PROJECT/fastqc/ChIP-seq
mkdir -p $FASTQC

for i in ${TYPE[@]}
do
	for j in ${TRT[@]}
	do
		fastqc -t $THREADS -o $FASTQC $CHIPSEQ/${i}_${j}_?.fastq 2> $FASTQC/fastqc.log
	done
done

FASTQC=$PROJECT/fastqc/RNA-seq
mkdir -p $FASTQC

for i in ${TYPE[@]}
do
	for j in $(seq 3)
	do
		fastqc -t $THREADS -o $FASTQC $RNASEQ/${i}_?.${j}.fastq 2> $FASTQC/fastqc.log
	done
done


