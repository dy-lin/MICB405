#!/bin/bash

BWA_ALIGNMENT=/projects/micb405/project1/Team10/bwa_alignments

NT=$BWA_ALIGNMENT/Naive_H3K27ac.sorted.mkdup.bam
NC=$BWA_ALIGNMENT/Naive_Input.sorted.mkdup.bam
PT=$BWA_ALIGNMENT/Primary_H3K27ac.sorted.mkdup.bam
PC=$BWA_ALIGNMENT/Primary_Input.sorted.mkdup.bam

MACS2=/projects/micb405/project1/Team10/macs2

RELATIVE_DEPTH_NAIVE=$(grep "fragments after filtering in control" $MACS2/Naive.log | awk '{print $NF}')
RELATIVE_DEPTH_PRIMARY=$(grep "fragments after filtering in control" $MACS2/Primary.log | awk '{print $NF}')

macs2 bdgdiff \
	--t1 $MACS2/Primary_H3K27ac_treat_pileup.bdg \
	--c1 $MACS2/Primary_H3K27ac_control_lambda.bdg \
	--t2 $MACS2/Naive_H3K27ac_treat_pileup.bdg \
	--c2 $MACS2/Naive_H3K27ac_control_lambda.bdg \
	--d1 $RELATIVE_DEPTH_PRIMARY \
	--d2 $RELATIVE_DEPTH_NAIVE \
	--o-prefix $MACS2/diff_Primary_versus_Naive 2> $MACS2/bdgdiff.log 
