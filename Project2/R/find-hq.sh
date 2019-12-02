#!/bin/bash

awk -F "\t" '{if($12>90 && $13<5) {print $1}}' /projects/micb405/resources/project_2/2019/SaanichInlet_120m/MetaBAT2_SaanichInlet_120m/MetaBAT2_SaanichInlet_120m_min1500_checkM_stdout.tsv > /projects/micb405/project1/Team10/project2/HQ_mags.txt
