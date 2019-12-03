# Files

* `HQ_QC_RPKM_Taxonomy.tsv`
	* RPKM and Taxonomy summary for high quality MAGs
* `HQ_QC_plot.png`
	* Contamination vs Completeness plot of high quality MAGs
* `HQmags.renamed.txt`
	* List of high quality MAGs, renamed with `MAG`
* `KO_MAG_unique.processed.tsv`
	* List of KOs unique to each high quality MAG
* `KO_MAG_unique.txt`
	* Long version of above, with one KO and one MAG per line
* `MedQmags.renamed.txt`
	* List of medium quality MAGs, renamed with `MAG`
* `MetaBAT2_SaanichInlet_120m_min1500_checkM_stdout.renamed.processed.tsv`
	* same as file below but with `x__` and `(UIDXXX)` removed from the `Mark lineage` columns
* `MetaBAT2_SaanichInlet_120m_min1500_checkM_stdout.renamed.tsv`
	* same as file below but with `SaanichInlet_120M.` replaced with `MAG`
* `MetaBAT2_SaanichInlet_120m_min1500_checkM_stdout.tsv`
	* raw file from `/projects/micb405/resources/project_2/2019/SaanichInlet_120m/MetaBAT2_SaanichInlet_120m/MetaBAT2_SaanichInlet_120m_min1500_checkM_stdout.tsv`
* `Prokka_genes.png`
	* barplot of Prokka genes
* `QC.R`
	* Rscript for generating the QC plot
* `QC_plot.png`
	* First attempt at the QC plot
* `SI072_120m_metaT_rpkm.csv`
	* raw file from `/projects/micb405/resources/project_2/2019/SaanichInlet_120m/SI072_120m_metaT_rpkm.csv`
* `SI072_120m_metaT_rpkm.renamed.csv`
	* same as file above but with `SaanichInlet_120M.` replaced with `MAG`
* `SI072_120m_metaT_rpkm.renamed.processed.csv`
	* same as file above but processed
* `SaanichInlet_120m_binned.rpkm.csv`
	* metagenomic RPKM file
* `SaanichInlet_120m_binned.rpkm.renamed.processed.csv`
	* same file as above but renamed with `MAG`
* `SaanichInlet_MAG120m_ORFs_ko.cleaned.txt`
	* KO numbers from high quality MAG ORFs
* `cds.tsv`
	* upset plot input for CDS
* `cds_upset_deg.png`
	* upset plot for CDS by degree
* `cds_upset_freq.png`
	* upset plot for CDS by frequency
* `completeness_contamination_labelled.png`
	* contamination vs completeness plot with labelled sectors
* `coverage.png`
	* RPKM bar plot
* `find-KO-MAG-unique.sh`
	* bash script to find KOs unique to one MAG
* `find-hq.sh`
	* bash script to find high quality MAGs out of the medium quality plus MAGs
* `gen-upset.sh`
	* bash script to manipulate the data to generate an upset plot
* `generate-prokka-mag-map.sh`
	* bash script to generate Prokka ORF/MAG map
* `get-hq-genes.sh`
	* bash script to extract all the genes from high quality MAGs
* `group_rpkm_orfs.sh`
	* bash script to group ORFs and RPKM data into each marker lineage present in MAGs
* `gtdbtk.ar122.classification_pplacer.tsv`
	* raw file from `/projects/micb405/resources/project_2/2019/SaanichInlet_120m/MetaBAT2_SaanichInlet_120m/gtdbtk_output/gtdbtk.ar122.classification_pplacer.tsv`
* `gtdbtk.bac120.classification_pplacer.tsv`
	* raw file from `/projects/micb405/resources/project_2/2019/SaanichInlet_120m/MetaBAT2_SaanichInlet_120m/gtdbtk_output/gtdbtk.bac120.classification_pplacer.tsv`
* `gtdbtk.both.classiication_pplacer.renamed.processed.tsv`
	* same as file below but with `SaanichInlet_120m.` replaced with `MAG`
* `gtdbtk.both.classiication_pplacer.tsv`
	* concatenated file of `ar122` and `bac120` files above
* `hq_cov.png`
	* RPKM bar plot for high quality MAGs only
* `plot-upset.R`
	* R script to plot upset plots
* `prepPathView.r`
	* R script to create Pathview figures
* `process-KAAS.sh`
	* bash script to remove MAG ORFs without a KO annotation
* `prokka-summary.R`
	* R script to summarize Prokka genes
* `prokka.summary.processed.tsv`
	* TSV file resulting from `prokka-summary.R` 
* `prokka.summary.tsv`
	* TSV file resulting from `prokka-summary.R` (longer version)
* `rRNA.tsv`
	* upset plot input for rRNA
* `rRNA_upset_deg.png`
	* upset plot for rRNA by degree
* `rRNA_upset_freq.png`
	* upset plot for rRNA by frequency
* `rename-mags.sh`
	* bash script to rename `SaanichInlet_120m.` to `MAG`
* `rpkm.R`
	* R script to plot metagenomic vs metatranscriptomic RPKM
* `summarize-prokka.sh`
	* bash script to generate TSV file to input to `prokka-summary.R`
* `tRNA.tsv`
	* upset plot input for tRNA
* `tRNA_upset_deg.png`
	* upset plot for tRNA by degree
* `tRNA_upset_freq.png`
	* upset plot for tRNA by frequency
* `tmRNA.tsv`
	* upset plot input for tmRNA
* `tmRNA_upset_deg.png`
	* upset plot for tmRNA by degree
* `tmRNA_upset_freq.png`
	* upset plot for tmRNA by frequency
* `upset.tsv`
	* upset plot input for KO
* `upset_deg.png`
	* upset plot for KO by degree
* `upset_freq.png`
	* upset plot for KO by frequency
