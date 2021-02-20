#!/bin/bash
#bmt_VS_decon.sh
#
#SBATCH --mail-user=sejoslin@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name=bmt_VS_decon
#SBATCH --error=bmt_VS_decon.err
#SBATCH --partition=med
#SBATCH --account=millsgrp
#
# created by Shannon Joslin on 3/13/17
# Script to find intersection of human contaminated reads in evaluation of
#BMTagger and Deconseq.

#Run with
# sbatch -p med -A millsgrp -t 5-03:00:00 --mem MaxMemPerNode bmt_VS_decon.sh

set -e
cd /group/kmkalangrp/SEKJ_work/simulated_metagenomes/Hsap_contam_metasim_db

for i in bmtagger_output/bmtagger_*
do
number=$(echo $i | cut -d_ -f3)
bmfile=$i.human
dedir=deconseq_$number
defile=*_cont.fa
echo "Starting: " $number date
grep -v -n -f $i/$number.human deconseq_output/$dedir/$defile >bmt_decon_compared/$number.match
echo "Finished: " $number date
done

#test
#for i in bmtagger_output/bmtagger_*
#do
#number=$(echo $i | cut -d_ -f3)
#bmfile=$i.human
#dedir=deconseq_$number
#defile=*_cont.fa
#echo $i
#echo $i/$number.human
#echo $dedir
#echo deconseq_output/$dedir/$defile
#echo bmt_decon_compared/$number.match
#done
