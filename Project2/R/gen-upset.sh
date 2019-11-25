#!/bin/bash

data=/projects/micb405/project1/Team10/project2/SaanichInlet_MAG120m_ORFs_ko.cleaned.txt

hq=/projects/micb405/project1/Team10/project2/HQmags.renamed.txt

outdir=/projects/micb405/project1/Team10/project2/

echo -e "MAG\t$(awk -F "\t" '{print $2}' $data | sort -u | tr '\n' '\t')" > $outdir/upset.csv

while read mag
do
		
done < $hq




