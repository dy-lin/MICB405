#!/bin/bash

gtf=/projects/micb405/resources/STAR_tutorial/STAR_index_musmusculus_mm10/mm10.gtf

dir=/projects/micb405/project1/Team10
if [[ "$HOSTNAME" != "orca01.dmz.bcgsc.ca" ]]
then
    sed=/usr/local/bin/gsed
else
    sed=$(which sed)
fi

grep -v '^#!' $gtf | awk -F "\t" '/\tgene\t/ {print $9}' | awk -F "; " '{print $1, $3}' | $sed 's/gene_id //' | $sed 's/gene_name //' | $sed 's/\"//g' | $sed 's/ /,/' > $dir/CistromeGO/combined/gene_dict.csv





