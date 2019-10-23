#!/bin/bash

if [[ ! -e "~/ProcessedData/BWA_output/B_hinzii.VS.F01.sam" ]]
then
	~/run-bwa.sh
fi

samtools view -b -o $/ProcessedData/BWA_output/B_hinzii.VS.F01.bam \
	~/ProcessedData/BWA_output/B_hinzii.VS.F01.sam

samtools view -b -F 4 -o ~/ProcessedData/BWA_output/B_hinzii.VS.F01.hits_only.bam \
	~/ProcessedData/BWA_output/B_hinzii.VS.F01.bam

samtools flagstat ~/ProcessedData/BWA_output/B_hinzii.VS.F01.bam

samtools sort ~/ProcessedData/BWA_output/B_hinzii.VS.F01.bam \
	1> ~/ProcessedData/BWA_output/B_hinzii.VS.F01.sorted.bam

samtools rmdup \
	~/ProcessedData/BWA_output/B_hinzii.VS.F01.sorted.bam \
	~/ProcessedData/BWA_output/B_hinzii.VS.F01.sorted.rmdup.bam

samtools index ~/ProcessedData/BWA_output/B_hinzii.VS.F01.sorted.rmdup.bam

if [[ ! -e "~/ProcessedData/BWA_output/B_hinzii_index.fna" ]]
then
	cp /projects/micb405/resources/genomes/bordetella/ASM107827v1/ ~/ProcessedData/BWA_output/B_hinzii_index.fna
fi

bcftools mpileup --fasta-ref ~/ProcessedData/BWA_output/B_hinzii_index.fna \
	~/ProcessedData/BWA_output/B_hinzii.VS.F01.sorted.rmdup.bam | bcftools call -mv - \
	> ~/ProcessedData/BWA_output/B_hinzii.VS.F01.raw.vcf

