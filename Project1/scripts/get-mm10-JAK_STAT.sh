#!/bin/bash

dir=/projects/micb405/project1/Team10

# find the JAK/STAT pathway proteins that are present in the mm10 annotation
grep -if <(tail -n +2 $dir/CistromeGO/combined/JAK_STAT.full.txt) gene_dict.csv > $dir/CistromeGO/JAK_STAT_mm10.csv






