#!/bin/bash

set -euo pipefail

PROJECT=/projects/micb405/project1/Team10
ALN=/projects/

GTF=/projects/micb405/resources/STAR_tutorial/STAR_index_musmusculus_mm10/mm10.gtf

TYPE=(Memory Naive Primary)

HTSEQ=$PROJECT/HTseq
mkdir -p $HTSEQ

for i in ${TYPE[@]}
do
	htseq-count \
		-f bam \
		-m union \
		-i gene_id \
		-r pos \
		-s no \ # IS IT THO
		$ALN/${i}_ \
		$GTF > $HTSEQ/htseq_counts_star.txt 2> $HTSEQ/htseq.log
done

