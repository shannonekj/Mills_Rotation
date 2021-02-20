#!/bin/bash
#bmtagger_makeref.sh
# script to make reference human genome for BMTagger
#
#SBATCH --mail-user=sejoslin@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name=bmtagger_makeref
#SBATCH --error=bmtagger_makeref.err
#SBATCH --partition=med
#SBATCH --account=millsgrp

set -e
cwd=$(pwd)

#load modules
module load blast srprism bmtools

#change to BMTagger Directory
cd ../bmtagger/

# run with:
# sbatch -p med -A millsgrp -t 5-36:00:00 --mem MaxMemPerNod bmtagger_makeref.sh

echo "Making index for bmfilter"
date
bmtool -d hs37.fa -o hs37.bitmask -w 18

echo "making index for srprism"
date
srprism mkindex -i hs37.fa -o hs37.srprism -M 7168

echo "Making blast database for blast"
date
makeblastdb -in hs37.fa -dbtype nucl

pwd

