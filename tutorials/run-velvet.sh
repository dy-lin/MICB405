#!/bin/bash

velveth ~/ProcessedData/Ebolavirus_assemblies/ 31 -fastq -shortPaired \
	/projects/micb405/data/Ebola/SRR5528816_1.fastq \
	/projects/micb405/data/Ebola/SRR5528816_2.fastq

velvetg ~/ProcessedData/Ebolavirus_assemblies/ -cov_cutoff 4
