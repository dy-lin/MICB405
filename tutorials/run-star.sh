#!/bin/bash

mkdir -p $HOME/References/STAR_tutorial_mus_musculus_GRCm38/
cd $HOME/References/STAR_tutorial_mus_musculus_GRCm38/

wget ftp://ftp.ensembl.org/pub/release-98/fasta/mus_musculus/dna/Mus_musculus.GRCm38.dna.primary_assembly.fa.gz
wget ftp://ftp.ensembl.org/pub/release-98/gtf/mus_musculus/Mus_musculus.GRCm38.98.gtf.gz

GENOME_DIR=/projects/micb405/resources/STAR_tutorial/STAR_index_musmusculus_mm10/
GENOME_FASTA=$HOME/References/STAR_tutorial_mus_musculus_GRCm38/Mus_musculus.GRCm38.dna.primary_assembly.fa
GENOME_GTF=$HOME/References/STAR_tutorial_mus_musculus_GRCm38/Mus_musculus.GRCm38.98.gtf

STAR --runThreadN 30 \
	--runMode genomeGenerate \
	--genomeDir $GENOME_DIR \
	--genomeFastaFiles $GENOME_FASTA \
	--sjdbGTFfile $GENOME_GTF \
	--sjdbOverhang 74 &

# Index:
# /projects/micb405/resources/STAR_tutorial/STAR_index_musmusculus_mm10/

RNA_SEQ_R1=/projects/micb405/data/mouse/project_1/RNA-seq/Primary_1.1.fastq
RNA_SEQ_R2=/projects/micb405/data/mouse/project_1/RNA-seq/Primary_2.1.fastq

mkdir -p $HOME/ProcessedData/STAR_tutorial_resultsmm10/

OUTPUT_FOLDER=$HOME/ProcessedData/STAR_tutorial_resultsmm10/

STAR --genomeDir $GENOME_DIR \
	--runThreadN 1 \
	--readFilesIn $RNA_SEQ_R1 $RNA_SEQ_R2 \
	--outFileNamePrefix $OUTPUT_FOLDER/primary_set1 \
	--outSAMtype BAM SortedByCoordinate \
	--outSAMunmapped Within \
	--outSAMattributes Standard

RNA_SEQ_SET=(/projects/micb405/data/mouse/project_1/RNA-seq/Primary_1.2.fastq /projects/micb405/data/mouse/project_1/RNA-seq/Primary_1.3.fastq)
OUTPUT_FOLDER=$HOME/ProcessedData/STAR_tutorial_resultsmm10/
GENOME_DIR=/projects/micb405/resources/STAR_tutorial/STAR_index_musmusculus_mm10/
GENOME_FASTA=$HOME/References/STAR_tutorial_mus_musculus_GRCm38/Mus_musculus.GRCm38.dna.primary_assembly.fa
GENOME_GTF=$HOME/References/STAR_tutorial_mus_musculus_GRCm38/Mus_musculus.GRCm38.98.gtf

for i in ${RNA_SEQ_SET[@]}
do
	OUTPREFIX=$(basename ${i%%.fastq})
	OUTPREFIX=primary_set${OUTPREFIX#Primary_1.}
	echo "Starting alignment for" $OUTPREFIX
	STAR --genomeDir $GENOME_DIR \
		--runThreadN 30 \
		--readFilesIn $i ${i/mary_1/mary_2} \
		--outSAMtype BAM SortedByCoordinate \
		--outSAMunmapped Within \
		--outSAMattributes Standard
done

GENOME_GTF=$HOME/References/STAR_tutorial_mus_musculus_GRCm38/Mus_musculus.GRCm38.98.gtf

RNA_BAM_1=$HOME/STAR_tutorial_resultsmm10/primary_set1Aligned.sortedByCoord.out.bam
mkdir -p $HOME/STAR_tutorial_resultsmm10/STAR_primary_rna-seq_qc
cd ~ 
wget http://hartleys.github.io/QoRTs/QoRTs-STABLE.jar

java -jar $HOME/QoRTs-STABLE.jar QC \
	$RNA_BAM_1 \
	$GENOME_GTF \
	$HOME/STAR_tutorial_resultsmm10/STAR_primary_rna-seq_qc

htseq-count \
	-f bam \
	-m union \
	-i gene_id \
	-r pos \
	-s no \
	${RNA_BAMS[@]}  \
	$GENOME_GTF > htseq_counts_star.txt


