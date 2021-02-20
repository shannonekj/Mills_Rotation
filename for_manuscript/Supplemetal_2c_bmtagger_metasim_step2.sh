#!/bin/bash
#bmtagger_metasim_step2.sh
#
#SBATCH --mail-user=sejoslin@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name=bmtagger_metasim_filter
#SBATCH --error=bmtagger_metasim_filter.err
#SBATCH --partition=med
#SBATCH --account=millsgrp

# run with
# sbatch -p med -A millsgrp -t 2-36:00:00 --mem MaxMemPerNode bmtagger_metasim_step2.sh
#tell slurm output what you are doing
echo "Pulling reads deemed human by BMTagger"

set -e
module load java bbmap
cwd=$(pwd)
metasim="/group/kmkalangrp/SEKJ_work/simulated_metagenomes/Hsap_contam_metasim_db/bmtagger_output"

cd ../bbmap

echo "Start time: " date

#print a file that SHOULD not have human reads in it
for i in ../simulated_metagenomes/Hsap_contam_metasim_db/*.fna
do
tag=bmtagger_$(echo $i | cut -d. -f4)
outfile=$(echo $i | cut -d. -f4).clean.fasta
names=$(echo $i | cut -d. -f4).human
filterbyname.sh in=$i out=$metasim/$tag/$outfile names=$metasim/$tag/$names include=f
done

# print a file that has the human reads in it
for i in ../simulated_metagenomes/Hsap_contam_metasim_db/*.fna
do
tag=bmtagger_$(echo $i | cut -d. -f4)
outfile=$(echo $i | cut -d. -f4).cont.fasta
names=$(echo $i | cut -d. -f4).human
filterbyname.sh in=$i out=$metasim/$tag/$outfile names=$metasim/$tag/$names include=t
done

echo "Finish time: " date

