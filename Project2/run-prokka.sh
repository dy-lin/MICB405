#!/bin/bash
# set -uo pipefail


proj="/projects/micb405/project1/Team10/project2"

# get the list of Archaea fastas
awk '{print $1}' /projects/micb405/resources/project_2/2019/SaanichInlet_120m/MetaBAT2_SaanichInlet_120m/gtdbtk_output/gtdbtk.ar122.classification_pplacer.tsv > $proj/list_arch.txt

# get the list of Bacteria fastas
awk '{print $1}' /projects/micb405/resources/project_2/2019/SaanichInlet_120m/MetaBAT2_SaanichInlet_120m/gtdbtk_output/gtdbtk.bac120.classification_pplacer.tsv  > $proj/list_bac.txt

dir=/projects/micb405/resources/project_2/2019/SaanichInlet_120m/MetaBAT2_SaanichInlet_120m/MedQPlus_MAGs


while read bacteria
do
	mag=$(echo "$bacteria" | sed 's/SaanichInlet_120m./MAG/')
	prokka --outdir $proj/Prokka_output --force --prefix $mag --kingdom Bacteria --cpus 8 --locustag $mag $dir/${bacteria}.fa
done < $proj/list_bac.txt

while read archaea
do
	mag=$(echo "$archaea" | sed 's/SaanichInlet_120m./MAG/')
	prokka --outdir $proj/Prokka_output --force --prefix $mag --kingdom Archaea --cpus 8 --locustag $mag $dir/${archaea}.fa
done < $proj/list_arch.txt

