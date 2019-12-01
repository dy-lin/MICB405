#!/bin/bash

# get number of columns in the upset.tsv
ncol=$(awk -F "\t" '{print NF}' <(head -n1 upset.tsv))

# iterate through each column except the first one
for i in $(seq 2 $ncol)
do 
	# get the count of how many 1's per column
	# if there is only a single 1 in that column, that KO is unique to a certain MAG
	count=$(awk -F "\t" -v var="$i" '{print $var}' upset.tsv | grep -c "1"); 
	# KO is unique to a certain MAG, get MAG and KO
	if [[ "$count" -eq 1 ]]
	then 
		ko=$(awk -F "\t" -v var="$i" '{print $var}' <(head -n1 upset.tsv))
		mag=$(awk -F "\t" -v var="$i" '{if($var==1) {print $1}}' upset.tsv)
		echo -e "$mag\t$ko"
	fi
done | sort -k1,1 > KO_MAG_unique.txt

# write into a tsv of MAG,KO,KO,KO,KO

# iterate through unique MAGs
for i in $(awk -F "\t" '{print $1}' KO_MAG_unique.txt | sort -u)
do
	echo -e "$i\t$(grep -w $i KO_MAG_unique.txt | awk -F "\t" '{print $2}' | tr '\n' '\t')"
done > KO_MAG_unique.processed.tsv
