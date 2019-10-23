#!/bin/bash

mkdir -p ~/ProcessedData/BWA_output/

bwa index -p ~/ProcessedData/BWA_output/B_hinzii_index \
	/projects/micb405/resources/genomes/bordetella/ASM107827v1/GCA_00108275.1_ASM107827v1_genomic.fna

bwa aln -t 2 ~/ProcessedData/BWA_output/B_hinzii_index \
	/projects/micb405/data/bordetella/F01_R1_1M.fastq > ~/ProcessedData/BWA_output/B_hinzii.VS.F01_R1.sai

bwa aln -t 2 ~/ProcessedData/BWA_output/B_hinzii_index \
	/projects/micb405/data/bordetella/F01_R2_1M.fastq > ~/ProcessedData/BWA_output/B_hinzii.VS.F01_R2.sai

bwa sampe ~/ProcessedData/BWA_output/B_hinzii_index \
	~/ProcessedData/BWA_output/B_hinzii.VS.F01_R1.sai \
	~/ProcessedData/BWA_output/B_hinzii.VS.F01_R2.sai \
	/projects/micb405/data/bordetella/F01_R1_1M.fastq \
	/projects/micb405/data/bordetella/F01_R2_1M.fastq \
	1> ~/ProcessedData/BWA_output/B_hinzii.VS.F01.sam 2> ~/ProcessedData/BWA_output/B_hinzii.VS.F01_log.txt

bwa mem -t 2 ~/ProcessedData/BWA_output/B_hinzii_index \
	/projects/micb405/data/bordetella/F01_R1_1M.fastq /projects/micb405/data/bordetella/F01_R2_1M.fastq \
	1> ~/ProcessedData/BWA_output/B_hinzii.VS.F01.sam 2> ~/ProcessedData/BWA_output/B_hinzii.VS.F01_log.txt
