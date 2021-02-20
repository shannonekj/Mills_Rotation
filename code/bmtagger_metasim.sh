#!/bin/bash
#bmtagger_metasim.sh
#
#SBATCH --mail-user=sejoslin@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name=bmtagger_metasim
#SBATCH --error=bmtagger_metasim.err
#SBATCH --partition=med
#SBATCH --account=millsgrp

# run with
# sbatch -p med -A millsgrp -t 5-36:00:00 --mem MaxMemPerNode bmtagger_metasim.sh

set -e
module load blast srprism bmtools
cwd=$(pwd)
metasim="/group/kmkalangrp/SEKJ_work/simulated_metagenomes/Hsap_contam_metasim_db/bmtagger_output"


cd ../bmtagger

for i in ../simulated_metagenomes/Hsap_contam_metasim_db/*.fna
do
tag=bmtagger_$(echo $i | cut -d. -f4)
outfile=$(echo $i | cut -d. -f4)
bmtagger.sh -b hs37.bitmask -x hs37.srprism -q 0 -1 $i -o $metasim/$tag/$outfile.human
done

date
