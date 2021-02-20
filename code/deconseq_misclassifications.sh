#!/bin/bash
#deconseq_misclassifications.sh
# to pull out false positives and false negatives
#
#SBATCH --mail-user=sejoslin@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name=deconseq_misclass
#SBATCH --error=deconseq_misclass.err
#SBATCH --partition=med
#SBATCH --account=millsgrp

set -e

#run with sbatch -p med -A millsgrp -t 1-12:00:00 --mem MaxMemPerNode deconseq_misclassifications.sh

#navigate to the correct directory
cd   ../simulated_metagenomes/Hsap_contam_metasim_db/deconseq_output/

#pull false positives and negative
	## NOTE false negative = human sample positively classified as clean
	## 		false positive = bacterial sample incorrectly classified as contaminated
for i in deconseq_*
do
cd $i
falsepos=$i.FPos
falseneg=$i.FNeg
grep -ni "Homo" *clean.fa > $falseneg
egrep -w 'Bifidobacterium|Streptococcus|Enterococcus|Ruminococcus|Bacteroides|Escherichia|Lactobacillas|Veillonella|Clostridium|Eubacterium' *cont.fa > $falsepos
cd ../
done

