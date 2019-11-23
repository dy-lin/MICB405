#!/bin/bash

dir=/projects/micb405/project1/Team10/project2/Prokka_output/HQ_MAGs

echo -e "MAG\tNumber\tFeature" > $dir/prokka.summary.tsv
for i in $dir/*.tsv
do
	j=$(basename $i ".tsv")
	awk -F "\t" '{print $2}' $i | sort | uniq -c | sed "s/^/$j/" | sed 's/\s\+/\t/g' | sed '/ftype/d' >> $dir/prokka.summary.tsv
done

sed -i '/prokka/d' $dir/prokka.summary.tsv
