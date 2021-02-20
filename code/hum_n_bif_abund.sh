#!/bin/bash
#hum_n_bif_abund.sh
# greps for Bifido and Human in metasim outputs
#SBATCH --mail-user=sejoslin@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name=counts_h_b
#SBATCH --error=hum_n_bif_abund.err
#SBATCH --partition=med
#SBATCH --account=millsgrp

#run with sbatch -p med -A millsgrp -t 1-12:00:00 --mem MaxMemPerNode hum_n_bif_abund.sh
cwd=$(pwd)

cd ../simulated_metagenomes/Hsap_contam_metasim_db/

for i in *.fna
do
newname=Bifido_$(echo $i | cut -d. -f2).txt
grep -n "Bifidobacterium" $i > abund_check/$newname
done &

for i in *.fna
do
newname=Homo_$(echo $i | cut -d. -f2).txt
grep -n "Homo" $i > abund_check/$newname
done &
