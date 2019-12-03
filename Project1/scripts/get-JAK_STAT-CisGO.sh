#!/bin/bash

dir=/projects/micb405/project1/Team10

cisgo=$dir/CistromeGO/combined/Gene_Rank_By_Rank_Product.txt

# find if those JAK/STAT proteins in the mm10 annotation are in the combined CisGo results
grep -f <(awk -F "," '{print $2}' $dir/CistromeGO/JAK_STAT_mm10.csv) $cisgo > $dir/CistromeGO/combined/JAK_STAT_CistromeGO.txt

sort -k8,8n $dir/CistromeGO/combined/JAK_STAT_CistromeGO.txt > $dir/CistromeGO/combined/JAK_STAT_CistromeGO.sorted.txt

