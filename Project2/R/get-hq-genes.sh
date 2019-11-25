#!/bin/bash
set -euo pipefail

proj=/projects/micb405/project1/Team10/project2

ann=$proj/Prokka_output/HQ_MAGs

hq=$proj/HQmags.renamed.txt

# get all CDS annotated genes for HQ MAGs
echo -e "MAG\t$(cat $ann/*.gff | awk -F "gene=" '/gene=/ {print $2}' | awk -F ";" '{print $1}' | sort -u | tr '\n' '\t')" > $proj/R/cds.tsv
sed -i 's/\t$//' $proj/R/cds.tsv

# get all rRNA annotated genes for HQ MAGs
echo -e "MAG\t$(cat $ann/*.gff | awk -F "product=" '/\trRNA\t/ {print $2}' | awk -F ";" '{print $1}' | sort -u | tr '\n' '\t')" > $proj/R/rRNA.tsv
sed -i 's/\t$//' $proj/R/rRNA.tsv

# get all tRNA annotated genes for HQ MAGs
echo -e "MAG\t$(cat $ann/*.gff | awk -F "product=" '/\ttRNA\t/ {print $2}' | awk -F ";" '{print $1}' | sort -u | tr '\n' '\t')" > $proj/R/tRNA.tsv
sed -i 's/\t$//' $proj/R/tRNA.tsv

#get all tmRNA annotated genes for HQ MAGs
echo -e "MAG\t$(cat $ann/*.gff | awk -F "product=" '/\ttmRNA\t/ {print $2}' | awk -F ";" '{print $1}' | sort -u | tr '\n' '\t')" > $proj/R/tmRNA.tsv
sed -i 's/\t$//' $proj/R/tmRNA.tsv


while read mag
do
	line="$mag"
	while read cds
	do
#		echo $cds
		if [[ "$(grep -c "gene=${cds};" $ann/${mag}.gff)" -gt 0 ]]
		then
			line=$line$'\t'"1"
		else
			line=$line$'\t'"0"
		fi
	done < <(cat $ann/*.gff | awk -F "gene=" '/gene=/ {print $2}' | awk -F ";" '{print $1}' | sort -u)
	echo -e "$line" >> $proj/R/cds.tsv

	line="$mag"
	while read rrna
	do
		if [[ "$(grep -wc "product=$rrna" $ann/${mag}.gff)" -gt 0 ]]
		then
			line=$line$'\t'"1"
		else
			line=$line$'\t'"0"
		fi
	done < <(cat $ann/*.gff | awk -F "product=" '/\trRNA\t/ {print $2}' | awk -F ";" '{print $1}' | sort -u)
	echo -e "$line" >> $proj/R/rRNA.tsv

	line="$mag"
	while read trna
	do
		if [[ "$(grep -wc "product=$trna" $ann/${mag}.gff)" -gt 0 ]]
		then
			line=$line$'\t'"1"
		else
			line=$line$'\t'"0"
		fi
	done < <(cat $ann/*.gff | awk -F "product=" '/\ttRNA\t/ {print $2}' | awk -F ";" '{print $1}' | sort -u)
	echo -e "$line" >> $proj/R/tRNA.tsv

	line="$mag"

	while read tmrna
	do
		if [[ "$(grep -wc "product=$tmrna" $ann/${mag}.gff)" -gt 0 ]]
		then
			line=$line$'\t'"1"
		else
			line=$line$'\t'"0"
		fi
	done < <(cat $ann/*.gff | awk -F "product=" '/\ttmRNA\t/ {print $2}' | awk -F ";" '{print $1}' | sort -u)
	echo -e "$line" >> $proj/R/tmRNA.tsv
done < $hq


sed -i 's/%2C/,/g' $proj/R/cds.tsv
sed -i 's/%2C/,/g' $proj/R/rRNA.tsv
sed -i 's/%2C/,/g' $proj/R/tRNA.tsv
sed -i 's/%2C/,/g' $proj/R/tmRNA.tsv


