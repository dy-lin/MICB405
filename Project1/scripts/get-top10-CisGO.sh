#!/bin/bash

dir=/projects/micb405/project1/Team10

grep -v '^#' $dir/CistromeGO/combined/Gene_Rank_By_Rank_Product.txt | sort -k8,8n > $dir/CistromeGO/combined/Gene_Rank_By_Rank_Product.sorted.txt

head -n10 $dir/CistromeGO/combined/Gene_Rank_By_Rank_Product.sorted.txt > $dir/CistromeGO/combined/Gene_Rank_By_Rank_Product.top10.txt
