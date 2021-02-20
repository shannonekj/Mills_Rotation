#!/bin/bash 
#
#SBATCH --mail-user=sejoslin@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name=deconseq_metasim
#SBATCH --error=deconseq_metasim.err
#SBATCH --partition=med
#SBATCH --account=millsgrp

set -e

# run with:
# sbatch -p med -A millsgrp -t 1-36:00:00 --mem MaxMemPerNode deconseq_metasim.sh

module load deconseq
cwd=$(pwd)

#highH_highB
date
echo "starting high human, high Bifido"
perl ../deconseq-standalone-0.4.3/deconseq.pl -f ../simulated_metagenomes/Hsap_contam_metasim_db/highH_highB_totAbund-Empirical.8c74c739.fna \
-dbs hsref -i 90 -c 90 -out_dir ../simulated_metagenomes/Hsap_contam_metasim_db/deconseq_output/deconseq_8c74c739
echo "finished"

#highH_lowB
date
echo "starting high human, low Bifido"
perl ../deconseq-standalone-0.4.3/deconseq.pl -f ../simulated_metagenomes/Hsap_contam_metasim_db/highH_lowB_totAbund-Empirical.8c82190a.fna \
-dbs hsref -i 90 -c 90 -out_dir ../simulated_metagenomes/Hsap_contam_metasim_db/deconseq_output/deconseq_8c82190a
echo "finished: "

#lowH_highB
date
echo "starting low human, high Bifido"
perl ../deconseq-standalone-0.4.3/deconseq.pl -f ../simulated_metagenomes/Hsap_contam_metasim_db/lowH_highB_totAbund-Empirical.8c8f48af.fna \
-dbs hsref -i 90 -c 90 -out_dir ../simulated_metagenomes/Hsap_contam_metasim_db/deconseq_output/deconseq_8c8f48af
echo "finished: "

#lowH_lowB
date
echo "starting low human, low Bifido"
perl ../deconseq-standalone-0.4.3/deconseq.pl -f ../simulated_metagenomes/Hsap_contam_metasim_db/lowH_lowB_totAbund-Empirical.8c9d0e18.fna \
-dbs hsref -i 90 -c 90 -out_dir ../simulated_metagenomes/Hsap_contam_metasim_db/deconseq_output/deconseq_8c9d0e18
echo "finished: " date
