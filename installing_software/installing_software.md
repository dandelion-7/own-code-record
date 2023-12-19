# Software installation

***
## Aspera, 23.4.5
```bash
> su
> lanlab
> conda install -c hcc aspera-cli -y
> which ascp
/miniconda3/bin/ascp
> ls /miniconda3/etc/asperaweb_id_dsa.openssh
/miniconda3/etc/asperaweb_id_dsa.openssh # key location
```

***
## MMSeqs2, 23.4.6
```bash
> conda create -n MMseqs2
> source activate MMseqs2
> (MMseqs2) conda install -c conda-forge -c bioconda mmseqs2
> (MMseqs2) mmseqs -h

# After downloading the uniref100 database
> cd ~/genome/uniref/mmseqs_uniref100_database
> mmseqs createdb uniref100.fasta.gz mmseqs_uniref100_db
> mmseqs createtaxdb seqTaxDB tmp
```

***
## MetaPhlAn3, 23.4.6
```bash
> conda create -n MetaPhlAn
> source activate MetaPhlAn
> (MetaPhlAn) conda install -c bioconda metaphlan
> (MetaPhlAn) which metaphlan
~/.conda/envs/MetaPhlAn/bin/metaphlan
# download metaphlan_index.zip and file_list.txt and upload them to ~/.conda/envs/MetaPhlAn/lib/python3.6/site-packages/metaphlan/metaphlan_databases, and unzip metaphlan_index.zip
# In ~/.conda/envs/MetaPhlAn/lib/python3.6/site-packages/metaphlan/metaphlan.py, modify the code of line ~460-470 as shown:
```
![metaphlan.py modification](1.metaphlan.py_modification.png) 
```bash
> metaphlan metagenome.fastq --input_type fastq -o metaphlan_test_out.txt # the reference is automatically constructed for the first running.
```

***
## MetaPhlAn4, 23.4.12
```bash
> cd /home/zhanggaopu/software/metaphlan

# metaphlan4 can't be installed with conda, so manually install.
> git clone https://github.com/biobakery/MetaPhlAn.git
> cd MetaPhlAn
> pip install .
> mkdir /home/zhanggaopu/software/metaphlan/bowtie2db
> metaphlan --install --bowtie2db /home/zhanggaopu/software/metaphlan/bowtie2db

# create an environment with dependencies of metaphlan4
> conda create -n mpa numpy Biopython python=3.7
> source activate mpa
> (mpa) conda install -c bioconda bowtie2

> (mpa) metaphlan metagenome.fastq --input_type fastq -o out.txt --bowtie2db /home/zhanggaopu/software/metaphlan/bowtie2db
# RAW of the container for running metaphlan should be >100G.

> (mpd) conda deactivate
```

***
## HUMAnN 3.0, 23.4.13
```bash
> mkdir ~/software/humann
> cd ~/software/humann

> wget https://files.pythonhosted.org/packages/79/02/184aef0cea1ad47be1dc5a9227096dbce5db190f6ed1f164e352f85ca257/humann-3.6.1.tar.gz
> tar -xzvf humann-3.6.1.tar.gz

> cd humann-3.6.1
> su # go to root to install since creating folders requires permission
lanlab
> python setup.py install
# exit root

# download the ChocoPhlAn databse
> mkdir ~/software/humann/humann_database
> cd ~/software/humann/humann_database
> humann_databases --download chocophlan full ~/software/humann/humann_database

# when performing humann_test, error is reported due to the too new version of metaphlan database. So use metaphlan to download a previous version (vJan21) of database, and specifically use it for humann.
> mkdir ~/software/metaphlan/bowtie2db_for_humann
> metaphlan --install --index mpa_vJan21_CHOCOPhlAnSGB_202103 --bowtie2db ~/software/metaphlan/bowtie2db_for_humann

# when use humann, use the --metaphlan-options to denote the position and the version of the database. 
> cd ~/software/humann/humann_test
> humann --input ../humann-3.6.1/examples/demo.fastq --output ../humann_test/demo_test.out/ --metaphlan-options "--bowtie2db /home/zhanggaopu/software/metaphlan/bowtie2db_for_humann --index mpa_vJan21_CHOCOPhlAnSGB_202103"

cd ~/software/humann/humann_database
mkdir chocophlan
mkdir uniref90
humann_databases --download chocophlan full chocophlan
humann_databases --download uniref uniref90_diamond uniref90

#------------------------------------------------------------------------------------------------
# The above methods requires performing installation in a new container. So the mpa virture environment of mpa is cloned, and humann is installed in the mpa env.
conda create -n humann --clone mpa
source activate mpa
cd ~/software/humann/humann-3.6.1
python setup.py install
```

***
## Crass 1.0.1, 23.4.20
```bash
> conda create -n crass
> source activate crass
> (crass) conda install -c conda-forge -c bioconda crass
> (crass) crass --version
CRisprASSembler (crass)
version 1 subversion 0 revison 1 (1.0.1)

> (crass) conda install -c bioconda cap3
> (crass) conda install -c bioconda velvet

# Some other packages were installed with conda. But seemed to be useless for crisprtools.
> (crass) conda install -c conda-forge xerces-c
> (crass) conda install -c anaconda libtool
> (crass) conda install -c anaconda make
> (crass) conda install -c conda-forge autoconf
> (crass) conda install -c anaconda automake
> (crass) conda install -c conda-forge gcc

> (crass) crisprtools
crass (1.0.1)
crass is a set of smal utilities for manipulating .crispr files
The .crispr file specification is a standard xml based format for describing CRISPRs
Type crass <subcommand> -h for help on each utility
Usage:	crass <subcommand> [options]

subcommand:  merge       combine multiple files
             help        display this message and exit
             extract     extract sequences in fasta
             filter      make new files based on parameters
             sanitise    change the IDs of elements
             stat        show statistics on some or all CRISPRs
             rm          remove a group from a .crispr file

# Graphviz is installed to visualize the .gv files of CRISPR assembly graph.
> (crass) conda install -c anaconda graphviz
```

***
## MinCED 0.4.2, 23.4.20
```bash
> conda create -n minced
> source activate minced
> (minced) conda install -c bioconda minced
> (minced) minced --help
> (minced) conda install -c bioconda seqkit
```

***
## MetaCrast, 23.4.20
```bash
# difficult to install, not done.
```
## seqspec for constructing library, 23.4.21
```bash
> pip install seqspec
> seqspec format --help
```

***
## ncbi-genome-download, 23.4.25
```bash
> conda create -n ngd
> source activate ngd
> (ngd) conda install -c bioconda ncbi-genome-download
> (ngd) ncbi-genome-download --help
```

***
## Kraken/Kraken2, 23.4.28
```bash
> conda create -n kraken
> source activate kraken
> (kraken) conda install -c bioconda kraken2
> (kraken) kraken2 --version
> (kraken) conda install -c conda-forge rsync

> (kraken) cd ~/genome/human/kraken_db
> (kraken) kraken2-build --download-library human --db human_db

> (kraken) kraken2-build --download-taxonomy --db human_db
# failed. Not fixed yet. kraken2 can't work now.
```

***
## fastp, 23.4.28
```bash
> conda create -n fastp
> source activate fastp
> (kraken) conda install -c bioconda fastp
> (kraken) fastp --help
```

***
## SPAdes, 23.4.29
```bash
> conda create -n spades
> source activate spades
> (spades) conda install -c bioconda spades
> (spades) spades.py --help
```

***
## MEGAHIT, 23.4.29
```bash
> conda create -n megahit
> source activate megahit
> (megahit) conda install -c bioconda megahit
> (megahit) megahit --help
```

***
## Graphviz, 23.5.2
```bash
> su 
lanlab
> (root) yum install graphviz
> which dot
```

***
## nextpolish, 23.5.23
```bash
> conda create -n nextpolish
> source activate nextpolish
> (nextpolish) conda install -c bioconda -c conda-forge nextpolish 
```

***
## Canu & quast, 23.5.23
```bash
> conda create -n canu
> source activate canu
> (canu) conda install -c bioconda canu
> (canu) conda install -c bioconda quast
```

***
## minimap2 & seqkit, 23.5.28
```bash
> conda create -n minimap
> sourcer activate minimap
> (minimap) conda install -c bioconda minimap2
> (minimap) conda install -c bioconda seqkit
```

***
## Crisprcasfinder, 23.5.31
```bash
> conda create -n crisprcasfinder
> source activate crisprcasfinder
> (crisprcasfinder) conda install -c bioconda macsyfinder=2.0
```

***
## cd-hit, 23.6.8
```bash
> conda create -n cdhit
> source activate cdhit
> (cdhit) conda install -c bioconda cd-hit
```

***
## checkM, 23.7.17
```bash
> conda create -n checkm python=3.9
> conda install -c bioconda numpy
> conda install -c bioconda matplotlib
> conda install -c bioconda -c conda-forge pysam
> conda install -c bioconda hmmer
> conda install -c bioconda pplacer
> conda install -c bioconda biopython
> conda install -c bioconda -c conda-forge biom-format
> conda install -c bioconda -c conda-forge cmseq
> conda install -c bioconda -c conda-forge h5py
> conda install -c bioconda -c conda-forge hclust2
> conda install -c bioconda pandas
> conda install -c phylophlan
> conda install -c bioconda requests

> pip3 install checkm-genome

> cd ~/software/checkm/
> wget https://data.ace.uq.edu.au/public/CheckM_databases/checkm_data_2015_01_16.tar.gz -c
> tar -xzvf checkm_data_2015_01_16.tar.gz
# decompress the gz file
> checkm data setRoot checkm_data_2015_01_16/
```
![Alt text](image.png)

***
## VirSorter2, 23.9.15
```bash
# Install with the option 1 from https://github.com/jiarong/VirSorter2
mamba create -n vs2 -c conda-forge -c bioconda virsorter=2
source activate vs2

# Download and setup the database.
virsorter setup -d db -j 4

# No numpy package is downloaded with the conda/memba install, so the numpy package in the /.local python site-packages will be called, which will lead to AttributeError.
# Install numpy<1.24 in the vs2 env.
conda install "numpy<1.24"

# Disable the user site-packages directory /.local by setting to False.
python -m site -help 
#/home/zhanggaopu/.conda/envs/vs2/lib/python3.10/site.py [--user-base] [--user-site]
# ENABLE_USER_SITE = None > ENABLE_USER_SITE = False
```
Ref: https://github.com/python/cpython/blob/f59c0932b4e160f279fb98de4cdad2f58269e0a5/Lib/site.py#L79-L81

***
## CRISPRcasTyper (cctyper)
```bash
conda create -n cctyper -c conda-forge -c bioconda -c russel88 cctyper
```

***
## GTDB-tk
GTDB-tk is for annotating the taxonomy of bacterial/archaeal genomes.
```bash
conda create -n gtdbtk
source activate gtdbtk
conda install -c bioconda gtdbtk
# manually dowload the gtdbtk database to my PC and upload to the server ~/software/gtdbtk
cd ~/software/gtdbtk
mkdir gtdbtk_db
tar -zxvf gtdbtk_r207_v2_data.tar.gz -c ~/software/gtdbtk/gtdbtk_db --strip-components=1 > /dev/null
conda env config vars set GTDBTK_DATA_PATH=~/software/gtdbtk/gtdbtk_db
```
    Executing transaction:
    GTDB-Tk v2.1.0 requires ~63G of external data which needs to be downloaded
    and extracted. This can be done automatically, or manually.

    Automatic:

        1. Run the command "download-db.sh" to automatically download and extract to:
            /home/zhanggaopu/.conda/envs/gtdbtk/share/gtdbtk-2.1.0/db/

    Manual:

        1. Manually download the latest reference data:
            wget https://data.gtdb.ecogenomic.org/releases/release207/207.0/auxillary_files/gtdbtk_r207_v2_data.tar.gz

        2. Extract the archive to a target directory:
            tar -xvzf gtdbtk_r207_v2_data.tar.gz -c "/path/to/target/db" --strip 1 > /dev/null
            rm gtdbtk_r207_v2_data.tar.gz

        3. Set the GTDBTK_DATA_PATH environment variable by running:
            conda env config vars set GTDBTK_DATA_PATH="/path/to/target/db"
***

## geNomad
geNomad is primarily for identifying virus and plasmids in sequence data (isolates, metagenomes, and metatranscriptomes). It also provides additional features for taoxonomic assignment of viral genomes, identification of viruses integrated in host genomes (proviruses), and functional annotations of proteins.
```bash
conda create -n genomad -c conda-forge -c bioconda genomad
mkdir ~/software/genomad/; cd ~/software/genomad/
genomad download-database .
```
Ref:https://github.com/apcamargo/genomad
***

## vContact2
vConTACT2 is a tool to perform guilt-by-contig-association classification of viral genomic sequence data. It's designed to cluster and provide taxonomic context of viral metagenomic sequencing data.
```bash
conda create -n vcontact2
source activate 
conda install -y -c bioconda vcontact2 mcl blast diamond
conda install -c bioconda clusterone
conda install "numpy<1.24"

vcontact2 --raw-proteins VIRSorter_genome.faa --proteins-fp VIRSorter_genome_g2g.csv --db 'ProkaryoticViralRefSeq211-Merged' --output-dir ../test_out/ --vcs-mode ClusterONE # example running, failed.
```
vContact2 is not being maintained anymore. Failed to run test samples.
***

## CRISPRclassify
```R
library(devtools)
library(stringr)
library(tidyverse)
library(DT)
library(xgboost)
library(memoise)
#install.packages('stringdist')
library(stringdist)
#install_github("CRISPRlab/CRISPRclassify")
CRISPRclassify::launchApp()
getwd()
CRISPRclassify::classifyRepeats('~/crisprome/human_temporal_metagenome_wangjun_2022natComm/intermediates/7.crisprtools_extract/CRISPRclassify_test/3_3_TD24_repeats.txt')
CRISPRclassify::classifyFasta('~/crisprome/artifical_microbiome/genomes/RG_Ruminococcus_gnavus_ATCC_29149.fasta')
```
CRISPRclassify doesn't work on Rstudio or command line.
***

## PILER-CR
```bash
source activate crispr-softwares
conda install -c bioconda piler-cr
```
***

## seqkit
```bash
source activate crispr-softwares/seqkit
conda install -c bioconda seqkit
```
***

## defense-finder
```bash
conda create -n defensefinder --clone mpa
source activate defensefinder
pip install mdmparis-defense-finder
conda install -c bioconda hmmer
conda install -c bioconda prodigal
conda install -c bioconda seqkit
```
***

## DAS Tool
```bash
conda create -n das_tool R
source activate das_tool

conda install -c conda-forge r-docopt
conda install -c conda-forge r-magrittr
conda install -c conda-forge r-data.table
conda install -c bioconda metabat2
conda install -c bioconda -c conda-forge maxbin2
conda install -c bioconda -c conda-forge concoct # concoct can't be installed with conda.
conda install -c anaconda cython
conda install -c bioconda numpy
mamba install -c bioconda -c conda-forge prodigal
mamba install -c bioconda -c conda-forge diamond pullseq ruby


### CONCOCT is installed independently in another conda virtue env.
conda create -n concoct
source activate concoct
conda install -c bioconda -c conda-forge concoct
concoct -h
```

## DIAMOND
```bash
cd ~/software/diamond
wget http://github.com/bbuchfink/diamond/releases/download/v2.1.8/diamond-linux64.tar.gz
tar xzf diamond-linux64.tar.gz

# create diamond database with UHGP.
~/software/diamond/diamond makedb --in ~/genome/UHGP/uhgp.faa --db ~/genome/UHGP/total_uhgp_diamond_db/uhgp --threads 64
# test diamond blastx/blastp.
~/software/diamond/diamond blastp -d ~/genome/UHGP/total_uhgp_diamond_db/uhgp.dmnd -o matches.tsv -q 2_long_contigs.part_277_proteins.fasta
```

## snakemake & prokka & binny
```bash
mamba create -c conda-forge -c bioconda -n snakemake snakemake
mamba activate snakemake

snakemake --help
conda install -c conda-forge -c bioconda -c defaults prokka

cd ~/software/binny
git clone https://github.com/a-h-b/binny.git 
```
snakemake and prokka are installed in the env, but binny was only cloned but not configured.

## maxbin2
A new maxbin2 env is created with mamba.
```bash
mamba create -n maxbin2 -c bioconda -c conda-forge maxbin2
mamba activate maxbin2
```

## Mummer
```bash
mamba create --name mummer mummer -c bioconda -c conda-forge
```

## Taxonkit
```bash
conda create -n taxonkit
source activate taxonkit
mamba install -c conda-forge -c bioconda taxonkit

# prepare the database for taxonkit.
cd /home/zhanggaopu/software/taxonkit
wget -c https://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz 
tar -zxvf taxdump.tar.gz
mkdir -p $HOME/.taxonkit
cp names.dmp nodes.dmp delnodes.dmp merged.dmp $HOME/.taxonkit
mamba install csvtk -c bioconda -c conda-forge
```

## flye & medaka (for ONT de novo genome assembly)
```
conda create -n flye python=3.9
source activate flye

mamba install -c bioconda -c conda-forge flye
mamba isntall -c bioconda -c conda-forge medaka
```
