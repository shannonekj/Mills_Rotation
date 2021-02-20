#!/bin/bash
#QC_filtered_reads.sh

#SBATCH --mail-user=sejoslin@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name=QC_filtered_reads
#SBATCH --error=QC_filtered_reads.err
#SBATCH --partition=med
#SBATCH --account=millsgrp

#run with
# sbatch -p med -A millsgrp -t 3-00:00:00 --mem MaxMemPerNode QC_filtered_reads.sh

#set up environment
set -e
module load perlbrew fastx

#save code directory & navigate to working directory
cwd=$(pwd)
cd /group/kmkalangrp/SEKJ_work/simulated_metagenomes/Hsap_contam_metasim_db

date

### FIRST convert MetaSim files into single line fasta files
for i in *.fna
do
#setup input highH_highB_totAbund-Empirical.8c74c739.fna
#example output highH_highB_totAbund-Empirical.8c74c739.fa
out=$(echo $i | cut -d. -f 1-2).fa
echo "Starting " $i
fasta_formatter -i $i -o $out
echo "Done creating " $out
date
done

### NEXT clip reads that contain N's
for i in *.fa
do
echo "Starting " $i
fastx_clipper -a NNNN -v -i $i -o QC_filtered_reads/$i
echo "Done with " $i
done
