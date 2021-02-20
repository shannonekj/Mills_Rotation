#!/bin/bash
#
#SBATCH --mail-user=sejoslin@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name=deconseq_metasim_QC
#SBATCH --error=deconseq_metasim_QC.err
#SBATCH --partition=med
#SBATCH --account=millsgrp

set -e

# run with:
# sbatch -p med -A millsgrp -t 6-36:00:00 --mem MaxMemPerNode deconseq_metasim_QC.sh
#tell slurm output what you are doing
echo "Decontamination of QC'd MetaSim files"

module load deconseq
cwd=$(pwd)

out_dir="/group/kmkalangrp/SEKJ_work/simulated_metagenomes/Hsap_contam_metasim_db/deconseq_QC_output"
work_dir="/group/kmkalangrp/SEKJ_work/deconseq-standalone-0.4.3"
file_dir="/group/kmkalangrp/SEKJ_work/simulated_metagenomes/Hsap_contam_metasim_db/QC_filtered_reads"

#in order to run deconseq you have to have the human database in your working directory
cd $work_dir

date

for i in $file_dir/*.fa
do
echo "Starting " $i
name=deconseq_$(echo $i | cut -d. -f2).i90.c90 # ex. highH_highB_totAbund-Empirical.8c74c739.fa
perl deconseq.pl \
-f $i -dbs hsref -i 90 -c 90 -out_dir $out_dir/$name
echo "Finished " $i date
done
