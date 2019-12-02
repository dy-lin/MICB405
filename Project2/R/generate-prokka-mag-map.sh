#! /bin/bash

for f in /projects/micb405/project1/Team10/project2/Prokka_output/HQ_MAGs/*faa; do
	prokka_id=$( head -1 $f | awk -F_ '{ print $1 }' | sed 's/^>//g' )
	mag_id=$( echo $f | sed 's/.faa//g')
	echo $prokka_id,$mag_id
done >Prokka_MAG_map.csv
