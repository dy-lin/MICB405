#!/bin/bash

set -euo pipefail

PROJECT=/projects/micb405/project1/Team10
ALN=$PROJECT/bwa_alignments

TYPE=(Memory Naive Primary)

MACS2=$PROJECT/macs2
mkdir -p $MACS2
for i in ${TYPE[@]}
do
	macs2 callpeak -t $ALN/${i}_H3K27ac.sorted.mkdup.bam -c $ALN/${i}_Input.sorted.mkdup.bam -f BAMPE -g mm -n ${i}_H3K27ac -B -q 0.01 --outdir $MACS2 2> $MACS2/${i}.log
done


