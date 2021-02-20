#!/bin/bash
#unpack_all.sh
#used to unpack all metasim output
#SBATCH --mail-user=sejoslin@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name=unzip_all
#SBATCH --error=unzip_all.err
#SBATCH --partition=med
#SBATCH --account=millsgrp

cwd=$(pwd)

date
echo "unziping highH_highB_totAbund-Empirical.8c74c739.fna.gz"
gunzip ../simulated_metagenomes/Hsap_contam_metasim_db/highH_highB_totAbund-Empirical.8c74c739.fna.gz
echo "done"
date

echo "unzipping highH_lowB_totAbund-Empirical.8c82190a.fna.gz"
gunzip ../simulated_metagenomes/Hsap_contam_metasim_db/highH_lowB_totAbund-Empirical.8c82190a.fna.gz
echo "done"

date

echo "unzippping lowH_highB_totAbund-Empirical.8c8f48af.fna.gz"
gunzip ../simulated_metagenomes/Hsap_contam_metasim_db/lowH_highB_totAbund-Empirical.8c8f48af.fna.gz
echo "done"

date

echo "unzipping lowH_lowB_totAbund-Empirical.8c9d0e18.fna.gz"
gunzip ../simulated_metagenomes/Hsap_contam_metasim_db/lowH_lowB_totAbund-Empirical.8c9d0e18.fna.gz
echo "done"

date
