#MICB405 Project 3: Microbiome Data Analysis
As in the previous 2 projects, you will work in teams to tackle challenging datasets in the field of bioinformatics. Project 3 focuses on the 16S iTag (also known as amplicon) data associated with the same sample for which you analyzed metagenomics in the last project. This project will focus more on your development and assessment of a pipeline as opposed to the previous projects that focused on biological results interpretation.

Your group will process the **same sample depth** as in project 2.

##Timeline
The project will be conducted over 3 classes and 1 tutorial:

1. Nov 23, 2017 (class): Introduction to the topic area and the datasets
2. Nov 24, 2017 (tutorial): Team work with TAs
    + Your goal is to get alignment running by the end of the tutorial.
3. Nov 28, 2017 (class): Team work with TAs and Instructors
4. Nov 30, 2017 (class): Team presentations

##Tools
We will be using one of the most popular tag analysis programs: [mothur](https://www.mothur.org/). You may have also heard of the equally popular [QIIME2](https://qiime2.org/). Both have their strengths and weaknesses and our choice to use mothur in this course lies mainly with the instructor's personal preference, not any insight that mothur is inherently better than QIIME2 at processing this data. If you want a very in-depth comparison of the two programs, check out this [blog](http://blog.mothur.org/2016/01/12/mothur-and-qiime/).

The main file types we will work with are:

* .fasta/.align = the sequences
* .groups = which sequences occur in each sample (*i.e.* group) and at what frequencies
* .names = which sequences are identical to each other
* .count_table = combination of .groups and .names data into 1 file

##Data
Water was collected from various depths at Saanich Inlet and filtered through a 0.22 μm Sterivex filter to collect biomass. Total genomic DNA was extracted from these filters. Amplicon sequencing of the variable 4 through 5 (V4-V5) region of the small subunit (16S) rRNA gene was then performed. These data were generated on the Illumina MiSeq platform with **2x300bp** technology.

For more in-depth methods, please see [Hawley AK *et al* 2017](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5663217/) "A compendium of multi-omic sequence information from the Saanich Inlet water column" Sci Data 4: 170160.

Datasets for this project have been uploaded to the orca docker here:

kdmcfarland@kdmcfarland-ORCA:/home/micb405/data/project_3$ ls

SI072_S3_010_1.fastq  
SI072_S3_010_2.fastq  
SI072_S3_100_1.fastq  
SI072_S3_100_2.fastq  
SI072_S3_120_1.fastq  
SI072_S3_120_2.fastq  
SI072_S3_135_1.fastq  
SI072_S3_135_2.fastq  
SI072_S3_150_1.fastq  
SI072_S3_150_2.fastq  
SI072_S3_165_1.fastq  
SI072_S3_165_2.fastq  
SI072_S3_200_1.fastq  
SI072_S3_200_2.fastq  

The files are names as cruiseID_station_depth_read.fastq. So for example, SI072_S3_010_1.fastq is the first read file for the **10 m sample** at station S3 on cruise 72.

Given our data type, could **fastQC** be of interest here? *hint hint*

##Databases
In order to perform alignment and taxonomic classification, we will use the [Silva](http://nar.oxfordjournals.org/content/35/21/7188.full) and [GreenGenes](http://aem.asm.org/content/72/7/5069.full) databases. mothur-formatted databases are available for [Silva](https://www.mothur.org/wiki/Silva_reference_files) and [GreenGenes](https://mothur.org/wiki/Greengenes-formatted_databases) and have been uploaded to the orca docker here:

kdmcfarland@kdmcfarland-ORCA:/home/micb405/data/project_3/databases$ ls

gg_13_8_99.fasta  
gg_13_8_99.gg.tax  
silva.nr_v128.align  
silva.nr_v128.tax  

Please **do not** copy the fastqs or databases to your own directory as we have limited space. Simply call them using their full path within mothur commands.

##Pipeline
The general [mothur workflow]() is available through GitHub.

###Long steps
When you are running commands that take significant time to complete (like alignment and clustering), you should run mothur in [command line mode](https://www.mothur.org/wiki/Command_line_mode) in a BASH script and allow it to run in the background. Be sure to start all scripts with `set.dir(output=)` to save all your output files in your folder and not the shared data folder.

Unfortunately, nohup does not play well with mothur so we will use another option for background processes. For these long step, input `script /dev/null` and then run your shell script `bash my_script.sh`. To check if your script is done, look in the mothur.logfile and/or use `top`.

Most mothur functions can be run on multiple processors. However, this dramatically increases RAM usage so **please only run mothur on 1 processor**. mothur is also not great at outputting an error when 1 processor fails but another completes. This would result in you moving forward with incomplete data and not knowing until a later step fails.

###Customization
We have not provided all function parameters for all the steps in mothur. Every dataset is unique and we're always looking to customize a pipeline to best fit the given data. So, your challenge is to determine the best parameters.

The [mothur command help page](https://www.mothur.org/wiki/Category:Commands) provides detailed information on every possible function in mothur.