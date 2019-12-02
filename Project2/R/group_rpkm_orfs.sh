#! /bin/bash

cd ./HQMQ_groups

for f in /projects/micb405/project1/Team10/project2/HQMQ_groups/*; do
	while IFC="" read -r MAG remainder; do
		cat ../rpkm_output/*_MAGs/$MAG.csv >> SaanichInlet_120m_MAG_ORFs_rpkm_${f##*/}.txt
		grep ${MAG}_ ../SaanichInlet_HQ_MAG_ORFs_ko.cleaned.txt >> SaanichInlet_120m_MAG_ORFs_KO.cleaned_${f##*/}.txt
		grep ${MAG}_ ../SaanichInlet_MedQ_MAG_ORFs_ko.cleaned.txt >> SaanichInlet_120m_MAG_ORFs_KO.cleaned_${f##*/}.txt
	done < $f
done
