#!/bin/bash

export GENOME=/projects/micb405/resources/genomes/mouse/mm10/bwa_index/mm10.fa

export DATA=/projects/micb405/data/mouse/chip_tutorial

bwa mem -t 8 $GENOME $DATA/Naive_H3K27ac_1.fastq $DATA/Naive_H3K27ac_2.fastq >./Naive_H3K27ac.sam 2>bwa_naive_h3k27ac.log &
bwa mem -t 8 $GENOME $DATA/Naive_Input_1.fastq $DATA/Naive_Input_2.fastq >./Naive_Input.sam 2>bwa_naive_Input.log &

sambamba view -S -f bam -o Naive_H3K27ac.bam Naive_H3K27ac.sam
sambamba sort -t 8 Naive_H3K27ac.bam
sambamba markdup -t 8 Naive_H3K27ac.sorted.bam Naive_H3K27ac.sorted.mkdup.bam

macs2 callpeak -t Naive_H3K27ac.sorted.mkdup.bam -c Naive_Input.sorted.mkdup.bam -f BAMPE -g mm -n Naive_H3K27ac -B -q 0.01
