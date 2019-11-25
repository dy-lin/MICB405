#!/bin/bash

data=/projects/micb405/project1/Team10/project2/SaanichInlet_MAG120m_ORFs_ko.cleaned.txt

hq=/projects/micb405/project1/Team10/project2/HQmags.renamed.txt

outdir=/projects/micb405/project1/Team10/project2/

ko=$(sed 's/_.\+\t/\t/' $data | grep -wf $hq | awk -F "\t" '{print $2}' | sort -u)

echo -e "MAG\t$(echo "$ko" | tr '\n' '\t')" > $outdir/upset.tsv

 while read mag
 do
	 line="$mag"
	 for k in $ko
	 do
#		 echo $k
		 if [[ "$(grep ${mag}_ $data | grep -c $k)" -gt 0 ]]
		 then
			 line=$line$'\t'"1"
		 else
			 line=$line$'\t'"0"
		 fi
	done
	echo -e "$line" >> $outdir/upset.tsv
 done < $hq

sed -i 's/\t$//' $outdir/upset.tsv

