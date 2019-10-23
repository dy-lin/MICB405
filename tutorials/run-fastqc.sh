#!/bin/bash

mkdir -p ~/ProcessedData/FastQC_output/

fastqc --threads 2 -o ~/ProcessedData/FastQC_output/ /projects/micb405/data/bordetella/F01_R?.fastq
